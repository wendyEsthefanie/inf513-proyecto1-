--
-- PostgreSQL database dump
--


-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: asignaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.asignaciones (
    id bigint NOT NULL,
    instructor_id bigint NOT NULL,
    grupo_id bigint NOT NULL,
    tarifa_hora numeric(12,2) NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: asignaciones_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.asignaciones_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: asignaciones_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.asignaciones_id_secuencia OWNED BY public.asignaciones.id;


--
-- Name: asistencias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.asistencias (
    id bigint NOT NULL,
    asignacion_id bigint NOT NULL,
    fecha date NOT NULL,
    entrada time(0) without time zone NOT NULL,
    salida time(0) without time zone NOT NULL,
    minutos integer NOT NULL,
    minutos_programados integer NOT NULL,
    cumple_horario boolean NOT NULL,
    observaciones text,
    liquidacion_id bigint,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: asistencias_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.asistencias_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: asistencias_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.asistencias_id_secuencia OWNED BY public.asistencias.id;


--
-- Name: campanas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campanas (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    canal character varying(30) NOT NULL,
    inicio date NOT NULL,
    fin date NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: campanas_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campanas_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: campanas_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campanas_id_secuencia OWNED BY public.campanas.id;


--
-- Name: convenios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.convenios (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    institucion character varying(200) NOT NULL,
    inicio date NOT NULL,
    fin date NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: convenios_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.convenios_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: convenios_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.convenios_id_secuencia OWNED BY public.convenios.id;


--
-- Name: criterios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.criterios (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    peso numeric(8,2) NOT NULL,
    puntuacion_max numeric(8,2) NOT NULL,
    activo boolean NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: criterios_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.criterios_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: criterios_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.criterios_id_secuencia OWNED BY public.criterios.id;


--
-- Name: cursos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cursos (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text NOT NULL,
    costo numeric(12,2) NOT NULL,
    activo boolean NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: cursos_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cursos_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cursos_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cursos_id_secuencia OWNED BY public.cursos.id;


--
-- Name: estudiantes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estudiantes (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    correo_electronico character varying(150) NOT NULL,
    telefono character varying(30) NOT NULL,
    prospecto_id bigint,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: estudiantes_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estudiantes_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estudiantes_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estudiantes_id_secuencia OWNED BY public.estudiantes.id;


--
-- Name: evaluaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluaciones (
    id bigint NOT NULL,
    asignacion_id bigint NOT NULL,
    criterio_id bigint NOT NULL,
    evaluador_id bigint NOT NULL,
    fecha date NOT NULL,
    puntuacion numeric(8,2) NOT NULL,
    observaciones text,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: evaluaciones_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluaciones_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluaciones_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluaciones_id_secuencia OWNED BY public.evaluaciones.id;


--
-- Name: grupos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.grupos (
    id bigint NOT NULL,
    modulo_id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    inicio date NOT NULL,
    fin date NOT NULL,
    cupo integer NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: grupos_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.grupos_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: grupos_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.grupos_id_secuencia OWNED BY public.grupos.id;


--
-- Name: historial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.historial (
    id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    entidad character varying(40) NOT NULL,
    registro_id bigint NOT NULL,
    accion character varying(40) NOT NULL,
    antes json,
    despues json,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: historial_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.historial_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: historial_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.historial_id_secuencia OWNED BY public.historial.id;


--
-- Name: horarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.horarios (
    id bigint NOT NULL,
    asignacion_id bigint NOT NULL,
    dia_semana integer NOT NULL,
    hora_inicio time(0) without time zone NOT NULL,
    hora_fin time(0) without time zone NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: horarios_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.horarios_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: horarios_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.horarios_id_secuencia OWNED BY public.horarios.id;


--
-- Name: liquidaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.liquidaciones (
    id bigint NOT NULL,
    asignacion_id bigint NOT NULL,
    desde date NOT NULL,
    hasta date NOT NULL,
    horas numeric(10,2) NOT NULL,
    tarifa_hora numeric(12,2) NOT NULL,
    total numeric(14,2) NOT NULL,
    estado character varying(20) DEFAULT 'pendiente'::character varying NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: liquidaciones_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.liquidaciones_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: liquidaciones_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.liquidaciones_id_secuencia OWNED BY public.liquidaciones.id;


--
-- Name: matriculas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matriculas (
    id bigint NOT NULL,
    estudiante_id bigint NOT NULL,
    preinscripcion_id bigint NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: matriculas_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.matriculas_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matriculas_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.matriculas_id_secuencia OWNED BY public.matriculas.id;


--
-- Name: migraciones_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE TABLE public.migraciones (
    id integer NOT NULL,
    migracion character varying(255) NOT NULL,
    lote integer NOT NULL,
    CONSTRAINT migraciones_clave_primaria PRIMARY KEY (id)
);

CREATE SEQUENCE public.migraciones_id_secuencia
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.migraciones_id_secuencia OWNED BY public.migraciones.id;
ALTER TABLE public.migraciones ALTER COLUMN id SET DEFAULT nextval('public.migraciones_id_secuencia'::regclass);


--
-- Name: modulos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.modulos (
    id bigint NOT NULL,
    curso_id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    horas integer NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: modulos_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.modulos_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modulos_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.modulos_id_secuencia OWNED BY public.modulos.id;


--
-- Name: oportunidades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oportunidades (
    id bigint NOT NULL,
    prospecto_id bigint NOT NULL,
    curso_id bigint NOT NULL,
    etapa character varying(20) NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: oportunidades_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oportunidades_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oportunidades_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oportunidades_id_secuencia OWNED BY public.oportunidades.id;


--
-- Name: personal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal (
    id bigint NOT NULL,
    usuario_id bigint NOT NULL,
    ci character varying(30) NOT NULL,
    especialidad character varying(200) NOT NULL,
    documentos text NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: personal_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personal_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_id_secuencia OWNED BY public.personal.id;


--
-- Name: preinscripciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.preinscripciones (
    id bigint NOT NULL,
    prospecto_id bigint NOT NULL,
    grupo_id bigint NOT NULL,
    estado character varying(20) NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: preinscripciones_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.preinscripciones_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preinscripciones_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.preinscripciones_id_secuencia OWNED BY public.preinscripciones.id;


--
-- Name: prospectos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prospectos (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    correo_electronico character varying(150) NOT NULL,
    telefono character varying(30) NOT NULL,
    canal character varying(30) NOT NULL,
    campana_id bigint,
    convenio_id bigint,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: prospectos_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prospectos_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prospectos_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prospectos_id_secuencia OWNED BY public.prospectos.id;


--
-- Name: seguimientos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seguimientos (
    id bigint NOT NULL,
    prospecto_id bigint NOT NULL,
    fecha date NOT NULL,
    descripcion text NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: seguimientos_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.seguimientos_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seguimientos_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.seguimientos_id_secuencia OWNED BY public.seguimientos.id;


--
-- Name: solicitudes_correo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.solicitudes_correo (
    clave character varying(64) NOT NULL,
    respuesta json NOT NULL,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: tramites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tramites (
    id bigint NOT NULL,
    estudiante_id bigint NOT NULL,
    tipo character varying(30) NOT NULL,
    estado character varying(30) NOT NULL,
    requisitos text NOT NULL,
    observaciones text,
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: tramites_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tramites_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tramites_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tramites_id_secuencia OWNED BY public.tramites.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuarios (
    id bigint NOT NULL,
    nombre character varying(150) NOT NULL,
    correo_electronico character varying(150) NOT NULL,
    contrasena character varying(255) NOT NULL,
    rol character varying(20) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    token_recordatorio character varying(100),
    fecha_creacion timestamp(0) without time zone,
    fecha_actualizacion timestamp(0) without time zone
);


--
-- Name: usuarios_id_secuencia; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuarios_id_secuencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: usuarios_id_secuencia; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuarios_id_secuencia OWNED BY public.usuarios.id;


--
-- Name: asignaciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignaciones ALTER COLUMN id SET DEFAULT nextval('public.asignaciones_id_secuencia'::regclass);


--
-- Name: asistencias id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencias ALTER COLUMN id SET DEFAULT nextval('public.asistencias_id_secuencia'::regclass);


--
-- Name: campanas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanas ALTER COLUMN id SET DEFAULT nextval('public.campanas_id_secuencia'::regclass);


--
-- Name: convenios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convenios ALTER COLUMN id SET DEFAULT nextval('public.convenios_id_secuencia'::regclass);


--
-- Name: criterios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.criterios ALTER COLUMN id SET DEFAULT nextval('public.criterios_id_secuencia'::regclass);


--
-- Name: cursos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos ALTER COLUMN id SET DEFAULT nextval('public.cursos_id_secuencia'::regclass);


--
-- Name: estudiantes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudiantes ALTER COLUMN id SET DEFAULT nextval('public.estudiantes_id_secuencia'::regclass);


--
-- Name: evaluaciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones ALTER COLUMN id SET DEFAULT nextval('public.evaluaciones_id_secuencia'::regclass);


--
-- Name: grupos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grupos ALTER COLUMN id SET DEFAULT nextval('public.grupos_id_secuencia'::regclass);


--
-- Name: historial id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial ALTER COLUMN id SET DEFAULT nextval('public.historial_id_secuencia'::regclass);


--
-- Name: horarios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios ALTER COLUMN id SET DEFAULT nextval('public.horarios_id_secuencia'::regclass);


--
-- Name: liquidaciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.liquidaciones ALTER COLUMN id SET DEFAULT nextval('public.liquidaciones_id_secuencia'::regclass);


--
-- Name: matriculas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriculas ALTER COLUMN id SET DEFAULT nextval('public.matriculas_id_secuencia'::regclass);


--
-- Name: modulos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulos ALTER COLUMN id SET DEFAULT nextval('public.modulos_id_secuencia'::regclass);


--
-- Name: oportunidades id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidades ALTER COLUMN id SET DEFAULT nextval('public.oportunidades_id_secuencia'::regclass);


--
-- Name: personal id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal ALTER COLUMN id SET DEFAULT nextval('public.personal_id_secuencia'::regclass);


--
-- Name: preinscripciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preinscripciones ALTER COLUMN id SET DEFAULT nextval('public.preinscripciones_id_secuencia'::regclass);


--
-- Name: prospectos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospectos ALTER COLUMN id SET DEFAULT nextval('public.prospectos_id_secuencia'::regclass);


--
-- Name: seguimientos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seguimientos ALTER COLUMN id SET DEFAULT nextval('public.seguimientos_id_secuencia'::regclass);


--
-- Name: tramites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tramites ALTER COLUMN id SET DEFAULT nextval('public.tramites_id_secuencia'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_secuencia'::regclass);


--
-- Name: asignaciones asignaciones_grupo_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignaciones
    ADD CONSTRAINT asignaciones_grupo_id_unico UNIQUE (grupo_id);


--
-- Name: asignaciones asignaciones_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignaciones
    ADD CONSTRAINT asignaciones_clave_primaria PRIMARY KEY (id);


--
-- Name: asistencias asistencias_asignacion_id_fecha_entrada_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencias
    ADD CONSTRAINT asistencias_asignacion_id_fecha_entrada_unico UNIQUE (asignacion_id, fecha, entrada);


--
-- Name: asistencias asistencias_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencias
    ADD CONSTRAINT asistencias_clave_primaria PRIMARY KEY (id);


--
-- Name: campanas campanas_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campanas
    ADD CONSTRAINT campanas_clave_primaria PRIMARY KEY (id);


--
-- Name: convenios convenios_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convenios
    ADD CONSTRAINT convenios_clave_primaria PRIMARY KEY (id);


--
-- Name: criterios criterios_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.criterios
    ADD CONSTRAINT criterios_clave_primaria PRIMARY KEY (id);


--
-- Name: cursos cursos_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cursos
    ADD CONSTRAINT cursos_clave_primaria PRIMARY KEY (id);


--
-- Name: estudiantes estudiantes_correo_electronico_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_correo_electronico_unico UNIQUE (correo_electronico);


--
-- Name: estudiantes estudiantes_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_clave_primaria PRIMARY KEY (id);


--
-- Name: estudiantes estudiantes_prospecto_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_prospecto_id_unico UNIQUE (prospecto_id);


--
-- Name: evaluaciones evaluaciones_asignacion_id_criterio_id_evaluador_id_fecha_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_asignacion_id_criterio_id_evaluador_id_fecha_unico UNIQUE (asignacion_id, criterio_id, evaluador_id, fecha);


--
-- Name: evaluaciones evaluaciones_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_clave_primaria PRIMARY KEY (id);


--
-- Name: grupos grupos_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_clave_primaria PRIMARY KEY (id);


--
-- Name: historial historial_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial
    ADD CONSTRAINT historial_clave_primaria PRIMARY KEY (id);


--
-- Name: horarios horarios_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios
    ADD CONSTRAINT horarios_clave_primaria PRIMARY KEY (id);


--
-- Name: liquidaciones liquidaciones_asignacion_id_desde_hasta_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.liquidaciones
    ADD CONSTRAINT liquidaciones_asignacion_id_desde_hasta_unico UNIQUE (asignacion_id, desde, hasta);


--
-- Name: liquidaciones liquidaciones_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.liquidaciones
    ADD CONSTRAINT liquidaciones_clave_primaria PRIMARY KEY (id);


--
-- Name: matriculas matriculas_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriculas
    ADD CONSTRAINT matriculas_clave_primaria PRIMARY KEY (id);


--
-- Name: matriculas matriculas_preinscripcion_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriculas
    ADD CONSTRAINT matriculas_preinscripcion_id_unico UNIQUE (preinscripcion_id);


--
-- Name: modulos modulos_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulos
    ADD CONSTRAINT modulos_clave_primaria PRIMARY KEY (id);


--
-- Name: oportunidades oportunidades_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidades
    ADD CONSTRAINT oportunidades_clave_primaria PRIMARY KEY (id);


--
-- Name: oportunidades oportunidades_prospecto_id_curso_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidades
    ADD CONSTRAINT oportunidades_prospecto_id_curso_id_unico UNIQUE (prospecto_id, curso_id);


--
-- Name: personal personal_ci_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_ci_unico UNIQUE (ci);


--
-- Name: personal personal_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_clave_primaria PRIMARY KEY (id);


--
-- Name: personal personal_usuario_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_usuario_id_unico UNIQUE (usuario_id);


--
-- Name: preinscripciones preinscripciones_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preinscripciones
    ADD CONSTRAINT preinscripciones_clave_primaria PRIMARY KEY (id);


--
-- Name: preinscripciones preinscripciones_prospecto_id_grupo_id_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preinscripciones
    ADD CONSTRAINT preinscripciones_prospecto_id_grupo_id_unico UNIQUE (prospecto_id, grupo_id);


--
-- Name: prospectos prospectos_correo_electronico_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospectos
    ADD CONSTRAINT prospectos_correo_electronico_unico UNIQUE (correo_electronico);


--
-- Name: prospectos prospectos_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospectos
    ADD CONSTRAINT prospectos_clave_primaria PRIMARY KEY (id);


--
-- Name: seguimientos seguimientos_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seguimientos
    ADD CONSTRAINT seguimientos_clave_primaria PRIMARY KEY (id);


--
-- Name: solicitudes_correo solicitudes_correo_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.solicitudes_correo
    ADD CONSTRAINT solicitudes_correo_clave_primaria PRIMARY KEY (clave);


--
-- Name: tramites tramites_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tramites
    ADD CONSTRAINT tramites_clave_primaria PRIMARY KEY (id);


--
-- Name: usuarios usuarios_correo_electronico_unico; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_electronico_unico UNIQUE (correo_electronico);


--
-- Name: usuarios usuarios_clave_primaria; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_clave_primaria PRIMARY KEY (id);


--
-- Name: asignaciones asignaciones_grupo_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignaciones
    ADD CONSTRAINT asignaciones_grupo_id_clave_foranea FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE RESTRICT;


--
-- Name: asignaciones asignaciones_instructor_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignaciones
    ADD CONSTRAINT asignaciones_instructor_id_clave_foranea FOREIGN KEY (instructor_id) REFERENCES public.usuarios(id) ON DELETE RESTRICT;


--
-- Name: asistencias asistencias_asignacion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencias
    ADD CONSTRAINT asistencias_asignacion_id_clave_foranea FOREIGN KEY (asignacion_id) REFERENCES public.asignaciones(id) ON DELETE RESTRICT;


--
-- Name: asistencias asistencias_liquidacion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asistencias
    ADD CONSTRAINT asistencias_liquidacion_id_clave_foranea FOREIGN KEY (liquidacion_id) REFERENCES public.liquidaciones(id) ON DELETE RESTRICT;


--
-- Name: estudiantes estudiantes_prospecto_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estudiantes
    ADD CONSTRAINT estudiantes_prospecto_id_clave_foranea FOREIGN KEY (prospecto_id) REFERENCES public.prospectos(id) ON DELETE RESTRICT;


--
-- Name: evaluaciones evaluaciones_asignacion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_asignacion_id_clave_foranea FOREIGN KEY (asignacion_id) REFERENCES public.asignaciones(id) ON DELETE RESTRICT;


--
-- Name: evaluaciones evaluaciones_criterio_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_criterio_id_clave_foranea FOREIGN KEY (criterio_id) REFERENCES public.criterios(id) ON DELETE RESTRICT;


--
-- Name: evaluaciones evaluaciones_evaluador_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluaciones
    ADD CONSTRAINT evaluaciones_evaluador_id_clave_foranea FOREIGN KEY (evaluador_id) REFERENCES public.usuarios(id) ON DELETE RESTRICT;


--
-- Name: grupos grupos_modulo_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.grupos
    ADD CONSTRAINT grupos_modulo_id_clave_foranea FOREIGN KEY (modulo_id) REFERENCES public.modulos(id) ON DELETE RESTRICT;


--
-- Name: historial historial_usuario_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historial
    ADD CONSTRAINT historial_usuario_id_clave_foranea FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE RESTRICT;


--
-- Name: horarios horarios_asignacion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.horarios
    ADD CONSTRAINT horarios_asignacion_id_clave_foranea FOREIGN KEY (asignacion_id) REFERENCES public.asignaciones(id) ON DELETE RESTRICT;


--
-- Name: liquidaciones liquidaciones_asignacion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.liquidaciones
    ADD CONSTRAINT liquidaciones_asignacion_id_clave_foranea FOREIGN KEY (asignacion_id) REFERENCES public.asignaciones(id) ON DELETE RESTRICT;


--
-- Name: matriculas matriculas_estudiante_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriculas
    ADD CONSTRAINT matriculas_estudiante_id_clave_foranea FOREIGN KEY (estudiante_id) REFERENCES public.estudiantes(id) ON DELETE RESTRICT;


--
-- Name: matriculas matriculas_preinscripcion_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matriculas
    ADD CONSTRAINT matriculas_preinscripcion_id_clave_foranea FOREIGN KEY (preinscripcion_id) REFERENCES public.preinscripciones(id) ON DELETE RESTRICT;


--
-- Name: modulos modulos_curso_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.modulos
    ADD CONSTRAINT modulos_curso_id_clave_foranea FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE RESTRICT;


--
-- Name: oportunidades oportunidades_curso_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidades
    ADD CONSTRAINT oportunidades_curso_id_clave_foranea FOREIGN KEY (curso_id) REFERENCES public.cursos(id) ON DELETE RESTRICT;


--
-- Name: oportunidades oportunidades_prospecto_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oportunidades
    ADD CONSTRAINT oportunidades_prospecto_id_clave_foranea FOREIGN KEY (prospecto_id) REFERENCES public.prospectos(id) ON DELETE RESTRICT;


--
-- Name: personal personal_usuario_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_usuario_id_clave_foranea FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE RESTRICT;


--
-- Name: preinscripciones preinscripciones_grupo_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preinscripciones
    ADD CONSTRAINT preinscripciones_grupo_id_clave_foranea FOREIGN KEY (grupo_id) REFERENCES public.grupos(id) ON DELETE RESTRICT;


--
-- Name: preinscripciones preinscripciones_prospecto_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.preinscripciones
    ADD CONSTRAINT preinscripciones_prospecto_id_clave_foranea FOREIGN KEY (prospecto_id) REFERENCES public.prospectos(id) ON DELETE RESTRICT;


--
-- Name: prospectos prospectos_campana_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospectos
    ADD CONSTRAINT prospectos_campana_id_clave_foranea FOREIGN KEY (campana_id) REFERENCES public.campanas(id) ON DELETE RESTRICT;


--
-- Name: prospectos prospectos_convenio_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prospectos
    ADD CONSTRAINT prospectos_convenio_id_clave_foranea FOREIGN KEY (convenio_id) REFERENCES public.convenios(id) ON DELETE RESTRICT;


--
-- Name: seguimientos seguimientos_prospecto_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seguimientos
    ADD CONSTRAINT seguimientos_prospecto_id_clave_foranea FOREIGN KEY (prospecto_id) REFERENCES public.prospectos(id) ON DELETE RESTRICT;


--
-- Name: tramites tramites_estudiante_id_clave_foranea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tramites
    ADD CONSTRAINT tramites_estudiante_id_clave_foranea FOREIGN KEY (estudiante_id) REFERENCES public.estudiantes(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--
