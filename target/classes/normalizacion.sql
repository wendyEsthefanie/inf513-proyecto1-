-- Ajuste compatible con datos existentes; se ejecuta dentro de una transaccion.
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='matriculas' AND column_name='grupo_id') THEN
        IF EXISTS (SELECT 1 FROM public.matriculas m JOIN public.preinscripciones p ON p.id=m.preinscripcion_id WHERE m.grupo_id<>p.grupo_id) THEN
            RAISE EXCEPTION 'Matriculas con grupos inconsistentes; revise los datos antes de normalizar';
        END IF;
        ALTER TABLE public.matriculas DROP COLUMN grupo_id;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='evaluaciones' AND column_name='peso') THEN
        IF EXISTS (SELECT 1 FROM public.evaluaciones e JOIN public.criterios c ON c.id=e.criterio_id WHERE e.peso<>c.peso OR e.puntuacion_max<>c.puntuacion_max) THEN
            RAISE EXCEPTION 'Criterios historicos diferentes; revise los datos antes de normalizar';
        END IF;
        ALTER TABLE public.evaluaciones DROP COLUMN peso, DROP COLUMN puntuacion_max;
    END IF;
END $$;

CREATE OR REPLACE FUNCTION public.proteger_criterio_evaluado() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF (NEW.peso<>OLD.peso OR NEW.puntuacion_max<>OLD.puntuacion_max)
       AND EXISTS (SELECT 1 FROM public.evaluaciones WHERE criterio_id=OLD.id) THEN
        RAISE EXCEPTION 'Un criterio evaluado conserva peso y escala' USING ERRCODE='23514';
    END IF;
    RETURN NEW;
END $$;
DROP TRIGGER IF EXISTS criterio_evaluado ON public.criterios;
CREATE TRIGGER criterio_evaluado BEFORE UPDATE ON public.criterios
FOR EACH ROW EXECUTE FUNCTION public.proteger_criterio_evaluado();
