-- Renombrado transaccional e idempotente, sin eliminar registros.
CREATE OR REPLACE FUNCTION pg_temp.nombre_en_espanol(nombre text) RETURNS text
LANGUAGE sql IMMUTABLE AS $$
    SELECT replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(nombre,
        'email','correo_electronico'),'password','contrasena'),'remember_token','token_recordatorio'),
        'created_at','fecha_creacion'),'updated_at','fecha_actualizacion'),'migrations','migraciones'),
        '_unique','_unico'),'_uniqu','_unico'),'_pkey','_clave_primaria'),'_foreign','_clave_foranea'),'_seq','_secuencia');
$$;
DO $$
DECLARE
    columna record;
    objeto record;
    nuevo_nombre text;
BEGIN
    IF to_regclass('public.migrations') IS NOT NULL THEN
        ALTER TABLE public.migrations RENAME TO migraciones;
    END IF;
    FOR columna IN
        SELECT c.table_name, c.column_name, traduccion.nuevo
        FROM information_schema.columns c
        JOIN (VALUES ('email','correo_electronico'), ('password','contrasena'),
            ('remember_token','token_recordatorio'), ('created_at','fecha_creacion'),
            ('updated_at','fecha_actualizacion'),('migration','migracion'),('batch','lote')) traduccion(anterior,nuevo)
        ON c.column_name=traduccion.anterior
        WHERE c.table_schema='public'
    LOOP
        EXECUTE format('ALTER TABLE public.%I RENAME COLUMN %I TO %I',
            columna.table_name,columna.column_name,columna.nuevo);
    END LOOP;
    FOR objeto IN
        SELECT t.relname AS tabla,c.conname AS nombre
        FROM pg_constraint c JOIN pg_class t ON t.oid=c.conrelid
        JOIN pg_namespace n ON n.oid=t.relnamespace
        WHERE n.nspname='public'
    LOOP
        nuevo_nombre=pg_temp.nombre_en_espanol(objeto.nombre);
        IF nuevo_nombre<>objeto.nombre THEN
            EXECUTE format('ALTER TABLE public.%I RENAME CONSTRAINT %I TO %I',objeto.tabla,objeto.nombre,nuevo_nombre);
        END IF;
    END LOOP;
    FOR objeto IN SELECT indexname AS nombre FROM pg_indexes WHERE schemaname='public'
    LOOP
        nuevo_nombre=pg_temp.nombre_en_espanol(objeto.nombre);
        IF nuevo_nombre<>objeto.nombre THEN
            EXECUTE format('ALTER INDEX public.%I RENAME TO %I',objeto.nombre,nuevo_nombre);
        END IF;
    END LOOP;
    FOR objeto IN SELECT c.relname AS nombre FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
        WHERE n.nspname='public' AND c.relkind='S'
    LOOP
        nuevo_nombre=pg_temp.nombre_en_espanol(objeto.nombre);
        IF nuevo_nombre<>objeto.nombre THEN
            EXECUTE format('ALTER SEQUENCE public.%I RENAME TO %I',objeto.nombre,nuevo_nombre);
        END IF;
    END LOOP;
END $$;

-- Solo se traducen claves JSON; los valores y el orden de las listas se conservan.
CREATE OR REPLACE FUNCTION pg_temp.campos_en_espanol(dato jsonb) RETURNS jsonb
LANGUAGE plpgsql AS $$
DECLARE resultado jsonb;
BEGIN
    IF jsonb_typeof(dato)='object' THEN
        SELECT COALESCE(jsonb_object_agg(CASE clave
            WHEN 'email' THEN 'correo_electronico' WHEN 'password' THEN 'contrasena'
            WHEN 'remember_token' THEN 'token_recordatorio' WHEN 'created_at' THEN 'fecha_creacion'
            WHEN 'updated_at' THEN 'fecha_actualizacion' ELSE clave END,
            pg_temp.campos_en_espanol(valor)),'{}'::jsonb)
        INTO resultado FROM jsonb_each(dato) AS campos(clave,valor);
        RETURN resultado;
    ELSIF jsonb_typeof(dato)='array' THEN
        SELECT COALESCE(jsonb_agg(pg_temp.campos_en_espanol(valor) ORDER BY orden),'[]'::jsonb)
        INTO resultado FROM jsonb_array_elements(dato) WITH ORDINALITY AS elementos(valor,orden);
        RETURN resultado;
    END IF;
    RETURN dato;
END $$;

UPDATE public.historial SET antes=pg_temp.campos_en_espanol(antes::jsonb)::json
WHERE antes::text ~ '"(email|password|remember_token|created_at|updated_at)"\s*:';
UPDATE public.historial SET despues=pg_temp.campos_en_espanol(despues::jsonb)::json
WHERE despues::text ~ '"(email|password|remember_token|created_at|updated_at)"\s*:';
UPDATE public.solicitudes_correo SET respuesta=pg_temp.campos_en_espanol(respuesta::jsonb)::json
WHERE respuesta::text ~ '"(email|password|remember_token|created_at|updated_at)"\s*:';
