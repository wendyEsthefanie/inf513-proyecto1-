-- Se ejecuta dentro de la transaccion de inicializacion de BaseDatos.
DO $$ BEGIN
    IF to_regclass('public.pagos_checkout') IS NOT NULL AND to_regclass('public.pagos') IS NOT NULL THEN
        RAISE EXCEPTION 'Existen pagos y pagos_checkout simultaneamente. Revise los datos antes de migrar; no se fusionan automaticamente.';
    END IF;
    IF to_regclass('public.pagos_checkout') IS NOT NULL AND to_regclass('public.pagos') IS NULL THEN
        ALTER TABLE public.pagos_checkout RENAME TO pagos;
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS public.pagos (
    pedido_id varchar(120) PRIMARY KEY,
    correo_electronico varchar(150) NOT NULL,
    monto numeric(12,2) NOT NULL,
    estado varchar(20) NOT NULL DEFAULT 'PENDIENTE',
    confirmacion varchar(20) NOT NULL DEFAULT 'PENDIENTE',
    fecha_creacion timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='pagos' AND column_name='correo') THEN
        ALTER TABLE public.pagos RENAME COLUMN correo TO correo_electronico;
    END IF;
END $$;

ALTER TABLE public.solicitudes_correo ADD COLUMN IF NOT EXISTS usuario_id bigint REFERENCES public.usuarios(id) ON DELETE RESTRICT;
ALTER TABLE public.solicitudes_correo ADD COLUMN IF NOT EXISTS autoria_pendiente boolean NOT NULL DEFAULT true;
UPDATE public.solicitudes_correo SET autoria_pendiente=false WHERE usuario_id IS NOT NULL;
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.solicitudes_correo'::regclass AND conname='solicitudes_autoria_coherente') THEN
        ALTER TABLE public.solicitudes_correo ADD CONSTRAINT solicitudes_autoria_coherente CHECK (autoria_pendiente=(usuario_id IS NULL));
    END IF;
END $$;
ALTER TABLE public.solicitudes_correo ALTER COLUMN autoria_pendiente SET DEFAULT false;
CREATE INDEX IF NOT EXISTS solicitudes_correo_usuario ON public.solicitudes_correo(usuario_id);
-- Las solicitudes historicas solo guardaban un hash: no se inventa su autor.

ALTER TABLE public.pagos ADD COLUMN IF NOT EXISTS usuario_id bigint REFERENCES public.usuarios(id) ON DELETE RESTRICT;
ALTER TABLE public.pagos ADD COLUMN IF NOT EXISTS estudiante_id bigint REFERENCES public.estudiantes(id) ON DELETE RESTRICT;
ALTER TABLE public.pagos ADD COLUMN IF NOT EXISTS matricula_id bigint;
ALTER TABLE public.pagos ADD COLUMN IF NOT EXISTS tramite_id bigint;
ALTER TABLE public.pagos ADD COLUMN IF NOT EXISTS pendiente_vinculacion boolean NOT NULL DEFAULT true;
UPDATE public.pagos p SET usuario_id=u.id FROM public.usuarios u
 WHERE p.usuario_id IS NULL AND lower(p.correo_electronico)=lower(u.correo_electronico);

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.matriculas'::regclass AND conname='matriculas_id_estudiante_unico') THEN
        ALTER TABLE public.matriculas ADD CONSTRAINT matriculas_id_estudiante_unico UNIQUE(id,estudiante_id);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.tramites'::regclass AND conname='tramites_id_estudiante_unico') THEN
        ALTER TABLE public.tramites ADD CONSTRAINT tramites_id_estudiante_unico UNIQUE(id,estudiante_id);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.pagos'::regclass AND conname='pagos_matricula_estudiante_relacion') THEN
        ALTER TABLE public.pagos ADD CONSTRAINT pagos_matricula_estudiante_relacion FOREIGN KEY(matricula_id,estudiante_id) REFERENCES public.matriculas(id,estudiante_id) ON DELETE RESTRICT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.pagos'::regclass AND conname='pagos_tramite_estudiante_relacion') THEN
        ALTER TABLE public.pagos ADD CONSTRAINT pagos_tramite_estudiante_relacion FOREIGN KEY(tramite_id,estudiante_id) REFERENCES public.tramites(id,estudiante_id) ON DELETE RESTRICT;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.pagos'::regclass AND conname='pagos_concepto_coherente') THEN
        ALTER TABLE public.pagos ADD CONSTRAINT pagos_concepto_coherente CHECK (
            (pendiente_vinculacion AND matricula_id IS NULL AND tramite_id IS NULL AND estudiante_id IS NULL)
            OR (NOT pendiente_vinculacion AND usuario_id IS NOT NULL AND estudiante_id IS NOT NULL
                AND num_nonnulls(matricula_id,tramite_id)=1));
    END IF;
END $$;
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid='public.pagos'::regclass AND conname='pagos_checkout_pkey') THEN
        ALTER TABLE public.pagos RENAME CONSTRAINT pagos_checkout_pkey TO pagos_clave_primaria;
    END IF;
END $$;
ALTER TABLE public.pagos ALTER COLUMN pendiente_vinculacion SET DEFAULT false;
CREATE INDEX IF NOT EXISTS pagos_usuario ON public.pagos(usuario_id);
CREATE INDEX IF NOT EXISTS pagos_estudiante ON public.pagos(estudiante_id);
CREATE INDEX IF NOT EXISTS pagos_matricula ON public.pagos(matricula_id);
CREATE INDEX IF NOT EXISTS pagos_tramite ON public.pagos(tramite_id);
