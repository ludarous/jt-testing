--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

-- Started on 2019-01-29 07:29:15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 210 (class 1259 OID 60442)
-- Name: activity; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    help character varying(255),
    jhi_key character varying(255),
    primary_result_value_unit character varying(255) NOT NULL,
    secondary_result_value_unit character varying(255),
    min_age integer,
    max_age integer,
    primary_result_type character varying(255),
    secondary_result_type character varying(255),
    author_id bigint,
    creation_time timestamp without time zone,
    group_id bigint
);


ALTER TABLE public.activity OWNER TO "jt-testing";

--
-- TOC entry 211 (class 1259 OID 60450)
-- Name: activity_categories; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_categories (
    categories_id bigint NOT NULL,
    activities_id bigint NOT NULL
);


ALTER TABLE public.activity_categories OWNER TO "jt-testing";

--
-- TOC entry 213 (class 1259 OID 60463)
-- Name: activity_category; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_key character varying(255),
    description character varying(255),
    parent_id bigint
);


ALTER TABLE public.activity_category OWNER TO "jt-testing";

--
-- TOC entry 225 (class 1259 OID 76902)
-- Name: activity_group; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_group (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    min_age integer,
    max_age integer
);


ALTER TABLE public.activity_group OWNER TO "jt-testing";

--
-- TOC entry 226 (class 1259 OID 76910)
-- Name: activity_group_activities; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_group_activities (
    activities_id bigint NOT NULL,
    activity_groups_id bigint NOT NULL
);


ALTER TABLE public.activity_group_activities OWNER TO "jt-testing";

--
-- TOC entry 227 (class 1259 OID 76915)
-- Name: activity_group_activity_group_categories; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_group_activity_group_categories (
    activity_group_categories_id bigint NOT NULL,
    activity_groups_id bigint NOT NULL
);


ALTER TABLE public.activity_group_activity_group_categories OWNER TO "jt-testing";

--
-- TOC entry 224 (class 1259 OID 76894)
-- Name: activity_group_category; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_group_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_key character varying(255),
    description character varying(255)
);


ALTER TABLE public.activity_group_category OWNER TO "jt-testing";

--
-- TOC entry 216 (class 1259 OID 60481)
-- Name: activity_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.activity_result (
    id bigint NOT NULL,
    primary_result_value real,
    secondary_result_value real,
    note character varying(255),
    test_result_id bigint,
    activity_id bigint NOT NULL,
    event_date timestamp without time zone,
    event_id bigint,
    person_birth_date timestamp without time zone,
    person_id bigint,
    test_id bigint
);


ALTER TABLE public.activity_result OWNER TO "jt-testing";

--
-- TOC entry 219 (class 1259 OID 60503)
-- Name: address; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.address (
    id bigint NOT NULL,
    country character varying(255),
    city character varying(255),
    street character varying(255),
    zip_code character varying(255)
);


ALTER TABLE public.address OWNER TO "jt-testing";

--
-- TOC entry 197 (class 1259 OID 60351)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO "jt-testing";

--
-- TOC entry 196 (class 1259 OID 60346)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO "jt-testing";

--
-- TOC entry 204 (class 1259 OID 60409)
-- Name: event; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.event (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_date timestamp without time zone,
    address_id bigint,
    max_age integer,
    min_age integer
);


ALTER TABLE public.event OWNER TO "jt-testing";

--
-- TOC entry 221 (class 1259 OID 60620)
-- Name: event_attached_persons; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.event_attached_persons (
    events_id bigint NOT NULL,
    attached_persons_id bigint NOT NULL
);


ALTER TABLE public.event_attached_persons OWNER TO "jt-testing";

--
-- TOC entry 214 (class 1259 OID 60471)
-- Name: event_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.event_result (
    id bigint NOT NULL,
    note character varying(255),
    actual_height_in_cm real,
    actual_weight_in_kg real,
    event_id bigint,
    person_id bigint NOT NULL
);


ALTER TABLE public.event_result OWNER TO "jt-testing";

--
-- TOC entry 205 (class 1259 OID 60414)
-- Name: event_tests; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.event_tests (
    tests_id bigint NOT NULL,
    events_id bigint NOT NULL
);


ALTER TABLE public.event_tests OWNER TO "jt-testing";

--
-- TOC entry 198 (class 1259 OID 60357)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: jt-testing
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO "jt-testing";

--
-- TOC entry 200 (class 1259 OID 60372)
-- Name: jhi_authority; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_authority (
    name character varying(50) NOT NULL
);


ALTER TABLE public.jhi_authority OWNER TO "jt-testing";

--
-- TOC entry 222 (class 1259 OID 76848)
-- Name: jhi_group; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_group (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    parent_id bigint
);


ALTER TABLE public.jhi_group OWNER TO "jt-testing";

--
-- TOC entry 202 (class 1259 OID 60392)
-- Name: jhi_persistent_audit_event; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_persistent_audit_event (
    event_id bigint NOT NULL,
    principal character varying(50) NOT NULL,
    event_date timestamp without time zone,
    event_type character varying(255)
);


ALTER TABLE public.jhi_persistent_audit_event OWNER TO "jt-testing";

--
-- TOC entry 203 (class 1259 OID 60397)
-- Name: jhi_persistent_audit_evt_data; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_persistent_audit_evt_data (
    event_id bigint NOT NULL,
    name character varying(150) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.jhi_persistent_audit_evt_data OWNER TO "jt-testing";

--
-- TOC entry 199 (class 1259 OID 60359)
-- Name: jhi_user; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_user (
    id bigint NOT NULL,
    login character varying(50) NOT NULL,
    password_hash character varying(60) NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(254),
    image_url character varying(256),
    activated boolean NOT NULL,
    lang_key character varying(6),
    activation_key character varying(20),
    reset_key character varying(20),
    created_by character varying(50) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    reset_date timestamp without time zone,
    last_modified_by character varying(50),
    last_modified_date timestamp without time zone
);


ALTER TABLE public.jhi_user OWNER TO "jt-testing";

--
-- TOC entry 201 (class 1259 OID 60377)
-- Name: jhi_user_authority; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jhi_user_authority (
    user_id bigint NOT NULL,
    authority_name character varying(50) NOT NULL
);


ALTER TABLE public.jhi_user_authority OWNER TO "jt-testing";

--
-- TOC entry 206 (class 1259 OID 60419)
-- Name: jt_test; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jt_test (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    max_age integer,
    min_age integer
);


ALTER TABLE public.jt_test OWNER TO "jt-testing";

--
-- TOC entry 207 (class 1259 OID 60427)
-- Name: jttest_activities; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jttest_activities (
    activities_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE public.jttest_activities OWNER TO "jt-testing";

--
-- TOC entry 208 (class 1259 OID 60432)
-- Name: jttest_categories; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jttest_categories (
    categories_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE public.jttest_categories OWNER TO "jt-testing";

--
-- TOC entry 209 (class 1259 OID 60437)
-- Name: jttest_sports; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.jttest_sports (
    sports_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE public.jttest_sports OWNER TO "jt-testing";

--
-- TOC entry 217 (class 1259 OID 60486)
-- Name: person; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.person (
    id bigint NOT NULL,
    personal_data_id bigint,
    address_id bigint,
    user_id bigint,
    email character varying(255) NOT NULL,
    virtual boolean NOT NULL
);


ALTER TABLE public.person OWNER TO "jt-testing";

--
-- TOC entry 223 (class 1259 OID 76858)
-- Name: person_group; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.person_group (
    id bigint NOT NULL,
    group_role character varying(255) NOT NULL,
    person_id bigint NOT NULL,
    group_id bigint NOT NULL
);


ALTER TABLE public.person_group OWNER TO "jt-testing";

--
-- TOC entry 218 (class 1259 OID 60495)
-- Name: personal_data; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.personal_data (
    id bigint NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    birth_date timestamp without time zone NOT NULL,
    nationality character varying(255)
);


ALTER TABLE public.personal_data OWNER TO "jt-testing";

--
-- TOC entry 220 (class 1259 OID 60511)
-- Name: sport; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.sport (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.sport OWNER TO "jt-testing";

--
-- TOC entry 212 (class 1259 OID 60455)
-- Name: test_category; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.test_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_key character varying(255),
    description character varying(255)
);


ALTER TABLE public.test_category OWNER TO "jt-testing";

--
-- TOC entry 215 (class 1259 OID 60476)
-- Name: test_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE public.test_result (
    id bigint NOT NULL,
    note character varying(255),
    event_result_id bigint,
    test_id bigint NOT NULL
);


ALTER TABLE public.test_result OWNER TO "jt-testing";

--
-- TOC entry 3045 (class 0 OID 60442)
-- Dependencies: 210
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity (id, name, description, help, jhi_key, primary_result_value_unit, secondary_result_value_unit, min_age, max_age, primary_result_type, secondary_result_type, author_id, creation_time, group_id) FROM stdin;
5251	Jít na povel a pak zpět	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5253	Stoj na jedné noze	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5252	Zavázání boty	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5254	Skok na jednu nohu	Cvičenec skočí ze stoje na jednu nohu a snaží se co nejdéle vydržet, aniž by se druhou nohou dotkl země	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5256	Letmý start	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5255	Běh 5 metrů	\N	\N	\N	SECONDS	\N	\N	\N	\N	\N	\N	\N	\N
5257	Překážková dráha	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5258	Házet tenisákem a kopat do míče	\N	\N	\N	COUNTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5259	Nožičky	\N	\N	\N	COUNTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5260	Tři míče a vybere a zakončí	\N	\N	\N	SECONDS	GOALS	\N	\N	\N	\N	\N	\N	\N
5261	Lowa brace test	\N	\N	\N	SECONDS	COUNTS	\N	\N	\N	\N	\N	\N	\N
5263	Švihadlo - levá, pravá, obě	\N	\N	\N	SECONDS	COUNTS	\N	\N	\N	\N	\N	\N	\N
5264	Hod míčem 2ks	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5265	Skok daleký	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5266	Kliky	\N	\N	\N	COUNTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5267	Skok vysoký	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5268	běh 50 metrů	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5269	slalom	\N	\N	\N	SECONDS	\N	\N	\N	\N	\N	\N	\N	\N
5270	Člunkový běh	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5271	Běh 1000 metrů	\N	\N	\N	SECONDS	MINUTES	\N	\N	\N	\N	\N	\N	\N
5272	Předklon	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5273	Úklon	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5274	Hod pytlíkem do díry - San Simeon	\N	\N	\N	COUNTS	PERCENTS	\N	\N	\N	\N	\N	\N	\N
5275	Výdrž ve sporu	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5276	Slalom s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5277	Běh 50 metrů s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5278	Člunkový běh s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5279	Žebřík s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5280	Výskok s míčem	\N	\N	\N	CENTIMETERS	POINTS	\N	\N	\N	\N	\N	\N	\N
5281	Basketbal - střelba z místa	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5282	Basketbal - střelba z pohybu	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5283	Basketbal - střelba z různých přihrávek	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5351	Basketbal - střelba zleva	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5284	Basketbal - střelba zprava	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5352	Basketbal - střelba po otočce 360°	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5353	Basketbal - střelba slabší rukou	\N	\N	\N	POINTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5354	Basketbal - sebrat míč ze země a vystřelit	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5355	Basketbal - driblink levou - lajny	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5356	Basketbal - driblink pravou - lajny	\N	\N	\N	SECONDS	COUNTS	\N	\N	\N	\N	\N	\N	\N
5357	Basketbal - slalom s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5358	Basketbal - slalom s míčem a kopaní do teisového	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5359	Basketbal - 50m s míčem	\N	\N	\N	SECONDS	\N	\N	\N	\N	\N	\N	\N	\N
5360	Basketbal - 50m s míčem slabší rukou	\N	\N	\N	SECONDS	\N	\N	\N	\N	\N	\N	\N	\N
5361	Basketbal - přihrávka z místa	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5362	Basketbal - přihrávka v pohybu	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5363	Basketbal - 5 kroků vpřed + střelba	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5364	Basketbal - 5 kroků vpřed poslepu + střelba	\N	\N	\N	SECONDS	POINTS	\N	\N	\N	\N	\N	\N	\N
5365	Basketbal - modifikovaný eurostep	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5366	Basketbal - dvoutakt se dvěma míči	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5367	Basketbal - střelba s obráncem	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5368	Basketbal - střelba bez obránce	\N	\N	\N	POINTS	\N	\N	\N	\N	\N	\N	\N	\N
5369	Basketbal - proběhnout kužely	\N	\N	\N	SECONDS	\N	\N	\N	\N	\N	\N	\N	\N
6701	Dřepy	\N	\N	\N	COUNTS	SECONDS	\N	\N	\N	\N	\N	\N	\N
5262	Žebřík	\N	\N	\N	SECONDS	COUNTS	\N	\N	MORE_IS_BETTER	MORE_IS_BETTER	\N	\N	\N
83951	Test	\N	\N	\N	SECONDS	CENTIMETERS	\N	\N	LESS_IS_BETTER	MORE_IS_BETTER	84101	2019-01-28 12:06:09.551	\N
\.


--
-- TOC entry 3046 (class 0 OID 60450)
-- Dependencies: 211
-- Data for Name: activity_categories; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_categories (categories_id, activities_id) FROM stdin;
5301	5251
5302	5252
5302	5253
5303	5254
5304	5255
5304	5256
5305	5257
5316	5258
5305	5258
5316	5259
5306	5260
5307	5261
5308	5262
5308	5263
5309	5264
5309	5265
5309	5266
5310	5267
5311	5268
5311	5269
5311	5270
5312	5271
5313	5272
5313	5273
5314	5274
5317	5275
5315	5276
5315	5277
5315	5278
5315	5279
5315	5280
5318	5281
5318	5282
5318	5283
5318	5284
5318	5351
5318	5352
5318	5353
5318	5354
5318	5355
5318	5356
5318	5357
5318	5358
5318	5359
5318	5360
5318	5362
5318	5363
5318	5364
5318	5365
5318	5366
5318	5367
5318	5368
5318	5369
5309	6701
5309	83951
\.


--
-- TOC entry 3048 (class 0 OID 60463)
-- Dependencies: 213
-- Data for Name: activity_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_category (id, name, jhi_key, description, parent_id) FROM stdin;
5309	síla	\N	\N	\N
5311	rychlost	\N	\N	\N
5312	vytrvalost	\N	\N	\N
5313	pohyblivost	\N	\N	\N
5314	dovednost	\N	\N	\N
5315	s míčem	\N	\N	\N
5317	core	\N	\N	\N
5318	basketbal	\N	\N	\N
6951	koordinace	\N	\N	\N
5301	koordinace - test prostorové orientace	\N	\N	6951
5302	koordinace - rovnováha - statická	\N	\N	6951
5303	koordinace - rovnováha - dynamická	\N	\N	6951
5304	koordinace - reakční	\N	\N	6951
5305	koordinace - schopnost spojování pohybů	\N	\N	6951
5306	koordinace - schopnost přizpůsobování	\N	\N	6951
5307	koordinace - učenlivost	\N	\N	6951
5308	koordinace - rytmická	\N	\N	6951
5310	síla - dynamická	\N	\N	5309
5316	koordinace - rozlišení polohy a pohybu jednotlivých čátsí těla	\N	\N	6951
79051	Kategorie A	\N	\N	5318
79054	Síla dynamická jiná	\N	\N	5310
79059	Ahoj	\N	\N	5310
\.


--
-- TOC entry 3060 (class 0 OID 76902)
-- Dependencies: 225
-- Data for Name: activity_group; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_group (id, name, description, min_age, max_age) FROM stdin;
84251	Skupina aktivit	\N	\N	\N
\.


--
-- TOC entry 3061 (class 0 OID 76910)
-- Dependencies: 226
-- Data for Name: activity_group_activities; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_group_activities (activities_id, activity_groups_id) FROM stdin;
5251	84251
5253	84251
\.


--
-- TOC entry 3062 (class 0 OID 76915)
-- Dependencies: 227
-- Data for Name: activity_group_activity_group_categories; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_group_activity_group_categories (activity_group_categories_id, activity_groups_id) FROM stdin;
84201	84251
\.


--
-- TOC entry 3059 (class 0 OID 76894)
-- Dependencies: 224
-- Data for Name: activity_group_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_group_category (id, name, jhi_key, description) FROM stdin;
84201	Skupina aktivit	\N	\N
\.


--
-- TOC entry 3051 (class 0 OID 60481)
-- Dependencies: 216
-- Data for Name: activity_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.activity_result (id, primary_result_value, secondary_result_value, note, test_result_id, activity_id, event_date, event_id, person_birth_date, person_id, test_id) FROM stdin;
83051	53	35	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 6 let úroveň 0	82626	5283	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83052	84	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	82626	5251	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83053	21	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	82626	5279	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83054	36	44	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 6 let úroveň 0	82626	5284	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83055	69	31	Poznámka k aktivitě Úklon. Osooba: 6 let úroveň 0	82626	5273	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83056	26	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 6 let úroveň 0	82626	5255	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83057	41	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	82626	5258	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83058	47	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	82626	5263	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83059	29	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	82626	5264	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83060	96	43	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	82626	5265	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83061	59	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	82626	5274	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83062	46	39	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 6 let úroveň 0	82626	5278	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83063	46	40	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	82626	5267	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83064	54	34	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	82626	5268	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83065	70	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	82626	5275	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83066	27	46	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	82626	5271	2019-01-26 10:25:40	82102	2012-07-01 14:55:15.66	6401	82051
83067	35	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 7 let úroveň 0	82627	5255	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83068	45	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	82627	5251	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83069	22	44	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 7 let úroveň 0	82627	5283	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83070	51	50	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 7 let úroveň 0	82627	5284	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83071	54	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	82627	5258	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83072	37	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	82627	5274	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83073	28	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	82627	5263	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83074	55	42	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 7 let úroveň 0	82627	5278	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83075	80	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	82627	5279	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83076	96	34	Poznámka k aktivitě Úklon. Osooba: 7 let úroveň 0	82627	5273	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83077	59	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	82627	5275	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83078	22	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	82627	5264	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83079	64	43	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	82627	5265	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83080	54	50	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	82627	5267	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83081	78	43	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	82627	5268	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83082	81	50	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	82627	5271	2019-01-26 10:25:40	82102	2011-07-01 14:55:15.854	6403	82051
83083	86	40	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Jan Selinger	82628	5284	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83084	52	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	82628	5251	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83085	52	45	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Jan Selinger	82628	5283	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83086	54	34	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	82628	5279	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83087	24	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Jan Selinger	82628	5255	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83088	46	49	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Jan Selinger	82628	5278	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83089	69	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	82628	5275	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83090	48	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	82628	5258	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83091	42	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	82628	5263	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83092	76	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	82628	5264	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83093	94	44	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	82628	5265	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83094	41	50	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	82628	5267	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83095	69	30	Poznámka k aktivitě Úklon. Osooba: Jan Selinger	82628	5273	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83096	40	43	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	82628	5268	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83097	54	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	82628	5271	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83098	71	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	82628	5274	2019-01-26 10:25:40	82102	2018-11-16 14:04:58.205	2901	82051
83099	53	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	82629	5251	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83100	81	45	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 8 let úroveň 0	82629	5283	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83101	62	43	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 8 let úroveň 0	82629	5284	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83102	85	42	Poznámka k aktivitě Úklon. Osooba: 8 let úroveň 0	82629	5273	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83103	30	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 8 let úroveň 0	82629	5255	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83104	92	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	82629	5279	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83105	53	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	82629	5258	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83106	38	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	82629	5263	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83107	30	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	82629	5264	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83108	65	45	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 8 let úroveň 0	82629	5278	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83109	37	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	82629	5275	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83110	40	32	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	82629	5265	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83111	99	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	82629	5274	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83112	65	34	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	82629	5267	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83113	31	33	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	82629	5268	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83114	27	48	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	82629	5271	2019-01-26 10:25:40	82102	2010-07-01 14:55:15.934	6405	82051
83115	62	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rouss	82630	5264	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83116	100	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rouss	82630	5251	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83117	37	47	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Luděk Rouss	82630	5283	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83118	87	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rouss	82630	5274	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83119	66	40	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Luděk Rouss	82630	5284	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83120	91	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Luděk Rouss	82630	5255	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83121	33	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rouss	82630	5258	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83122	50	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rouss	82630	5263	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83123	56	43	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rouss	82630	5265	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83124	25	49	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rouss	82630	5267	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83125	23	31	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rouss	82630	5268	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83126	51	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rouss	82630	5275	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83127	30	47	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rouss	82630	5279	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83128	54	47	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rouss	82630	5271	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83129	71	40	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Luděk Rouss	82630	5278	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83130	66	45	Poznámka k aktivitě Úklon. Osooba: Luděk Rouss	82630	5273	2019-01-26 10:25:40	82102	1985-11-01 00:00:00	80502	82051
83131	72	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	82631	5251	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83132	46	34	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 6 let úroveň 0	82631	5283	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83133	92	49	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 6 let úroveň 0	82631	5284	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83134	70	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 6 let úroveň 0	82631	5255	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83135	31	36	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 6 let úroveň 0	82631	5278	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83136	72	42	Poznámka k aktivitě Úklon. Osooba: 6 let úroveň 0	82631	5273	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83137	36	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	82631	5258	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83138	99	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	82631	5274	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83139	53	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	82631	5263	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83140	32	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	82631	5264	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83141	20	44	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	82631	5265	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83142	96	34	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	82631	5267	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83143	69	40	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	82631	5268	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83144	43	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	82631	5271	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83145	56	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	82631	5275	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83146	22	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	82631	5279	2019-01-27 10:25:58	82103	2012-07-01 14:55:15.66	6401	82051
83147	92	31	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 7 let úroveň 0	82632	5283	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83148	41	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	82632	5251	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83149	33	30	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 7 let úroveň 0	82632	5284	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83150	54	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 7 let úroveň 0	82632	5255	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83151	57	35	Poznámka k aktivitě Úklon. Osooba: 7 let úroveň 0	82632	5273	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83152	23	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	82632	5275	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83153	49	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	82632	5279	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83154	77	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	82632	5258	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83155	75	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	82632	5263	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83156	90	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	82632	5264	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83157	42	30	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	82632	5265	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83158	69	47	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	82632	5267	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83159	55	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	82632	5274	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83160	52	37	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	82632	5268	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83161	89	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	82632	5271	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83162	93	40	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 7 let úroveň 0	82632	5278	2019-01-27 10:25:58	82103	2011-07-01 14:55:15.854	6403	82051
83163	83	44	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Jan Selinger	82633	5284	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83164	55	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	82633	5251	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83165	29	36	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Jan Selinger	82633	5283	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83166	72	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Jan Selinger	82633	5255	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83167	74	49	Poznámka k aktivitě Úklon. Osooba: Jan Selinger	82633	5273	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83168	20	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	82633	5258	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83169	57	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	82633	5263	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83170	67	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	82633	5274	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83171	28	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	82633	5264	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83172	94	38	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	82633	5265	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83173	55	46	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Jan Selinger	82633	5278	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83174	75	41	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	82633	5267	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83175	35	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	82633	5275	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83176	81	43	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	82633	5279	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83177	85	47	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	82633	5268	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83178	50	46	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	82633	5271	2019-01-27 10:25:58	82103	2018-11-16 14:04:58.205	2901	82051
83179	23	35	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 8 let úroveň 0	82634	5283	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83180	66	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	82634	5251	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83181	65	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	82634	5275	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83182	65	31	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 8 let úroveň 0	82634	5284	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83183	92	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 8 let úroveň 0	82634	5255	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83184	46	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	82634	5258	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83185	50	30	Poznámka k aktivitě Úklon. Osooba: 8 let úroveň 0	82634	5273	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83186	27	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	82634	5263	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83187	92	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	82634	5264	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83188	86	47	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	82634	5265	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83189	67	32	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	82634	5267	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83190	32	38	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	82634	5268	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83191	70	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	82634	5279	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83192	90	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	82634	5274	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83193	78	45	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 8 let úroveň 0	82634	5278	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83194	67	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	82634	5271	2019-01-27 10:25:58	82103	2010-07-01 14:55:15.934	6405	82051
83195	100	34	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Luděk Rouss	82635	5284	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83196	47	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rouss	82635	5251	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83197	49	34	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Luděk Rouss	82635	5283	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83198	81	41	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rouss	82635	5279	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83199	38	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Luděk Rouss	82635	5255	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83200	56	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rouss	82635	5258	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83201	43	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rouss	82635	5263	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83202	21	33	Poznámka k aktivitě Úklon. Osooba: Luděk Rouss	82635	5273	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83203	77	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rouss	82635	5264	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83204	93	36	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rouss	82635	5265	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83205	31	38	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rouss	82635	5267	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83206	56	37	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rouss	82635	5268	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83207	81	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rouss	82635	5271	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83208	73	44	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Luděk Rouss	82635	5278	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83209	80	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rouss	82635	5274	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83210	97	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rouss	82635	5275	2019-01-27 10:25:58	82103	1985-11-01 00:00:00	80502	82051
83211	44	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	82636	5258	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83212	86	33	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 6 let úroveň 0	82636	5283	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83213	77	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	82636	5251	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83214	48	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	82636	5275	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83215	82	50	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 6 let úroveň 0	82636	5278	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83216	71	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	82636	5279	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83217	45	46	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 6 let úroveň 0	82636	5284	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83218	94	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 6 let úroveň 0	82636	5255	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83219	59	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	82636	5263	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83220	86	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	82636	5264	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83221	56	43	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	82636	5265	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83222	37	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	82636	5274	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83223	95	49	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	82636	5267	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83224	77	34	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	82636	5268	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83225	81	31	Poznámka k aktivitě Úklon. Osooba: 6 let úroveň 0	82636	5273	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83226	57	30	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	82636	5271	2019-01-28 10:26:26	82104	2012-07-01 14:55:15.66	6401	82051
83227	37	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	82637	5251	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83228	55	46	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 7 let úroveň 0	82637	5283	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83229	28	34	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 7 let úroveň 0	82637	5278	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83230	32	32	Poznámka k aktivitě Úklon. Osooba: 7 let úroveň 0	82637	5273	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83231	84	35	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 7 let úroveň 0	82637	5284	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83232	100	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 7 let úroveň 0	82637	5255	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83233	99	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	82637	5258	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83234	27	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	82637	5263	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83235	51	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	82637	5264	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83236	48	48	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	82637	5265	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83237	47	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	82637	5279	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83238	39	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	82637	5274	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83239	39	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	82637	5275	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83240	23	34	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	82637	5267	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83241	45	35	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	82637	5268	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83242	60	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	82637	5271	2019-01-28 10:26:26	82104	2011-07-01 14:55:15.854	6403	82051
83243	69	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	82638	5263	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83244	90	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	82638	5251	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83245	37	48	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Jan Selinger	82638	5278	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83246	84	49	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	82638	5279	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83247	84	44	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Jan Selinger	82638	5283	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83248	86	37	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Jan Selinger	82638	5284	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83249	55	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	82638	5274	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83250	27	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	82638	5275	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83251	91	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Jan Selinger	82638	5255	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83252	64	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	82638	5258	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83253	89	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	82638	5264	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83254	37	46	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	82638	5265	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83255	54	43	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	82638	5267	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83256	61	48	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	82638	5268	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83257	56	39	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	82638	5271	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83258	64	31	Poznámka k aktivitě Úklon. Osooba: Jan Selinger	82638	5273	2019-01-28 10:26:26	82104	2018-11-16 14:04:58.205	2901	82051
83259	80	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	82639	5251	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83260	70	36	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 8 let úroveň 0	82639	5283	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83261	71	35	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 8 let úroveň 0	82639	5284	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83262	85	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	82639	5275	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83263	43	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 8 let úroveň 0	82639	5255	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83264	34	34	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 8 let úroveň 0	82639	5278	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83265	27	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	82639	5279	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83266	56	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	82639	5258	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83267	81	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	82639	5263	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83268	91	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	82639	5264	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83269	80	32	Poznámka k aktivitě Úklon. Osooba: 8 let úroveň 0	82639	5273	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83270	35	35	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	82639	5265	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83271	86	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	82639	5274	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83272	86	37	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	82639	5267	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83273	79	40	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	82639	5268	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83274	81	46	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	82639	5271	2019-01-28 10:26:26	82104	2010-07-01 14:55:15.934	6405	82051
83275	33	34	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Luděk Rouss	82640	5284	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83276	29	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rouss	82640	5251	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83277	91	48	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Luděk Rouss	82640	5283	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83278	69	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Luděk Rouss	82640	5255	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83279	29	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rouss	82640	5258	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83280	25	30	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rouss	82640	5279	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83281	35	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rouss	82640	5263	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83282	86	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rouss	82640	5264	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83283	28	45	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rouss	82640	5265	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83284	24	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rouss	82640	5274	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83285	61	31	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rouss	82640	5267	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83286	31	34	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Luděk Rouss	82640	5278	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83287	46	31	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rouss	82640	5268	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83288	83	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rouss	82640	5275	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83289	41	49	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rouss	82640	5271	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83290	52	34	Poznámka k aktivitě Úklon. Osooba: Luděk Rouss	82640	5273	2019-01-28 10:26:26	82104	1985-11-01 00:00:00	80502	82051
83291	52	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	82641	5258	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83292	81	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	82641	5251	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83293	26	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	82641	5274	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83294	97	39	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 6 let úroveň 0	82641	5283	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83295	82	47	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 6 let úroveň 0	82641	5284	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83296	22	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 6 let úroveň 0	82641	5255	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83297	33	31	Poznámka k aktivitě Úklon. Osooba: 6 let úroveň 0	82641	5273	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83298	90	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	82641	5275	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83299	21	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	82641	5263	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83300	95	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	82641	5264	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83301	78	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	82641	5279	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83302	92	39	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	82641	5265	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83303	52	44	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 6 let úroveň 0	82641	5278	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83304	56	43	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	82641	5267	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83305	77	36	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	82641	5268	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83306	99	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	82641	5271	2019-01-29 10:26:53	82105	2012-07-01 14:55:15.66	6401	82051
83307	22	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	82642	5258	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83308	55	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	82642	5251	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83309	79	45	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 7 let úroveň 0	82642	5283	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83310	74	48	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 7 let úroveň 0	82642	5284	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83311	30	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	82642	5274	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83312	83	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 7 let úroveň 0	82642	5255	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83313	74	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	82642	5279	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83314	57	31	Poznámka k aktivitě Úklon. Osooba: 7 let úroveň 0	82642	5273	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83315	49	40	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 7 let úroveň 0	82642	5278	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83316	78	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	82642	5263	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83317	61	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	82642	5264	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83318	74	34	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	82642	5265	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83319	29	42	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	82642	5267	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83320	99	40	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	82642	5268	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83321	49	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	82642	5275	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83322	28	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	82642	5271	2019-01-29 10:26:53	82105	2011-07-01 14:55:15.854	6403	82051
83323	22	49	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Jan Selinger	82643	5283	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83324	20	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	82643	5251	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83325	50	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	82643	5274	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83326	37	47	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Jan Selinger	82643	5284	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83327	56	31	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Jan Selinger	82643	5278	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83328	20	49	Poznámka k aktivitě Úklon. Osooba: Jan Selinger	82643	5273	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83329	53	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Jan Selinger	82643	5255	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83330	82	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	82643	5258	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83331	79	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	82643	5263	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83332	28	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	82643	5264	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83333	48	44	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	82643	5265	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83334	62	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	82643	5275	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83335	98	48	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	82643	5267	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83336	44	39	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	82643	5279	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83337	82	34	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	82643	5268	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83338	57	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	82643	5271	2019-01-29 10:26:53	82105	2018-11-16 14:04:58.205	2901	82051
83339	78	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	82644	5258	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83340	22	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	82644	5251	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83341	27	39	Poznámka k aktivitě Úklon. Osooba: 8 let úroveň 0	82644	5273	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83342	81	35	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 8 let úroveň 0	82644	5283	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83343	92	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	82644	5275	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83344	60	39	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 8 let úroveň 0	82644	5284	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83345	68	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 8 let úroveň 0	82644	5255	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83346	53	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	82644	5279	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83347	28	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	82644	5263	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83348	90	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	82644	5264	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83349	38	42	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	82644	5265	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83350	30	42	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	82644	5267	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83351	44	39	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	82644	5268	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83352	65	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	82644	5274	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83353	27	32	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 8 let úroveň 0	82644	5278	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83354	48	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	82644	5271	2019-01-29 10:26:53	82105	2010-07-01 14:55:15.934	6405	82051
83355	84	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rouss	82645	5251	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83356	52	30	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Luděk Rouss	82645	5283	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83357	70	36	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Luděk Rouss	82645	5284	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83358	74	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Luděk Rouss	82645	5255	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83359	29	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rouss	82645	5258	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83360	83	40	Poznámka k aktivitě Úklon. Osooba: Luděk Rouss	82645	5273	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83361	52	40	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Luděk Rouss	82645	5278	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83362	87	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rouss	82645	5263	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83363	69	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rouss	82645	5264	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83364	47	40	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rouss	82645	5265	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83365	57	33	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rouss	82645	5267	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83366	55	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rouss	82645	5274	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83367	63	35	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rouss	82645	5279	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83368	51	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rouss	82645	5275	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83369	41	41	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rouss	82645	5268	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83370	53	30	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rouss	82645	5271	2019-01-29 10:26:53	82105	1985-11-01 00:00:00	80502	82051
83371	90	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 6 let úroveň 0	82646	5255	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83372	34	35	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 6 let úroveň 0	82646	5283	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83373	21	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	82646	5251	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83374	49	36	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 6 let úroveň 0	82646	5284	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83375	80	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	82646	5258	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83376	83	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	82646	5263	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83377	95	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	82646	5264	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83378	73	43	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	82646	5265	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83379	83	35	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	82646	5267	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83380	96	50	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	82646	5268	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83381	32	45	Poznámka k aktivitě Úklon. Osooba: 6 let úroveň 0	82646	5273	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83382	28	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	82646	5275	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83383	81	31	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 6 let úroveň 0	82646	5278	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83384	73	31	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	82646	5271	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83385	78	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	82646	5274	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83386	47	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	82646	5279	2019-01-25 10:10:13	82101	2012-07-01 14:55:15.66	6401	82051
83387	93	30	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 7 let úroveň 0	82647	5284	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83388	33	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	82647	5251	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83389	73	47	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 7 let úroveň 0	82647	5283	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83390	21	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 7 let úroveň 0	82647	5255	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83391	46	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	82647	5258	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83392	48	37	Poznámka k aktivitě Úklon. Osooba: 7 let úroveň 0	82647	5273	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83393	84	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	82647	5263	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83394	50	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	82647	5264	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83395	98	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	82647	5279	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83396	29	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	82647	5275	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83397	54	39	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	82647	5265	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83398	66	32	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	82647	5267	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83399	73	32	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	82647	5268	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83400	32	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	82647	5274	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83401	50	31	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	82647	5271	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83402	85	44	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 7 let úroveň 0	82647	5278	2019-01-25 10:10:13	82101	2011-07-01 14:55:15.854	6403	82051
83403	85	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	82648	5251	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83404	75	50	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Jan Selinger	82648	5283	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83405	67	38	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Jan Selinger	82648	5284	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83406	35	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Jan Selinger	82648	5255	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83407	56	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	82648	5258	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83408	40	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	82648	5263	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83409	22	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	82648	5264	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83410	52	48	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	82648	5265	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83411	73	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	82648	5274	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83412	96	31	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	82648	5267	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83413	21	41	Poznámka k aktivitě Úklon. Osooba: Jan Selinger	82648	5273	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83414	49	47	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Jan Selinger	82648	5278	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83415	67	39	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	82648	5268	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83416	84	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	82648	5271	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83417	29	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	82648	5275	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83418	66	40	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	82648	5279	2019-01-25 10:10:13	82101	2018-11-16 14:04:58.205	2901	82051
83419	47	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: 8 let úroveň 0	82649	5255	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83420	86	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	82649	5251	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83421	66	36	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: 8 let úroveň 0	82649	5283	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83422	31	39	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: 8 let úroveň 0	82649	5284	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83423	76	49	Poznámka k aktivitě Úklon. Osooba: 8 let úroveň 0	82649	5273	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83424	91	32	Poznámka k aktivitě Člunkový běh s míčem. Osooba: 8 let úroveň 0	82649	5278	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83425	63	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	82649	5279	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83426	98	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	82649	5258	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83427	74	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	82649	5263	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83428	37	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	82649	5275	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83429	84	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	82649	5264	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83430	54	43	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	82649	5265	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83431	43	41	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	82649	5267	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83432	52	46	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	82649	5268	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83433	60	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	82649	5271	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83434	96	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	82649	5274	2019-01-25 10:10:13	82101	2010-07-01 14:55:15.934	6405	82051
83435	91	33	Poznámka k aktivitě Basketbal - střelba z různých přihrávek. Osooba: Luděk Rouss	82650	5283	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83436	63	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rouss	82650	5251	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83437	40	35	Poznámka k aktivitě Basketbal - střelba zprava. Osooba: Luděk Rouss	82650	5284	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83438	78	32	Poznámka k aktivitě Úklon. Osooba: Luděk Rouss	82650	5273	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83439	56	\N	Poznámka k aktivitě Běh 5 metrů. Osooba: Luděk Rouss	82650	5255	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83440	95	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rouss	82650	5258	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83441	95	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rouss	82650	5275	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83442	32	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rouss	82650	5263	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83443	77	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rouss	82650	5274	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83444	59	46	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rouss	82650	5279	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83445	87	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rouss	82650	5264	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83446	30	50	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rouss	82650	5265	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83447	25	30	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rouss	82650	5267	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83448	88	47	Poznámka k aktivitě Člunkový běh s míčem. Osooba: Luděk Rouss	82650	5278	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83449	70	44	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rouss	82650	5268	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
83450	75	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rouss	82650	5271	2019-01-25 10:10:13	82101	1985-11-01 00:00:00	80502	82051
\.


--
-- TOC entry 3054 (class 0 OID 60503)
-- Dependencies: 219
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.address (id, country, city, street, zip_code) FROM stdin;
2101	Czech Republic	Plzeň	Spojovací 16	32600
2801	Czech Republic	Plzeň	Nevim	Nevim
6001	\N	\N	\N	\N
6002	\N	\N	\N	\N
6003	\N	\N	\N	\N
6004	\N	\N	\N	\N
6151	\N	\N	\N	\N
6152	\N	\N	\N	\N
6153	\N	\N	\N	\N
6154	\N	\N	\N	\N
6155	\N	\N	\N	\N
6156	\N	\N	\N	\N
6157	\N	\N	\N	\N
6158	\N	\N	\N	\N
6159	\N	\N	\N	\N
6160	\N	\N	\N	\N
6161	\N	\N	\N	\N
6162	\N	\N	\N	\N
80402	Česká Republika	Plzeň	Spojovací 16	32600
81704	Česká republika	Plzeň	Spojovací 16	32600
84001	\N	\N	\N	\N
\.


--
-- TOC entry 3032 (class 0 OID 60351)
-- Dependencies: 197
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1545217359922-1	RLU (generated)	config/liquibase/changelog/20181219110232_added_activityResult_indexes.xml	2018-12-19 12:03:57.445406	47	EXECUTED	7:3e195b1d10d037070e1a0518953dbead	createIndex indexName=filter_index, tableName=activity_result		\N	3.5.4	\N	\N	5217437386
1547024990508-1	RLU (generated)	config/liquibase/changelog/20190109090943_added_result_types_to_Activity.xml	2019-01-09 10:22:16.27293	48	EXECUTED	7:a8bb75072b0d7a591a8077512001ca49	addColumn tableName=activity		\N	3.5.4	\N	\N	7025736222
1547024990508-2	RLU (generated)	config/liquibase/changelog/20190109090943_added_result_types_to_Activity.xml	2019-01-09 10:22:16.281851	49	EXECUTED	7:bc9440f18533a169cb0dfde426cf9a24	addColumn tableName=activity		\N	3.5.4	\N	\N	7025736222
1547024990508-3	RLU (generated)	config/liquibase/changelog/20190109090943_added_result_types_to_Activity.xml	2019-01-09 10:22:16.319125	50	EXECUTED	7:df03298c5862e19c7a1aa789da16e36f	dropIndex indexName=filter_index, tableName=activity_result; createIndex indexName=filter_index, tableName=activity_result		\N	3.5.4	\N	\N	7025736222
20180919081353-1	jhipster	config/liquibase/changelog/20180919081353_added_entity_ActivityCategory.xml	2018-11-13 08:17:40.108058	7	EXECUTED	7:f314cfb26cb50c7061bef53b28dc64ed	createTable tableName=activity_category		\N	3.5.4	\N	\N	2093459943
20180919081358-1	jhipster	config/liquibase/changelog/20180919081358_added_entity_PersonalData.xml	2018-11-13 08:17:40.142888	12	EXECUTED	7:7fa972ec1a3cb9d040b869b8404820c9	createTable tableName=personal_data; dropDefaultValue columnName=birth_date, tableName=personal_data		\N	3.5.4	\N	\N	2093459943
1543234912593-3	RLU (generated)	config/liquibase/changelog/20181126122145_added_minAge_maxAge_to_JTTest.xml	2018-11-26 13:37:51.908749	32	EXECUTED	\N	addNotNullConstraint columnName=primary_result_value, tableName=activity_result		\N	3.5.4	\N	\N	3235871887
20180919081351-1	jhipster	config/liquibase/changelog/20180919081351_added_entity_Activity.xml	2018-11-13 08:17:40.089369	5	EXECUTED	7:51a20693e822fc99843bc42875ebd530	createTable tableName=activity; createTable tableName=activity_categories; addPrimaryKey tableName=activity_categories		\N	3.5.4	\N	\N	2093459943
20180919081359-1	jhipster	config/liquibase/changelog/20180919081359_added_entity_Address.xml	2018-11-13 08:17:40.150992	13	EXECUTED	7:ea7a5521a5359062b65250a0f9fe3c2d	createTable tableName=address		\N	3.5.4	\N	\N	2093459943
20180919081400-1	jhipster	config/liquibase/changelog/20180919081400_added_entity_Sport.xml	2018-11-13 08:17:40.299031	14	EXECUTED	7:f52d0611a6f30a779a306d3fdd1f6efc	createTable tableName=sport		\N	3.5.4	\N	\N	2093459943
20180919081349-2	jhipster	config/liquibase/changelog/20180919081349_added_entity_constraints_Event.xml	2018-11-13 08:17:40.305196	15	EXECUTED	7:b8415974a3bbbee40af1be77144c73b8	addForeignKeyConstraint baseTableName=event, constraintName=fk_event_address_id, referencedTableName=address; addForeignKeyConstraint baseTableName=event_tests, constraintName=fk_event_tests_events_id, referencedTableName=event; addForeignKeyConst...		\N	3.5.4	\N	\N	2093459943
20180919081350-2	jhipster	config/liquibase/changelog/20180919081350_added_entity_constraints_JTTest.xml	2018-11-13 08:17:40.316289	16	EXECUTED	7:2aa590bc8418d96f1351379bfa642d38	addForeignKeyConstraint baseTableName=jttest_activities, constraintName=fk_jttest_activities_jttests_id, referencedTableName=jt_test; addForeignKeyConstraint baseTableName=jttest_activities, constraintName=fk_jttest_activities_activities_id, refer...		\N	3.5.4	\N	\N	2093459943
20180919081351-2	jhipster	config/liquibase/changelog/20180919081351_added_entity_constraints_Activity.xml	2018-11-13 08:17:40.322413	17	EXECUTED	7:2ae36c777c371f9c88083142ba5a1983	addForeignKeyConstraint baseTableName=activity_categories, constraintName=fk_activity_categories_activities_id, referencedTableName=activity; addForeignKeyConstraint baseTableName=activity_categories, constraintName=fk_activity_categories_categori...		\N	3.5.4	\N	\N	2093459943
20180919081354-2	jhipster	config/liquibase/changelog/20180919081354_added_entity_constraints_EventResult.xml	2018-11-13 08:17:40.32731	18	EXECUTED	7:d1d86da675c22daaa25d6083205be99b	addForeignKeyConstraint baseTableName=event_result, constraintName=fk_event_result_event_id, referencedTableName=event; addForeignKeyConstraint baseTableName=event_result, constraintName=fk_event_result_person_id, referencedTableName=person		\N	3.5.4	\N	\N	2093459943
20180919081355-2	jhipster	config/liquibase/changelog/20180919081355_added_entity_constraints_TestResult.xml	2018-11-13 08:17:40.332131	19	EXECUTED	7:f71ec1e25e29b2e087bfa73206b115c9	addForeignKeyConstraint baseTableName=test_result, constraintName=fk_test_result_event_result_id, referencedTableName=event_result; addForeignKeyConstraint baseTableName=test_result, constraintName=fk_test_result_test_id, referencedTableName=jt_test		\N	3.5.4	\N	\N	2093459943
1542094230696-3	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.058173	24	EXECUTED	7:90b485b8604f4e89b8f93ab068d21dab	addForeignKeyConstraint baseTableName=person, constraintName=FKe9y2rjb98wsg2nnk3eyrvc2ss, referencedTableName=jhi_user		\N	3.5.4	\N	\N	2094321018
1543234912593-1	RLU (generated)	config/liquibase/changelog/20181126122145_added_minAge_maxAge_to_JTTest.xml	2018-11-26 13:37:51.901023	30	EXECUTED	7:480c7012768a8b3e3821f50666265f50	addColumn tableName=jt_test		\N	3.5.4	\N	\N	3235871887
1543234912593-2	RLU (generated)	config/liquibase/changelog/20181126122145_added_minAge_maxAge_to_JTTest.xml	2018-11-26 13:37:51.905848	31	EXECUTED	7:624a2b8c0323453fb4f68ddc7bef171a	addColumn tableName=jt_test		\N	3.5.4	\N	\N	3235871887
1543235550671-1	RLU (generated)	config/liquibase/changelog/20181126123222_added_minAge_maxAge_to_event.xml	2018-11-26 13:37:51.911734	33	EXECUTED	7:f08f521475f3dddf76f301f41f9dd67d	addColumn tableName=event		\N	3.5.4	\N	\N	3235871887
1543235550671-3	RLU (generated)	config/liquibase/changelog/20181126123222_added_minAge_maxAge_to_event.xml	2018-11-26 13:37:51.914663	34	EXECUTED	7:a257c03b60e785b64f0f2dfbe13e2f30	addColumn tableName=event		\N	3.5.4	\N	\N	3235871887
1543493771251-1	RLU (generated)	config/liquibase/changelog/20181129121600_added_virtual_to_person.xml	2018-11-29 13:19:20.059167	35	EXECUTED	7:27eb2f686421f4b30e41588c8ce5549d	addColumn tableName=person		\N	3.5.4	\N	\N	3493960016
1543524439837-1	RLU (generated)	config/liquibase/changelog/20181129204712_activityCategory_tree_structure.xml	2018-11-29 21:50:44.984767	36	EXECUTED	7:580507f47c988f107ea3cc0c47a6773a	addColumn tableName=activity_category		\N	3.5.4	\N	\N	3524644974
1543524439837-2	RLU (generated)	config/liquibase/changelog/20181129204712_activityCategory_tree_structure.xml	2018-11-29 21:50:44.997526	37	EXECUTED	7:c5c44cdd90fb9d28a303413123382d14	addForeignKeyConstraint baseTableName=activity_category, constraintName=FKnxdhln28xokjbv8cwfj372fny, referencedTableName=activity_category		\N	3.5.4	\N	\N	3524644974
1544602539729-1	RLU (generated)	config/liquibase/changelog/20181212081532_added_eventDate_to_activityResult.xml	2018-12-12 10:04:29.89649	38	EXECUTED	7:72e1d813667e78a8b484b50973f0fd80	addColumn tableName=activity_result		\N	3.5.4	\N	\N	4605469836
1544602539729-2	RLU (generated)	config/liquibase/changelog/20181212081532_added_eventDate_to_activityResult.xml	2018-12-12 10:04:29.901649	39	EXECUTED	7:b847c146efcfcb805b3a9c155f205e7c	addNotNullConstraint columnName=virtual, tableName=person		\N	3.5.4	\N	\N	4605469836
1548663685849-6	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 09:28:06.28522	60	EXECUTED	7:df03298c5862e19c7a1aa789da16e36f	dropIndex indexName=filter_index, tableName=activity_result; createIndex indexName=filter_index, tableName=activity_result		\N	3.5.4	\N	\N	8664086204
20180919081350-1	jhipster	config/liquibase/changelog/20180919081350_added_entity_ActivityGroup.xml	2019-01-28 14:40:33.04851	67	EXECUTED	7:0744b3b62edd42bef9d35a7a0e7764f1	createTable tableName=activity_group; createTable tableName=activity_group_activities; addPrimaryKey tableName=activity_group_activities; createTable tableName=activity_group_activity_group_categories; addPrimaryKey tableName=activity_group_activi...		\N	3.5.4	\N	\N	8682832983
20180919081350-2	jhipster	config/liquibase/changelog/20180919081350_added_entity_constraints_ActivityGroup.xml	2019-01-28 14:40:33.067347	68	EXECUTED	7:9db1b171136e385350309b7b524f5fc9	addForeignKeyConstraint baseTableName=activity_group_activities, constraintName=fk_activity_group_activities_activity_groups_id, referencedTableName=activity_group; addForeignKeyConstraint baseTableName=activity_group_activities, constraintName=fk...		\N	3.5.4	\N	\N	8682832983
20180919081352-1	jhipster	config/liquibase/changelog/20180919081352_added_entity_TestCategory.xml	2018-11-13 08:17:40.097382	6	EXECUTED	7:209442ef19c7c22da10246fe370b38b0	createTable tableName=test_category		\N	3.5.4	\N	\N	2093459943
20180919081354-1	jhipster	config/liquibase/changelog/20180919081354_added_entity_EventResult.xml	2018-11-13 08:17:40.113721	8	EXECUTED	7:ebe4b30a347285f3c27e6149a38ebe37	createTable tableName=event_result		\N	3.5.4	\N	\N	2093459943
20180919081356-1	jhipster	config/liquibase/changelog/20180919081356_added_entity_ActivityResult.xml	2018-11-13 08:17:40.125061	10	EXECUTED	7:57a1f3bf36c71dee72b6fa931bbfc574	createTable tableName=activity_result		\N	3.5.4	\N	\N	2093459943
1545081647288-1	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.061764	40	EXECUTED	7:08353204477c8a98074df067da146c43	addColumn tableName=activity_result		\N	3.5.4	\N	\N	5082560051
1545081647288-2	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.066466	41	EXECUTED	7:8706210d8391c945d92ebc14678fa514	addColumn tableName=activity_result		\N	3.5.4	\N	\N	5082560051
1545081647288-3	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.068696	42	EXECUTED	7:e0e8ccb125506784aa0d2332c02978b5	addColumn tableName=activity_result		\N	3.5.4	\N	\N	5082560051
1545081647288-4	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.070864	43	EXECUTED	7:400b7f0a4610cd0dde4a9a2653ddf49d	addColumn tableName=activity_result		\N	3.5.4	\N	\N	5082560051
1545081647288-5	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.077539	44	EXECUTED	7:234b3841f81f4cfcc02a99a61e456657	addForeignKeyConstraint baseTableName=activity_result, constraintName=FKbvddel0kqefqb2cbfyk5b8h1a, referencedTableName=person		\N	3.5.4	\N	\N	5082560051
1545081647288-6	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.081904	45	EXECUTED	7:da896755489c44c16eaef4ef1b774832	addForeignKeyConstraint baseTableName=activity_result, constraintName=FKipbqegmh7qoia8ah6tgoene1s, referencedTableName=jt_test		\N	3.5.4	\N	\N	5082560051
1545081647288-7	RLU (generated)	config/liquibase/changelog/20181217212040_added_activityResults_stats_fields.xml	2018-12-17 22:36:00.086054	46	EXECUTED	7:5e7c28ce7f6becb866c95ec75af18063	addForeignKeyConstraint baseTableName=activity_result, constraintName=FKopx45p3m6dw4ixv94dpyxvuea, referencedTableName=event		\N	3.5.4	\N	\N	5082560051
20190128064851-1	jhipster	config/liquibase/changelog/20190128064851_added_entity_Group.xml	2019-01-28 08:37:00.913619	51	EXECUTED	7:1d059d205925faaa90eb4eb5c4b2ffc8	createTable tableName=jhi_group		\N	3.5.4	\N	\N	8661020858
20190128064851-2	jhipster	config/liquibase/changelog/20190128064851_added_entity_constraints_Group.xml	2019-01-28 08:37:00.930511	52	EXECUTED	7:1d89b014a04dc5fb49216444b150e58a	addForeignKeyConstraint baseTableName=jhi_group, constraintName=fk_group_parent_id, referencedTableName=jhi_group		\N	3.5.4	\N	\N	8661020858
1548663685849-1	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 10:24:31.974018	61	EXECUTED	7:5da139a5311a0f8e16f3f95bc39703e7	addColumn tableName=activity		\N	3.5.4	\N	\N	8667471926
00000000000000	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:39.981088	1	EXECUTED	7:a6235f40597a13436aa36c6d61db2269	createSequence sequenceName=hibernate_sequence		\N	3.5.4	\N	\N	2093459943
00000000000001	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:40.044389	2	EXECUTED	7:ebc2000ab4a469430e5c638c4cf79aa2	createTable tableName=jhi_user; createTable tableName=jhi_authority; createTable tableName=jhi_user_authority; addPrimaryKey tableName=jhi_user_authority; addForeignKeyConstraint baseTableName=jhi_user_authority, constraintName=fk_authority_name, ...		\N	3.5.4	\N	\N	2093459943
20180919081350-1	jhipster	config/liquibase/changelog/20180919081350_added_entity_JTTest.xml	2018-11-13 08:17:40.077001	4	EXECUTED	7:0648dc6f98e54c36da78f88f88d4179e	createTable tableName=jt_test; createTable tableName=jttest_activities; addPrimaryKey tableName=jttest_activities; createTable tableName=jttest_categories; addPrimaryKey tableName=jttest_categories; createTable tableName=jttest_sports; addPrimaryK...		\N	3.5.4	\N	\N	2093459943
20180919081355-1	jhipster	config/liquibase/changelog/20180919081355_added_entity_TestResult.xml	2018-11-13 08:17:40.119662	9	EXECUTED	7:77a15fb38c878daf3cebd815691c8c88	createTable tableName=test_result		\N	3.5.4	\N	\N	2093459943
20180919081357-1	jhipster	config/liquibase/changelog/20180919081357_added_entity_Person.xml	2018-11-13 08:17:40.13429	11	EXECUTED	7:e93b4d142509c4cc65e53f2143f9486d	createTable tableName=person		\N	3.5.4	\N	\N	2093459943
20180919081356-2	jhipster	config/liquibase/changelog/20180919081356_added_entity_constraints_ActivityResult.xml	2018-11-13 08:17:40.336735	20	EXECUTED	7:b93d0e2b25de3af146ee96785ec72b02	addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_test_result_id, referencedTableName=test_result; addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_activity_id, referen...		\N	3.5.4	\N	\N	2093459943
20180919081357-2	jhipster	config/liquibase/changelog/20180919081357_added_entity_constraints_Person.xml	2018-11-13 08:17:40.340958	21	EXECUTED	7:6f22c18d852385929e915b70ccd0c175	addForeignKeyConstraint baseTableName=person, constraintName=fk_person_personal_data_id, referencedTableName=personal_data; addForeignKeyConstraint baseTableName=person, constraintName=fk_person_address_id, referencedTableName=address		\N	3.5.4	\N	\N	2093459943
1542094230696-1	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.044386	22	EXECUTED	7:8d217e9e99a9ac7683f596d22b7cff2b	addColumn tableName=person		\N	3.5.4	\N	\N	2094321018
1542094230696-2	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.053252	23	EXECUTED	7:5e841b60b47ff0aefc49a0b7da95ffb1	addUniqueConstraint constraintName=UC_PERSONUSER_ID_COL, tableName=person		\N	3.5.4	\N	\N	2094321018
1542203539812-1	RLU (generated)	config/liquibase/changelog/20181114135212_added_email_to_Person.xml	2018-11-14 14:57:36.771271	25	EXECUTED	7:938df0e4a12d451975ee6f637de0d637	addColumn tableName=person		\N	3.5.4	\N	\N	2203856737
1542293651906-1	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.275511	26	EXECUTED	7:6823dba0e68a6c865ef7afaa5967798e	createTable tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1548663685849-2	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 10:24:31.980818	62	EXECUTED	7:cb7d241f1f997ec80f30dbd54e9370ae	addColumn tableName=activity		\N	3.5.4	\N	\N	8667471926
1548663685849-3	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 10:24:31.983289	63	EXECUTED	7:6d44c09823426476c8b9b3aaa75c852d	addColumn tableName=activity		\N	3.5.4	\N	\N	8667471926
1548663685849-4	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 10:24:31.992339	64	EXECUTED	7:70e6d9dbe5e9a5ed9c30c4e08f03a33e	addForeignKeyConstraint baseTableName=activity, constraintName=FK5uiqyj0efmyxdb0w52b184iai, referencedTableName=person		\N	3.5.4	\N	\N	8667471926
1548663685849-5	RLU (generated)	config/liquibase/changelog/20190128082118_updated_entity_activity.xml	2019-01-28 10:24:31.997289	65	EXECUTED	7:89467754342cde3a9b29ae409af5eab1	addForeignKeyConstraint baseTableName=activity, constraintName=FKi38klfuakye3farjp75qw5jsl, referencedTableName=jhi_group		\N	3.5.4	\N	\N	8667471926
20190128080336-1	jhipster	config/liquibase/changelog/20190128080336_added_entity_PersonGroup.xml	2019-01-28 09:05:00.884417	53	EXECUTED	7:86b0eb4001659de7fcb77f2ba580cc63	createTable tableName=person_group		\N	3.5.4	\N	\N	8662700837
20190128080336-2	jhipster	config/liquibase/changelog/20190128080336_added_entity_constraints_PersonGroup.xml	2019-01-28 09:05:00.897541	54	EXECUTED	7:7c1dd5f69187a23f108b3f6e1131ee14	addForeignKeyConstraint baseTableName=person_group, constraintName=fk_person_group_person_id, referencedTableName=person; addForeignKeyConstraint baseTableName=person_group, constraintName=fk_person_group_group_id, referencedTableName=jhi_group		\N	3.5.4	\N	\N	8662700837
20180919081352-1	jhipster	config/liquibase/changelog/20180919081352_added_entity_ActivityGroupCategory.xml	2019-01-28 14:29:34.675314	66	EXECUTED	7:24aad763aed585d95db542f0460fc10b	createTable tableName=activity_group_category		\N	3.5.4	\N	\N	8682174617
20180919081349-1	jhipster	config/liquibase/changelog/20180919081349_added_entity_Event.xml	2018-11-13 08:17:40.055519	3	EXECUTED	7:e5038305fbd38914b161642650e71433	createTable tableName=event; dropDefaultValue columnName=jhi_date, tableName=event; createTable tableName=event_tests; addPrimaryKey tableName=event_tests		\N	3.5.4	\N	\N	2093459943
1542293651906-2	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.287102	27	EXECUTED	7:d0d9029f499101cf4d2906448bb5e5ff	addPrimaryKey tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1542293651906-3	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.2943	28	EXECUTED	7:701420cea947cf455ef06550bcfa0af5	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKcc1cq3mo95k6xp5duh287cfsv, referencedTableName=person		\N	3.5.4	\N	\N	2293767209
1542293651906-4	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.297943	29	EXECUTED	7:8734b0163166dd0e7edfc06c3acd980f	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKtlu2ktd0nahrhonnjrbjjrkwe, referencedTableName=event		\N	3.5.4	\N	\N	2293767209
\.


--
-- TOC entry 3031 (class 0 OID 60346)
-- Dependencies: 196
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 3039 (class 0 OID 60409)
-- Dependencies: 204
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.event (id, name, jhi_date, address_id, max_age, min_age) FROM stdin;
82102	Pokusná událost 2	2019-01-26 10:25:40	\N	100	0
82103	Pokusná událost 3	2019-01-27 10:25:58	\N	100	0
82104	Pokusná událost 5	2019-01-28 10:26:26	\N	100	0
82105	Pokusná událost 4	2019-01-29 10:26:53	\N	100	0
82101	Pokusná událost 1	2019-01-25 10:10:13	\N	100	0
\.


--
-- TOC entry 3056 (class 0 OID 60620)
-- Dependencies: 221
-- Data for Name: event_attached_persons; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.event_attached_persons (events_id, attached_persons_id) FROM stdin;
82101	6401
82101	6403
82101	2901
82101	6405
82102	6401
82102	6403
82102	2901
82102	6405
82102	80502
82103	6401
82103	6403
82103	2901
82103	6405
82103	80502
82104	6401
82104	6403
82104	2901
82104	6405
82104	80502
82105	6401
82105	6403
82105	2901
82105	6405
82105	80502
82101	80502
\.


--
-- TOC entry 3049 (class 0 OID 60471)
-- Dependencies: 214
-- Data for Name: event_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.event_result (id, note, actual_height_in_cm, actual_weight_in_kg, event_id, person_id) FROM stdin;
82576	\N	171	90	82102	6401
82577	\N	161	77	82102	6403
82578	\N	172	78	82102	2901
82579	\N	169	83	82102	6405
82580	\N	166	78	82102	80502
82581	\N	176	82	82103	6401
82582	\N	169	75	82103	6403
82583	\N	184	81	82103	2901
82584	\N	170	84	82103	6405
82585	\N	182	85	82103	80502
82586	\N	172	89	82104	6401
82587	\N	179	83	82104	6403
82588	\N	168	78	82104	2901
82589	\N	168	75	82104	6405
82590	\N	165	87	82104	80502
82591	\N	185	90	82105	6401
82592	\N	177	76	82105	6403
82593	\N	173	79	82105	2901
82594	\N	161	84	82105	6405
82595	\N	162	90	82105	80502
82596	\N	180	85	82101	6401
82597	\N	184	84	82101	6403
82598	\N	189	84	82101	2901
82599	\N	174	88	82101	6405
82600	\N	182	79	82101	80502
\.


--
-- TOC entry 3040 (class 0 OID 60414)
-- Dependencies: 205
-- Data for Name: event_tests; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.event_tests (tests_id, events_id) FROM stdin;
82051	82101
82051	82102
82051	82103
82051	82104
82051	82105
\.


--
-- TOC entry 3035 (class 0 OID 60372)
-- Dependencies: 200
-- Data for Name: jhi_authority; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_authority (name) FROM stdin;
ROLE_ADMIN
ROLE_USER
\.


--
-- TOC entry 3057 (class 0 OID 76848)
-- Dependencies: 222
-- Data for Name: jhi_group; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_group (id, name, parent_id) FROM stdin;
83751	Skupina	\N
83752	Podsupina	83751
\.


--
-- TOC entry 3037 (class 0 OID 60392)
-- Dependencies: 202
-- Data for Name: jhi_persistent_audit_event; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_persistent_audit_event (event_id, principal, event_date, event_type) FROM stdin;
951	admin	2018-11-13 14:14:54.519	AUTHENTICATION_SUCCESS
952	admin	2018-11-13 14:25:56.875	AUTHENTICATION_SUCCESS
953	admin	2018-11-13 14:28:20.915	AUTHENTICATION_SUCCESS
954	admin	2018-11-13 14:32:09.596	AUTHENTICATION_SUCCESS
955	admin	2018-11-13 14:36:34.754	AUTHENTICATION_SUCCESS
1001	admin	2018-11-13 14:44:28.474	AUTHENTICATION_SUCCESS
1002	admin	2018-11-13 14:44:49.91	AUTHENTICATION_SUCCESS
1003	admin	2018-11-13 14:47:49.579	AUTHENTICATION_SUCCESS
1004	admin	2018-11-13 14:50:52.048	AUTHENTICATION_SUCCESS
1005	admin	2018-11-13 14:55:41.709	AUTHENTICATION_SUCCESS
1006	admin	2018-11-13 15:01:21.731	AUTHENTICATION_SUCCESS
1007	admin	2018-11-13 15:04:00.599	AUTHENTICATION_SUCCESS
1008	admin	2018-11-13 15:04:12.723	AUTHENTICATION_SUCCESS
1009	admin	2018-11-13 15:04:42.794	AUTHENTICATION_SUCCESS
1010	admin	2018-11-13 15:05:12.027	AUTHENTICATION_SUCCESS
1011	admin	2018-11-13 15:07:35.21	AUTHENTICATION_SUCCESS
1012	admin	2018-11-13 15:08:26.131	AUTHENTICATION_SUCCESS
1013	admin	2018-11-13 15:08:45.21	AUTHENTICATION_SUCCESS
1014	admin	2018-11-13 15:09:26.137	AUTHENTICATION_SUCCESS
1015	admin	2018-11-13 15:09:43.497	AUTHENTICATION_SUCCESS
1051	admin	2018-11-13 15:10:40.977	AUTHENTICATION_SUCCESS
1101	admin	2018-11-13 15:11:56.189	AUTHENTICATION_SUCCESS
1102	admin	2018-11-13 15:13:33.278	AUTHENTICATION_SUCCESS
1103	admin	2018-11-13 15:13:44.423	AUTHENTICATION_SUCCESS
1104	admin	2018-11-13 15:15:29.528	AUTHENTICATION_SUCCESS
1105	admin	2018-11-13 15:40:45.677	AUTHENTICATION_SUCCESS
1106	admin	2018-11-13 15:41:36.946	AUTHENTICATION_SUCCESS
1107	admin	2018-11-13 15:41:59.974	AUTHENTICATION_SUCCESS
1108	admin	2018-11-13 15:43:35.18	AUTHENTICATION_SUCCESS
1109	admin	2018-11-13 15:44:53.433	AUTHENTICATION_SUCCESS
1110	admin	2018-11-13 16:03:39.157	AUTHENTICATION_SUCCESS
1111	admin	2018-11-13 16:15:53.791	AUTHENTICATION_SUCCESS
1151	admin	2018-11-13 16:25:54.37	AUTHENTICATION_SUCCESS
1152	admin	2018-11-13 16:25:56.539	AUTHENTICATION_SUCCESS
1153	admin	2018-11-13 16:26:18.618	AUTHENTICATION_SUCCESS
1351	admin	2018-11-13 16:33:11.141	AUTHENTICATION_SUCCESS
1401	admin	2018-11-13 16:35:38.912	AUTHENTICATION_SUCCESS
1451	admin	2018-11-13 16:43:35.396	AUTHENTICATION_SUCCESS
1501	admin	2018-11-13 16:45:13.945	AUTHENTICATION_SUCCESS
1551	admin	2018-11-13 16:46:59.399	AUTHENTICATION_SUCCESS
1601	admin	2018-11-14 15:08:11.902	AUTHENTICATION_SUCCESS
1602	admin	2018-11-14 15:15:43.836	AUTHENTICATION_SUCCESS
1603	admin	2018-11-14 15:23:34.933	AUTHENTICATION_SUCCESS
1604	admin	2018-11-14 15:23:51.631	AUTHENTICATION_SUCCESS
1605	admin	2018-11-14 15:25:11.213	AUTHENTICATION_SUCCESS
1606	admin	2018-11-14 15:55:25.007	AUTHENTICATION_SUCCESS
1607	admin	2018-11-14 15:55:50.645	AUTHENTICATION_SUCCESS
1608	admin	2018-11-14 15:56:14.955	AUTHENTICATION_SUCCESS
1609	admin	2018-11-14 15:56:41.79	AUTHENTICATION_SUCCESS
1610	admin	2018-11-14 15:58:12.792	AUTHENTICATION_SUCCESS
1611	admin	2018-11-14 15:58:45.826	AUTHENTICATION_SUCCESS
1612	admin	2018-11-14 15:58:56.559	AUTHENTICATION_SUCCESS
1613	admin	2018-11-14 15:59:31.638	AUTHENTICATION_SUCCESS
1614	admin	2018-11-14 16:01:33.217	AUTHENTICATION_SUCCESS
1615	admin	2018-11-14 16:02:14.113	AUTHENTICATION_SUCCESS
1616	admin	2018-11-14 16:02:26.314	AUTHENTICATION_SUCCESS
1617	admin	2018-11-14 16:02:36.441	AUTHENTICATION_SUCCESS
1618	admin	2018-11-14 16:03:36.317	AUTHENTICATION_SUCCESS
1651	admin	2018-11-14 16:08:25.14	AUTHENTICATION_SUCCESS
1652	admin	2018-11-14 16:08:36.971	AUTHENTICATION_SUCCESS
1653	admin	2018-11-14 16:09:26.874	AUTHENTICATION_SUCCESS
1654	admin	2018-11-14 16:09:55.67	AUTHENTICATION_SUCCESS
1655	admin	2018-11-14 16:10:29.973	AUTHENTICATION_SUCCESS
1656	admin	2018-11-14 16:11:16.373	AUTHENTICATION_SUCCESS
1657	admin	2018-11-14 16:11:46.515	AUTHENTICATION_SUCCESS
1658	admin	2018-11-14 16:12:14.429	AUTHENTICATION_SUCCESS
1659	admin	2018-11-14 16:12:29.411	AUTHENTICATION_SUCCESS
1660	admin	2018-11-14 16:13:09.264	AUTHENTICATION_SUCCESS
1661	admin	2018-11-14 16:13:35.045	AUTHENTICATION_SUCCESS
1851	admin	2018-11-14 16:15:41.248	AUTHENTICATION_SUCCESS
1852	admin	2018-11-14 16:19:29.492	AUTHENTICATION_SUCCESS
1853	admin	2018-11-14 16:20:42.671	AUTHENTICATION_SUCCESS
2051	admin	2018-11-14 16:25:56.734	AUTHENTICATION_SUCCESS
2052	admin	2018-11-14 16:29:52.596	AUTHENTICATION_SUCCESS
2053	admin	2018-11-14 16:30:51.384	AUTHENTICATION_SUCCESS
2054	admin	2018-11-14 16:32:36.169	AUTHENTICATION_SUCCESS
2055	admin	2018-11-14 16:48:48.672	AUTHENTICATION_SUCCESS
2056	admin	2018-11-14 16:49:57.13	AUTHENTICATION_SUCCESS
2057	admin	2018-11-14 16:51:12.376	AUTHENTICATION_SUCCESS
2058	admin	2018-11-14 16:52:24.919	AUTHENTICATION_SUCCESS
2059	admin	2018-11-14 16:53:12.598	AUTHENTICATION_SUCCESS
2060	admin	2018-11-14 16:53:38.227	AUTHENTICATION_SUCCESS
2061	admin	2018-11-14 16:54:09.86	AUTHENTICATION_SUCCESS
2251	admin	2018-11-14 16:55:10.736	AUTHENTICATION_SUCCESS
2252	admin	2018-11-14 16:55:47.349	AUTHENTICATION_SUCCESS
2253	admin	2018-11-14 16:56:25.877	AUTHENTICATION_SUCCESS
2254	admin	2018-11-14 16:56:50.088	AUTHENTICATION_SUCCESS
2301	admin	2018-11-14 17:01:38.93	AUTHENTICATION_SUCCESS
2302	admin	2018-11-14 17:05:52.742	AUTHENTICATION_SUCCESS
2401	admin	2018-11-15 10:52:27.138	AUTHENTICATION_SUCCESS
2402	admin	2018-11-15 10:53:06.999	AUTHENTICATION_SUCCESS
2403	admin	2018-11-15 13:06:39.633	AUTHENTICATION_SUCCESS
2404	admin	2018-11-15 13:07:55.494	AUTHENTICATION_SUCCESS
2405	admin	2018-11-15 13:07:58.988	AUTHENTICATION_SUCCESS
2406	admin	2018-11-15 13:08:23.455	AUTHENTICATION_SUCCESS
2407	admin	2018-11-15 13:08:44.77	AUTHENTICATION_SUCCESS
2408	admin	2018-11-15 13:08:54.671	AUTHENTICATION_SUCCESS
2409	admin	2018-11-15 13:09:51.509	AUTHENTICATION_SUCCESS
2410	admin	2018-11-15 13:11:29.966	AUTHENTICATION_SUCCESS
2701	admin	2018-11-15 15:56:53.235	AUTHENTICATION_SUCCESS
2702	admin	2018-11-15 15:57:02.262	AUTHENTICATION_SUCCESS
2703	admin	2018-11-15 15:57:32.856	AUTHENTICATION_SUCCESS
2704	admin	2018-11-16 13:35:01.735	AUTHENTICATION_SUCCESS
2705	admin	2018-11-16 13:36:43.545	AUTHENTICATION_SUCCESS
2706	admin	2018-11-16 13:37:08.53	AUTHENTICATION_SUCCESS
2707	admin	2018-11-16 13:42:12.596	AUTHENTICATION_SUCCESS
2751	admin	2018-11-16 13:44:42.513	AUTHENTICATION_SUCCESS
2752	admin	2018-11-16 13:44:47.37	AUTHENTICATION_SUCCESS
2753	admin	2018-11-16 13:45:20.05	AUTHENTICATION_SUCCESS
2754	admin	2018-11-16 13:45:46.586	AUTHENTICATION_SUCCESS
2755	admin	2018-11-16 13:49:09.56	AUTHENTICATION_SUCCESS
2756	admin	2018-11-16 13:52:10.694	AUTHENTICATION_SUCCESS
2757	admin	2018-11-16 13:52:19.472	AUTHENTICATION_SUCCESS
2758	admin	2018-11-16 13:52:34.9	AUTHENTICATION_SUCCESS
2759	admin	2018-11-16 13:53:22.601	AUTHENTICATION_SUCCESS
2760	admin	2018-11-16 13:55:08.617	AUTHENTICATION_SUCCESS
2761	admin	2018-11-16 13:55:15.39	AUTHENTICATION_SUCCESS
2762	admin	2018-11-16 13:55:32.6	AUTHENTICATION_SUCCESS
2763	admin	2018-11-16 13:56:21.152	AUTHENTICATION_SUCCESS
2764	admin	2018-11-16 13:56:44.148	AUTHENTICATION_SUCCESS
2765	admin	2018-11-16 13:57:16.56	AUTHENTICATION_SUCCESS
2766	admin	2018-11-16 13:57:25.657	AUTHENTICATION_SUCCESS
2767	admin	2018-11-16 13:59:01.681	AUTHENTICATION_SUCCESS
2768	admin	2018-11-16 14:00:10.576	AUTHENTICATION_SUCCESS
2769	admin	2018-11-16 14:00:50.888	AUTHENTICATION_SUCCESS
2770	admin	2018-11-16 14:05:07.468	AUTHENTICATION_SUCCESS
2771	admin	2018-11-16 14:05:15.77	AUTHENTICATION_SUCCESS
2772	admin	2018-11-16 14:05:25.575	AUTHENTICATION_SUCCESS
2773	admin	2018-11-16 14:06:10.993	AUTHENTICATION_SUCCESS
2774	admin	2018-11-16 14:06:47.861	AUTHENTICATION_SUCCESS
2775	admin	2018-11-16 14:06:58.456	AUTHENTICATION_SUCCESS
2776	admin	2018-11-16 14:07:17.922	AUTHENTICATION_SUCCESS
2777	admin	2018-11-16 14:07:47.23	AUTHENTICATION_SUCCESS
2778	admin	2018-11-16 14:55:13.815	AUTHENTICATION_SUCCESS
2779	admin	2018-11-16 14:56:26.556	AUTHENTICATION_SUCCESS
2780	admin	2018-11-16 14:57:55.78	AUTHENTICATION_SUCCESS
2781	admin	2018-11-16 15:03:19.701	AUTHENTICATION_SUCCESS
2782	admin	2018-11-16 15:04:43.987	AUTHENTICATION_SUCCESS
2783	admin	2018-11-16 15:05:48.613	AUTHENTICATION_SUCCESS
2784	admin	2018-11-16 15:06:04.505	AUTHENTICATION_SUCCESS
2785	admin	2018-11-16 15:06:42.284	AUTHENTICATION_SUCCESS
2786	admin	2018-11-16 15:07:16.121	AUTHENTICATION_SUCCESS
2787	admin	2018-11-16 15:08:08.841	AUTHENTICATION_SUCCESS
2788	admin	2018-11-16 15:17:58.722	AUTHENTICATION_SUCCESS
2789	admin	2018-11-19 12:44:37.386	AUTHENTICATION_SUCCESS
2790	admin	2018-11-19 12:45:48.945	AUTHENTICATION_SUCCESS
2791	admin	2018-11-20 09:14:23.937	AUTHENTICATION_SUCCESS
2792	admin	2018-11-20 09:17:12.534	AUTHENTICATION_SUCCESS
2951	admin	2018-11-20 09:53:17.163	AUTHENTICATION_SUCCESS
2952	admin	2018-11-20 09:53:51.138	AUTHENTICATION_SUCCESS
2953	admin	2018-11-20 09:54:14.686	AUTHENTICATION_SUCCESS
2954	admin	2018-11-20 09:54:38.549	AUTHENTICATION_SUCCESS
2955	admin	2018-11-20 09:54:54.725	AUTHENTICATION_SUCCESS
2956	admin	2018-11-20 09:55:13.131	AUTHENTICATION_SUCCESS
2957	admin	2018-11-20 09:55:49.502	AUTHENTICATION_SUCCESS
2958	admin	2018-11-20 09:57:20.973	AUTHENTICATION_SUCCESS
2959	admin	2018-11-20 09:57:51.261	AUTHENTICATION_SUCCESS
2960	admin	2018-11-20 09:58:57.54	AUTHENTICATION_SUCCESS
3001	admin	2018-11-20 10:02:22.992	AUTHENTICATION_SUCCESS
3002	admin	2018-11-20 10:02:55.444	AUTHENTICATION_SUCCESS
3003	admin	2018-11-20 10:04:01.954	AUTHENTICATION_SUCCESS
3004	admin	2018-11-20 10:06:25.896	AUTHENTICATION_SUCCESS
3005	admin	2018-11-20 10:08:28.582	AUTHENTICATION_SUCCESS
3006	admin	2018-11-20 10:08:41.981	AUTHENTICATION_SUCCESS
3007	admin	2018-11-20 10:08:55.256	AUTHENTICATION_SUCCESS
3008	admin	2018-11-20 10:09:02.15	AUTHENTICATION_SUCCESS
3009	admin	2018-11-20 10:10:07.304	AUTHENTICATION_SUCCESS
3051	admin	2018-11-20 10:18:35.515	AUTHENTICATION_SUCCESS
3052	admin	2018-11-20 10:18:59.853	AUTHENTICATION_SUCCESS
3053	admin	2018-11-20 10:19:04.569	AUTHENTICATION_SUCCESS
3054	admin	2018-11-20 10:22:47.131	AUTHENTICATION_SUCCESS
3055	admin	2018-11-20 10:25:36.945	AUTHENTICATION_SUCCESS
3056	admin	2018-11-20 10:29:33.741	AUTHENTICATION_SUCCESS
3057	admin	2018-11-20 10:30:02.704	AUTHENTICATION_SUCCESS
3058	admin	2018-11-20 10:31:32.905	AUTHENTICATION_SUCCESS
3059	admin	2018-11-20 10:31:43.369	AUTHENTICATION_SUCCESS
3060	admin	2018-11-20 10:34:30.842	AUTHENTICATION_SUCCESS
3061	admin	2018-11-20 10:35:37.027	AUTHENTICATION_SUCCESS
3062	admin	2018-11-20 10:35:46.224	AUTHENTICATION_SUCCESS
3063	admin	2018-11-20 10:36:50.868	AUTHENTICATION_SUCCESS
3064	admin	2018-11-20 10:37:12.596	AUTHENTICATION_SUCCESS
3065	admin	2018-11-20 10:37:24.698	AUTHENTICATION_SUCCESS
3066	admin	2018-11-20 10:38:12.085	AUTHENTICATION_SUCCESS
3067	admin	2018-11-20 10:40:22.121	AUTHENTICATION_SUCCESS
3068	admin	2018-11-20 10:41:28.604	AUTHENTICATION_SUCCESS
3069	admin	2018-11-20 10:43:45.583	AUTHENTICATION_SUCCESS
3070	admin	2018-11-20 10:45:15.521	AUTHENTICATION_SUCCESS
3151	admin	2018-11-20 10:51:01.187	AUTHENTICATION_SUCCESS
3152	admin	2018-11-20 10:51:35.977	AUTHENTICATION_SUCCESS
3153	admin	2018-11-20 10:52:15.589	AUTHENTICATION_SUCCESS
3154	admin	2018-11-20 10:54:00.015	AUTHENTICATION_SUCCESS
3251	admin	2018-11-20 10:56:13.455	AUTHENTICATION_SUCCESS
3351	admin	2018-11-20 11:02:51.213	AUTHENTICATION_SUCCESS
3451	admin	2018-11-20 11:26:46.785	AUTHENTICATION_SUCCESS
3651	admin	2018-11-20 11:39:37.609	AUTHENTICATION_SUCCESS
3851	admin	2018-11-20 11:42:32.442	AUTHENTICATION_SUCCESS
3852	admin	2018-11-20 12:15:30.367	AUTHENTICATION_SUCCESS
3853	admin	2018-11-20 12:17:02.643	AUTHENTICATION_SUCCESS
4051	admin	2018-11-21 09:01:32.024	AUTHENTICATION_SUCCESS
4052	admin	2018-11-21 09:02:10.235	AUTHENTICATION_SUCCESS
4053	admin	2018-11-21 09:04:32.242	AUTHENTICATION_SUCCESS
4054	admin	2018-11-21 09:07:57.571	AUTHENTICATION_SUCCESS
4055	admin	2018-11-21 09:09:14.736	AUTHENTICATION_SUCCESS
4056	admin	2018-11-21 09:09:24.439	AUTHENTICATION_SUCCESS
4057	admin	2018-11-21 09:09:45.19	AUTHENTICATION_SUCCESS
4058	admin	2018-11-21 09:10:15.676	AUTHENTICATION_SUCCESS
4059	admin	2018-11-21 09:10:53.6	AUTHENTICATION_SUCCESS
4060	admin	2018-11-21 09:14:23.775	AUTHENTICATION_SUCCESS
4061	admin	2018-11-21 09:16:40.569	AUTHENTICATION_SUCCESS
4062	admin	2018-11-21 09:17:09.672	AUTHENTICATION_SUCCESS
4063	admin	2018-11-21 09:18:32.432	AUTHENTICATION_SUCCESS
4251	admin	2018-11-21 09:31:45.538	AUTHENTICATION_SUCCESS
4301	admin	2018-11-21 09:35:32.814	AUTHENTICATION_SUCCESS
4351	admin	2018-11-21 09:36:41.366	AUTHENTICATION_SUCCESS
4551	admin	2018-11-21 09:43:51.461	AUTHENTICATION_SUCCESS
4552	admin	2018-11-21 09:45:26.075	AUTHENTICATION_SUCCESS
4553	admin	2018-11-21 09:46:02.713	AUTHENTICATION_SUCCESS
4554	admin	2018-11-21 09:47:44.947	AUTHENTICATION_SUCCESS
4555	admin	2018-11-21 09:47:59.319	AUTHENTICATION_SUCCESS
4556	admin	2018-11-21 09:48:21.823	AUTHENTICATION_SUCCESS
4557	admin	2018-11-22 06:18:14.85	AUTHENTICATION_SUCCESS
4558	admin	2018-11-22 06:19:44.557	AUTHENTICATION_SUCCESS
4559	admin	2018-11-22 06:24:42.083	AUTHENTICATION_SUCCESS
4560	admin	2018-11-22 06:27:16.831	AUTHENTICATION_SUCCESS
4561	admin	2018-11-22 06:27:42.018	AUTHENTICATION_SUCCESS
4562	admin	2018-11-22 06:28:23.656	AUTHENTICATION_SUCCESS
4563	admin	2018-11-22 06:29:00.673	AUTHENTICATION_SUCCESS
4564	admin	2018-11-22 06:29:44.271	AUTHENTICATION_SUCCESS
4565	admin	2018-11-22 06:30:36.012	AUTHENTICATION_SUCCESS
4566	admin	2018-11-22 06:33:08.785	AUTHENTICATION_SUCCESS
4567	admin	2018-11-22 06:33:54.858	AUTHENTICATION_SUCCESS
4568	admin	2018-11-22 06:34:26.461	AUTHENTICATION_SUCCESS
4569	admin	2018-11-22 06:34:44.51	AUTHENTICATION_SUCCESS
4570	admin	2018-11-22 06:35:31.491	AUTHENTICATION_SUCCESS
4571	admin	2018-11-22 06:35:42.771	AUTHENTICATION_SUCCESS
4572	admin	2018-11-22 06:36:34.271	AUTHENTICATION_SUCCESS
4573	admin	2018-11-22 06:40:04.91	AUTHENTICATION_SUCCESS
4574	admin	2018-11-22 06:40:15.359	AUTHENTICATION_SUCCESS
4575	admin	2018-11-22 06:40:33.618	AUTHENTICATION_SUCCESS
4576	admin	2018-11-22 06:41:22.142	AUTHENTICATION_SUCCESS
4577	admin	2018-11-22 06:44:33.29	AUTHENTICATION_SUCCESS
4578	admin	2018-11-22 06:56:50.468	AUTHENTICATION_SUCCESS
4579	admin	2018-11-22 06:58:47.648	AUTHENTICATION_SUCCESS
4580	admin	2018-11-22 06:59:13.467	AUTHENTICATION_SUCCESS
4581	admin	2018-11-22 07:00:12.48	AUTHENTICATION_SUCCESS
4582	admin	2018-11-22 07:01:52.446	AUTHENTICATION_SUCCESS
4583	admin	2018-11-22 07:02:33.673	AUTHENTICATION_SUCCESS
4584	admin	2018-11-22 07:03:38.506	AUTHENTICATION_SUCCESS
4585	admin	2018-11-22 07:05:52.729	AUTHENTICATION_SUCCESS
4586	admin	2018-11-22 07:06:00.234	AUTHENTICATION_SUCCESS
4587	admin	2018-11-22 07:07:10.96	AUTHENTICATION_SUCCESS
4588	admin	2018-11-22 07:07:33.105	AUTHENTICATION_SUCCESS
4589	admin	2018-11-22 07:07:46.164	AUTHENTICATION_SUCCESS
4590	admin	2018-11-22 07:08:08.006	AUTHENTICATION_SUCCESS
4591	admin	2018-11-22 07:11:09.748	AUTHENTICATION_SUCCESS
4592	admin	2018-11-22 07:11:56.678	AUTHENTICATION_SUCCESS
4751	admin	2018-11-22 07:17:23.718	AUTHENTICATION_SUCCESS
4752	admin	2018-11-22 07:18:55.262	AUTHENTICATION_SUCCESS
4753	admin	2018-11-22 07:19:51.865	AUTHENTICATION_SUCCESS
4754	admin	2018-11-22 07:20:42.559	AUTHENTICATION_SUCCESS
4755	admin	2018-11-22 07:20:53.28	AUTHENTICATION_SUCCESS
4756	admin	2018-11-22 07:21:13.964	AUTHENTICATION_SUCCESS
4757	admin	2018-11-22 07:21:32.153	AUTHENTICATION_SUCCESS
4758	admin	2018-11-22 07:21:42.457	AUTHENTICATION_SUCCESS
4759	admin	2018-11-22 07:22:37.565	AUTHENTICATION_SUCCESS
4760	admin	2018-11-22 07:23:06.411	AUTHENTICATION_SUCCESS
4761	admin	2018-11-22 07:23:14.298	AUTHENTICATION_SUCCESS
4762	admin	2018-11-22 07:23:55.261	AUTHENTICATION_SUCCESS
4763	admin	2018-11-22 07:24:11.111	AUTHENTICATION_SUCCESS
4764	admin	2018-11-22 07:24:39.247	AUTHENTICATION_SUCCESS
4765	admin	2018-11-22 07:24:51.104	AUTHENTICATION_SUCCESS
4766	admin	2018-11-22 07:25:25.304	AUTHENTICATION_SUCCESS
4767	admin	2018-11-22 07:25:49.364	AUTHENTICATION_SUCCESS
4768	admin	2018-11-22 07:25:59.276	AUTHENTICATION_SUCCESS
4769	admin	2018-11-22 07:26:12.556	AUTHENTICATION_SUCCESS
4770	admin	2018-11-22 07:27:01.447	AUTHENTICATION_SUCCESS
4771	admin	2018-11-22 07:27:16.703	AUTHENTICATION_SUCCESS
4772	admin	2018-11-22 07:27:52.096	AUTHENTICATION_SUCCESS
4773	admin	2018-11-22 07:28:10.911	AUTHENTICATION_SUCCESS
4774	admin	2018-11-22 07:28:40.769	AUTHENTICATION_SUCCESS
4775	admin	2018-11-22 07:28:54.472	AUTHENTICATION_SUCCESS
4776	admin	2018-11-22 07:29:14.071	AUTHENTICATION_SUCCESS
4777	admin	2018-11-22 07:29:22.391	AUTHENTICATION_SUCCESS
4778	admin	2018-11-22 07:29:33.207	AUTHENTICATION_SUCCESS
4779	admin	2018-11-22 07:30:09.66	AUTHENTICATION_SUCCESS
4780	admin	2018-11-22 07:30:25.585	AUTHENTICATION_SUCCESS
4781	admin	2018-11-22 07:30:49.752	AUTHENTICATION_SUCCESS
4782	admin	2018-11-22 07:33:03.434	AUTHENTICATION_SUCCESS
4783	admin	2018-11-22 07:33:47.09	AUTHENTICATION_SUCCESS
4784	admin	2018-11-22 07:36:14.156	AUTHENTICATION_SUCCESS
4785	admin	2018-11-22 07:36:30.879	AUTHENTICATION_SUCCESS
4786	admin	2018-11-22 07:36:36.919	AUTHENTICATION_SUCCESS
4787	admin	2018-11-22 07:37:04.454	AUTHENTICATION_SUCCESS
4788	admin	2018-11-22 07:41:39.086	AUTHENTICATION_SUCCESS
4789	admin	2018-11-22 07:43:17.96	AUTHENTICATION_SUCCESS
4790	admin	2018-11-22 07:43:38.634	AUTHENTICATION_SUCCESS
4791	admin	2018-11-22 07:44:38.863	AUTHENTICATION_SUCCESS
4792	admin	2018-11-22 07:45:08.227	AUTHENTICATION_SUCCESS
4793	admin	2018-11-22 07:46:04.161	AUTHENTICATION_SUCCESS
4794	admin	2018-11-22 07:46:22.816	AUTHENTICATION_SUCCESS
4795	admin	2018-11-22 07:48:26.537	AUTHENTICATION_SUCCESS
4796	admin	2018-11-22 07:48:45.433	AUTHENTICATION_SUCCESS
4797	admin	2018-11-22 07:49:08.28	AUTHENTICATION_SUCCESS
4798	admin	2018-11-22 07:49:18.973	AUTHENTICATION_SUCCESS
4799	admin	2018-11-22 07:49:36.722	AUTHENTICATION_SUCCESS
4800	admin	2018-11-22 07:50:51.247	AUTHENTICATION_SUCCESS
4801	admin	2018-11-22 07:51:00.107	AUTHENTICATION_SUCCESS
4802	admin	2018-11-22 07:52:28.578	AUTHENTICATION_SUCCESS
4803	admin	2018-11-22 07:52:35.892	AUTHENTICATION_SUCCESS
4804	admin	2018-11-22 07:53:01.988	AUTHENTICATION_SUCCESS
4805	admin	2018-11-22 07:53:27.143	AUTHENTICATION_SUCCESS
4806	admin	2018-11-22 07:54:36.486	AUTHENTICATION_SUCCESS
4807	admin	2018-11-22 07:55:17.58	AUTHENTICATION_SUCCESS
4808	admin	2018-11-22 07:56:05.992	AUTHENTICATION_SUCCESS
4809	admin	2018-11-22 07:57:06.913	AUTHENTICATION_SUCCESS
4810	admin	2018-11-22 07:58:46.861	AUTHENTICATION_SUCCESS
4811	admin	2018-11-22 08:02:48.722	AUTHENTICATION_SUCCESS
4812	admin	2018-11-22 08:04:58.292	AUTHENTICATION_SUCCESS
4813	admin	2018-11-22 08:05:48.005	AUTHENTICATION_SUCCESS
4814	admin	2018-11-22 08:06:08.458	AUTHENTICATION_SUCCESS
4815	admin	2018-11-22 08:07:44.603	AUTHENTICATION_SUCCESS
4816	admin	2018-11-22 08:07:59.804	AUTHENTICATION_SUCCESS
4817	admin	2018-11-22 08:41:27.661	AUTHENTICATION_SUCCESS
4818	admin	2018-11-22 08:41:40.142	AUTHENTICATION_SUCCESS
4819	admin	2018-11-22 08:42:06.68	AUTHENTICATION_SUCCESS
4820	rousludek	2018-11-22 08:42:18.18	AUTHENTICATION_SUCCESS
4821	rousludek	2018-11-22 08:42:25.133	AUTHENTICATION_SUCCESS
4822	rousludek	2018-11-22 08:42:29.266	AUTHENTICATION_SUCCESS
4823	admin	2018-11-22 08:42:38.993	AUTHENTICATION_SUCCESS
4824	admin	2018-11-22 08:43:12.611	AUTHENTICATION_SUCCESS
4825	admin	2018-11-22 08:43:25.613	AUTHENTICATION_SUCCESS
4826	admin	2018-11-22 08:43:35.882	AUTHENTICATION_SUCCESS
4827	rousludek	2018-11-22 08:43:52.546	AUTHENTICATION_SUCCESS
4828	admin	2018-11-22 08:45:24.321	AUTHENTICATION_SUCCESS
4829	rousludek	2018-11-22 08:45:40.982	AUTHENTICATION_SUCCESS
4830	admin	2018-11-22 08:47:35.567	AUTHENTICATION_SUCCESS
4831	admin	2018-11-22 08:47:42.451	AUTHENTICATION_SUCCESS
4832	rousludek	2018-11-22 08:47:54.728	AUTHENTICATION_SUCCESS
4833	admin	2018-11-22 08:50:01.589	AUTHENTICATION_SUCCESS
4834	admin	2018-11-22 08:50:34.466	AUTHENTICATION_SUCCESS
4835	rousludek	2018-11-22 08:50:48.067	AUTHENTICATION_SUCCESS
4836	admin	2018-11-22 08:52:12.597	AUTHENTICATION_SUCCESS
4837	admin	2018-11-22 08:52:25.891	AUTHENTICATION_SUCCESS
4838	rousludek	2018-11-22 08:52:39.637	AUTHENTICATION_SUCCESS
4839	rousludek	2018-11-22 08:52:52.98	AUTHENTICATION_SUCCESS
4840	rousludek	2018-11-22 08:53:01.873	AUTHENTICATION_SUCCESS
4841	admin	2018-11-22 08:53:56.69	AUTHENTICATION_SUCCESS
4842	rousludek	2018-11-22 08:54:24.955	AUTHENTICATION_SUCCESS
4843	admin	2018-11-22 08:54:40.72	AUTHENTICATION_SUCCESS
4844	rousludek	2018-11-22 08:54:54.694	AUTHENTICATION_SUCCESS
4845	admin	2018-11-22 08:55:20.141	AUTHENTICATION_SUCCESS
4846	rousludek	2018-11-22 08:55:44.847	AUTHENTICATION_SUCCESS
4847	admin	2018-11-22 08:56:13.603	AUTHENTICATION_SUCCESS
4848	admin	2018-11-22 08:57:51.819	AUTHENTICATION_SUCCESS
4849	rousludek	2018-11-22 08:58:01.961	AUTHENTICATION_SUCCESS
4850	admin	2018-11-22 08:58:06.841	AUTHENTICATION_SUCCESS
5001	admin	2018-11-22 08:58:30.756	AUTHENTICATION_SUCCESS
5002	admin	2018-11-22 08:59:17.704	AUTHENTICATION_SUCCESS
5051	rousludek	2018-11-22 09:03:28.403	AUTHENTICATION_SUCCESS
5052	admin	2018-11-22 09:03:44.993	AUTHENTICATION_SUCCESS
5053	manager	2018-11-22 09:03:55.346	AUTHENTICATION_FAILURE
5054	manager	2018-11-22 09:03:58.195	AUTHENTICATION_FAILURE
5055	manager	2018-11-22 09:04:07.569	AUTHENTICATION_FAILURE
5056	admin	2018-11-22 09:04:25.379	AUTHENTICATION_SUCCESS
5057	admin	2018-11-22 09:04:34.344	AUTHENTICATION_SUCCESS
5058	rousludek	2018-11-22 09:04:44.694	AUTHENTICATION_SUCCESS
5059	admin	2018-11-22 09:04:48.532	AUTHENTICATION_SUCCESS
5060	admin	2018-11-22 09:04:57.699	AUTHENTICATION_SUCCESS
5101	rousludek	2018-11-22 09:07:46.125	AUTHENTICATION_SUCCESS
5102	rousludek	2018-11-22 09:09:53.834	AUTHENTICATION_SUCCESS
5103	rousludek	2018-11-22 09:10:18.556	AUTHENTICATION_SUCCESS
5104	rousludek	2018-11-22 09:11:50.722	AUTHENTICATION_SUCCESS
5105	rousludek	2018-11-22 09:15:31.139	AUTHENTICATION_SUCCESS
5151	rousludek	2018-11-22 09:19:29.607	AUTHENTICATION_SUCCESS
5152	rousludek	2018-11-22 09:20:35.178	AUTHENTICATION_SUCCESS
5153	rousludek	2018-11-22 09:22:44.334	AUTHENTICATION_SUCCESS
5201	admin	2018-11-22 12:46:13.529	AUTHENTICATION_SUCCESS
5202	admin	2018-11-22 12:46:15.315	AUTHENTICATION_SUCCESS
5203	admin	2018-11-22 12:46:19.195	AUTHENTICATION_SUCCESS
6301	admin	2018-11-29 14:52:12.926	AUTHENTICATION_SUCCESS
6851	rousludek	2018-11-29 15:24:02.869	AUTHENTICATION_SUCCESS
6852	rousludek	2018-11-29 15:24:13.124	AUTHENTICATION_SUCCESS
6901	admin	2018-11-29 21:57:57.66	AUTHENTICATION_SUCCESS
6902	admin	2018-11-29 21:58:01.694	AUTHENTICATION_SUCCESS
6903	admin	2018-11-29 21:58:02.891	AUTHENTICATION_SUCCESS
6904	rousludek	2018-11-29 22:12:49.283	AUTHENTICATION_SUCCESS
6905	rousludek	2018-11-29 22:13:42.768	AUTHENTICATION_SUCCESS
6906	admin	2018-11-29 22:14:56.663	AUTHENTICATION_SUCCESS
6907	rousludek	2018-11-29 22:16:32.363	AUTHENTICATION_SUCCESS
7001	admin	2018-12-03 09:51:04.888	AUTHENTICATION_SUCCESS
7002	rousludek	2018-12-03 09:53:02.858	AUTHENTICATION_SUCCESS
7051	admin	2018-12-04 09:48:01.496	AUTHENTICATION_SUCCESS
9101	admin	2018-12-05 14:11:45.629	AUTHENTICATION_SUCCESS
9102	admin	2018-12-05 14:18:27.296	AUTHENTICATION_SUCCESS
17351	rousludek	2018-12-05 14:33:28.293	AUTHENTICATION_SUCCESS
17401	admin	2018-12-10 19:15:35.86	AUTHENTICATION_SUCCESS
17402	rousludek	2018-12-10 19:22:57.21	AUTHENTICATION_SUCCESS
17403	admin	2018-12-10 19:34:05.372	AUTHENTICATION_SUCCESS
17551	admin	2018-12-10 19:40:10.079	AUTHENTICATION_SUCCESS
17552	admin	2018-12-10 19:46:26.953	AUTHENTICATION_SUCCESS
17553	seli	2018-12-10 19:46:51.751	AUTHENTICATION_SUCCESS
17554	seli	2018-12-10 19:46:54.652	AUTHENTICATION_SUCCESS
17555	rousludek	2018-12-10 19:48:41.452	AUTHENTICATION_SUCCESS
26701	admin	2018-12-12 09:59:17.478	AUTHENTICATION_SUCCESS
44851	admin	2018-12-14 13:47:39.8	AUTHENTICATION_SUCCESS
53301	rousludek@gmail.com	2018-12-14 14:03:24.993	AUTHENTICATION_FAILURE
53302	rousludek@gmail.com	2018-12-14 14:03:30.429	AUTHENTICATION_FAILURE
53303	rousludek	2018-12-14 14:03:49.86	AUTHENTICATION_SUCCESS
53351	admin	2018-12-17 22:30:00.988	AUTHENTICATION_SUCCESS
70201	admin	2018-12-19 12:06:57.415	AUTHENTICATION_SUCCESS
78651	admin	2019-01-08 09:10:50.198	AUTHENTICATION_SUCCESS
78701	rousludek@gmail.com	2019-01-08 21:50:45.167	AUTHENTICATION_FAILURE
78702	rousludek@gmail.com	2019-01-08 21:50:53.277	AUTHENTICATION_FAILURE
78703	rousludek@gmail.com	2019-01-08 21:51:05.672	AUTHENTICATION_FAILURE
78704	rousludek	2019-01-08 21:51:17.575	AUTHENTICATION_SUCCESS
78705	admin	2019-01-08 23:05:45.365	AUTHENTICATION_FAILURE
78706	admin	2019-01-08 23:05:47.958	AUTHENTICATION_FAILURE
78707	admin	2019-01-08 23:06:00.161	AUTHENTICATION_FAILURE
78708	admin	2019-01-08 23:06:11.959	AUTHENTICATION_FAILURE
78709	admin	2019-01-08 23:06:17.76	AUTHENTICATION_SUCCESS
78751	manager	2019-01-09 10:23:55.496	AUTHENTICATION_FAILURE
78752	admin	2019-01-09 10:24:07.891	AUTHENTICATION_SUCCESS
78801	rousludek	2019-01-09 10:57:57.668	AUTHENTICATION_SUCCESS
78851	admin	2019-01-09 12:35:11.274	AUTHENTICATION_SUCCESS
78852	rousludek	2019-01-09 12:36:02.781	AUTHENTICATION_SUCCESS
78853	admin	2019-01-09 12:42:05.301	AUTHENTICATION_SUCCESS
78854	rousludek	2019-01-09 12:43:26.619	AUTHENTICATION_SUCCESS
78855	admin	2019-01-09 13:18:05.768	AUTHENTICATION_SUCCESS
78856	rousludek	2019-01-09 13:18:39.728	AUTHENTICATION_SUCCESS
78901	admin	2019-01-10 09:45:48.303	AUTHENTICATION_SUCCESS
78902	admin	2019-01-10 09:54:33.526	AUTHENTICATION_SUCCESS
78903	admin	2019-01-10 09:57:38.709	AUTHENTICATION_SUCCESS
78904	admin	2019-01-10 09:59:18.382	AUTHENTICATION_SUCCESS
78905	admin	2019-01-10 10:00:51.397	AUTHENTICATION_SUCCESS
78906	admin	2019-01-10 10:00:53.498	AUTHENTICATION_SUCCESS
78907	admin	2019-01-10 10:01:07.15	AUTHENTICATION_SUCCESS
78908	admin	2019-01-10 10:01:08.772	AUTHENTICATION_SUCCESS
78909	admin	2019-01-10 10:04:15.342	AUTHENTICATION_SUCCESS
78910	admin	2019-01-10 10:05:32.26	AUTHENTICATION_SUCCESS
78911	rousludek	2019-01-10 10:07:24.573	AUTHENTICATION_SUCCESS
78912	admin	2019-01-10 10:08:01.983	AUTHENTICATION_SUCCESS
78913	rousludek	2019-01-10 11:25:03.023	AUTHENTICATION_SUCCESS
78914	admin	2019-01-10 11:25:24.701	AUTHENTICATION_SUCCESS
78951	admin	2019-01-14 11:16:41.09	AUTHENTICATION_FAILURE
78952	admin	2019-01-14 11:16:48.036	AUTHENTICATION_FAILURE
78953	admin	2019-01-14 11:16:51.248	AUTHENTICATION_FAILURE
78954	admin	2019-01-14 11:16:54.291	AUTHENTICATION_SUCCESS
79001	admin	2019-01-14 22:37:23.799	AUTHENTICATION_SUCCESS
79002	admin	2019-01-15 10:27:20.696	AUTHENTICATION_SUCCESS
80551	rousludek@gmail.com	2019-01-22 14:08:10.456	AUTHENTICATION_FAILURE
80552	rousludek@gmail.com	2019-01-22 14:08:15.687	AUTHENTICATION_FAILURE
80553	rousludek	2019-01-22 14:08:27.379	AUTHENTICATION_SUCCESS
80601	admin	2019-01-22 14:12:34.129	AUTHENTICATION_FAILURE
80602	admin	2019-01-22 14:12:39.695	AUTHENTICATION_SUCCESS
80951	rousludek	2019-01-22 14:24:30.517	AUTHENTICATION_SUCCESS
80952	admin	2019-01-22 14:55:33.733	AUTHENTICATION_SUCCESS
80953	admin	2019-01-22 14:55:41.425	AUTHENTICATION_SUCCESS
80954	rousludek	2019-01-22 14:56:02.137	AUTHENTICATION_SUCCESS
80955	asdasd	2019-01-22 14:58:06.131	AUTHENTICATION_FAILURE
80956	asdasd	2019-01-22 15:00:10.925	AUTHENTICATION_FAILURE
80957	asdasd	2019-01-22 15:01:15.92	AUTHENTICATION_FAILURE
80958	dsfsdfs	2019-01-22 15:10:11.116	AUTHENTICATION_FAILURE
80959	admin	2019-01-22 15:10:44.311	AUTHENTICATION_SUCCESS
81001	admin	2019-01-22 17:42:37.974	AUTHENTICATION_SUCCESS
81002	admin	2019-01-22 18:12:51.255	AUTHENTICATION_SUCCESS
81051	asd	2019-01-22 21:57:23.276	AUTHENTICATION_FAILURE
81101	admin	2019-01-22 22:17:36.989	AUTHENTICATION_FAILURE
81102	admin	2019-01-22 22:17:43.596	AUTHENTICATION_FAILURE
81103	admin	2019-01-22 22:17:51.304	AUTHENTICATION_FAILURE
81104	admin	2019-01-23 07:06:39.964	AUTHENTICATION_SUCCESS
81105	admin	2019-01-23 07:07:02.284	AUTHENTICATION_SUCCESS
81301	admin	2019-01-23 07:16:45.723	AUTHENTICATION_SUCCESS
81501	admin	2019-01-23 07:31:31.664	AUTHENTICATION_SUCCESS
81502	admin	2019-01-23 08:01:33.79	AUTHENTICATION_SUCCESS
81651	ludarous	2019-01-23 08:05:04.883	AUTHENTICATION_FAILURE
81652	ludarous	2019-01-23 08:05:04.884	AUTHENTICATION_FAILURE
81653	ludarous	2019-01-23 08:05:11.277	AUTHENTICATION_SUCCESS
81654	ludarous	2019-01-23 08:21:41.029	AUTHENTICATION_FAILURE
81655	ludarous	2019-01-23 08:23:28.634	AUTHENTICATION_SUCCESS
81656	ludarous	2019-01-23 08:34:55.733	AUTHENTICATION_SUCCESS
81851	admin	2019-01-23 15:23:17.864	AUTHENTICATION_SUCCESS
81901	admin	2019-01-23 16:18:10.528	AUTHENTICATION_SUCCESS
81902	rousludek@gmail.com	2019-01-23 16:34:46.695	AUTHENTICATION_FAILURE
81903	rousludek	2019-01-23 16:34:52.062	AUTHENTICATION_SUCCESS
81951	admin	2019-01-25 09:44:57.553	AUTHENTICATION_SUCCESS
82151	admin	2019-01-25 10:30:45.407	AUTHENTICATION_SUCCESS
82152	ludek-r@volny.czz	2019-01-25 10:32:22.403	AUTHENTICATION_FAILURE
82153	ludek	2019-01-25 10:32:51.061	AUTHENTICATION_SUCCESS
82501	admin	2019-01-25 10:57:54.806	AUTHENTICATION_SUCCESS
82502	ludek	2019-01-25 11:11:09.86	AUTHENTICATION_SUCCESS
82503	admin	2019-01-25 11:14:17.932	AUTHENTICATION_SUCCESS
82504	ludek	2019-01-25 11:15:12.202	AUTHENTICATION_SUCCESS
83451	admin	2019-01-25 21:08:27.82	AUTHENTICATION_SUCCESS
83551	admin	2019-01-25 23:21:09.842	AUTHENTICATION_SUCCESS
83552	ludek	2019-01-25 23:49:21.197	AUTHENTICATION_SUCCESS
83601	admin	2019-01-28 08:19:55.573	AUTHENTICATION_SUCCESS
83701	admin	2019-01-28 08:35:24.122	AUTHENTICATION_SUCCESS
83851	admin	2019-01-28 10:13:13.068	AUTHENTICATION_SUCCESS
84151	admin	2019-01-28 14:31:20.849	AUTHENTICATION_SUCCESS
\.


--
-- TOC entry 3038 (class 0 OID 60397)
-- Dependencies: 203
-- Data for Name: jhi_persistent_audit_evt_data; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_persistent_audit_evt_data (event_id, name, value) FROM stdin;
5053	type	org.springframework.security.authentication.BadCredentialsException
5053	message	Bad credentials
5054	type	org.springframework.security.authentication.BadCredentialsException
5054	message	Bad credentials
5055	type	org.springframework.security.authentication.BadCredentialsException
5055	message	Bad credentials
53301	type	org.springframework.security.authentication.BadCredentialsException
53301	message	Bad credentials
53302	type	org.springframework.security.authentication.BadCredentialsException
53302	message	Bad credentials
78701	type	org.springframework.security.authentication.BadCredentialsException
78701	message	Bad credentials
78702	type	org.springframework.security.authentication.BadCredentialsException
78702	message	Bad credentials
78703	type	org.springframework.security.authentication.BadCredentialsException
78703	message	Bad credentials
78705	type	org.springframework.security.authentication.BadCredentialsException
78705	message	Bad credentials
78706	type	org.springframework.security.authentication.BadCredentialsException
78706	message	Bad credentials
78707	type	org.springframework.security.authentication.BadCredentialsException
78707	message	Bad credentials
78708	type	org.springframework.security.authentication.BadCredentialsException
78708	message	Bad credentials
78751	type	org.springframework.security.authentication.BadCredentialsException
78751	message	Bad credentials
78951	type	org.springframework.security.authentication.BadCredentialsException
78951	message	Bad credentials
78952	type	org.springframework.security.authentication.BadCredentialsException
78952	message	Bad credentials
78953	type	org.springframework.security.authentication.BadCredentialsException
78953	message	Bad credentials
80551	type	org.springframework.security.authentication.BadCredentialsException
80551	message	Bad credentials
80552	type	org.springframework.security.authentication.BadCredentialsException
80552	message	Bad credentials
80601	type	org.springframework.security.authentication.BadCredentialsException
80601	message	Bad credentials
80955	type	org.springframework.security.authentication.BadCredentialsException
80955	message	Bad credentials
80956	type	org.springframework.security.authentication.BadCredentialsException
80956	message	Bad credentials
80957	type	org.springframework.security.authentication.BadCredentialsException
80957	message	Bad credentials
80958	type	org.springframework.security.authentication.BadCredentialsException
80958	message	Bad credentials
81051	type	org.springframework.security.authentication.BadCredentialsException
81051	message	Bad credentials
81101	type	org.springframework.security.authentication.BadCredentialsException
81101	message	Bad credentials
81102	type	org.springframework.security.authentication.BadCredentialsException
81102	message	Bad credentials
81103	type	org.springframework.security.authentication.BadCredentialsException
81103	message	Bad credentials
81651	type	org.springframework.security.authentication.BadCredentialsException
81652	type	org.springframework.security.authentication.BadCredentialsException
81652	message	Bad credentials
81651	message	Bad credentials
81654	type	org.springframework.security.authentication.BadCredentialsException
81654	message	Bad credentials
81902	type	org.springframework.security.authentication.BadCredentialsException
81902	message	Bad credentials
82152	type	org.springframework.security.authentication.BadCredentialsException
82152	message	Bad credentials
\.


--
-- TOC entry 3034 (class 0 OID 60359)
-- Dependencies: 199
-- Data for Name: jhi_user; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_user (id, login, password_hash, first_name, last_name, email, image_url, activated, lang_key, activation_key, reset_key, created_by, created_date, reset_date, last_modified_by, last_modified_date) FROM stdin;
1	system	$2a$10$mE.qmcV0mFU5NcKh73TZx.z4ueI/.bDWbj0T1BYyqP481kGGarKLG	System	System	system@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
2	anonymoususer	$2a$10$j8S5d7Sr7.8VTOYNviDPOeWX8KcYILUVJBsYV83Y5NtECayypx9lO	Anonymous	User	anonymous@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
3	admin	$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC	Administrator	Administrator	admin@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
4	user	$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K	User	User	user@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
2351	rousludek	$2a$10$eYevlObiepRF6quFm6dSLO5AwGtGd5lCO3YqxSFeTAiNx/kjzuLwK	\N	\N	rousludek@gmail.com	\N	t	cs	\N	\N	anonymousUser	2018-11-14 17:03:22.225	\N	anonymousUser	2018-11-14 17:05:21.651
26651	seli	$2a$10$2q3MxSXcO3YTXusAGfTcceR/dilKUImSBOk5sZYVwVGFgmoAcMS6G	\N	\N	seli@vocas.cz	\N	t	cs	00390075474222906557	\N	anonymousUser	2018-12-10 19:44:25.17	\N	admin	2018-12-10 19:46:34.589
81602	ludarous	$2a$10$6nfWSPPWlDCFSq.VKl4dDeud.UbA0ALPDbUZiIvhdQBSlErySoEI6	\N	\N	ludek-r@volny.cz	\N	t	cz	45564597683970949150	\N	anonymousUser	2019-01-23 08:23:20.54	\N	anonymousUser	2019-01-23 08:23:20.54
82451	ludek	$2a$10$QgabdTjFN8Hciq/5Salhn.EC4aM/ay.3axhpG2tZHPoT1JJyRDgtK	\N	\N	ludek-r@volny.czz	\N	t	cz	15957332014123965526	\N	anonymousUser	2019-01-25 10:32:41.911	\N	anonymousUser	2019-01-25 10:32:41.911
\.


--
-- TOC entry 3036 (class 0 OID 60377)
-- Dependencies: 201
-- Data for Name: jhi_user_authority; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jhi_user_authority (user_id, authority_name) FROM stdin;
1	ROLE_ADMIN
1	ROLE_USER
3	ROLE_ADMIN
3	ROLE_USER
4	ROLE_USER
2351	ROLE_USER
26651	ROLE_USER
81602	ROLE_USER
82451	ROLE_USER
\.


--
-- TOC entry 3041 (class 0 OID 60419)
-- Dependencies: 206
-- Data for Name: jt_test; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jt_test (id, name, description, max_age, min_age) FROM stdin;
82051	Pokusný test	\N	100	0
\.


--
-- TOC entry 3042 (class 0 OID 60427)
-- Dependencies: 207
-- Data for Name: jttest_activities; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jttest_activities (activities_id, jttests_id) FROM stdin;
5251	82051
5283	82051
5284	82051
5255	82051
5258	82051
5263	82051
5264	82051
5265	82051
5267	82051
5268	82051
5271	82051
5273	82051
5274	82051
5275	82051
5278	82051
5279	82051
\.


--
-- TOC entry 3043 (class 0 OID 60432)
-- Dependencies: 208
-- Data for Name: jttest_categories; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jttest_categories (categories_id, jttests_id) FROM stdin;
82001	82051
\.


--
-- TOC entry 3044 (class 0 OID 60437)
-- Dependencies: 209
-- Data for Name: jttest_sports; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.jttest_sports (sports_id, jttests_id) FROM stdin;
\.


--
-- TOC entry 3052 (class 0 OID 60486)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.person (id, personal_data_id, address_id, user_id, email, virtual) FROM stdin;
2901	2851	2801	26651	seli@vocas.cz	f
80502	80452	80402	82451	ludek-r@volny.czz	f
84101	84051	84001	3	admin@localhost	f
2201	2151	2101	2351	rousludek@gmail.com	f
6401	6351	\N	\N	6-0@virtual.virtual	f
6402	6352	\N	\N	6-1@virtual.virtual	f
6403	6353	\N	\N	7-0@virtual.virtual	f
6404	6354	\N	\N	7-1@virtual.virtual	f
6405	6355	\N	\N	8-0@virtual.virtual	f
6406	6356	\N	\N	8-1@virtual.virtual	f
6407	6357	\N	\N	9-0@virtual.virtual	f
6408	6358	\N	\N	9-1@virtual.virtual	f
6409	6359	\N	\N	10-0@virtual.virtual	f
6410	6360	\N	\N	10-1@virtual.virtual	f
6411	6361	\N	\N	11-0@virtual.virtual	f
6412	6362	\N	\N	11-1@virtual.virtual	f
6413	6363	\N	\N	12-0@virtual.virtual	f
6414	6364	\N	\N	12-1@virtual.virtual	f
6415	6365	\N	\N	13-0@virtual.virtual	f
6416	6366	\N	\N	13-1@virtual.virtual	f
6417	6367	\N	\N	14-0@virtual.virtual	f
6418	6368	\N	\N	14-1@virtual.virtual	f
6419	6369	\N	\N	15-0@virtual.virtual	f
6420	6370	\N	\N	15-1@virtual.virtual	f
6421	6371	\N	\N	16-0@virtual.virtual	f
6422	6372	\N	\N	16-1@virtual.virtual	f
6423	6373	\N	\N	17-0@virtual.virtual	f
6424	6374	\N	\N	17-1@virtual.virtual	f
6425	6375	\N	\N	18-0@virtual.virtual	f
6426	6376	\N	\N	18-1@virtual.virtual	f
6427	6377	\N	\N	19-0@virtual.virtual	f
6428	6378	\N	\N	19-1@virtual.virtual	f
6429	6379	\N	\N	20-0@virtual.virtual	f
6430	6380	\N	\N	20-1@virtual.virtual	f
6431	6381	\N	\N	21-0@virtual.virtual	f
6432	6382	\N	\N	21-1@virtual.virtual	f
6433	6383	\N	\N	22-0@virtual.virtual	f
6434	6384	\N	\N	22-1@virtual.virtual	f
6435	6385	\N	\N	23-0@virtual.virtual	f
6436	6386	\N	\N	23-1@virtual.virtual	f
6437	6387	\N	\N	24-0@virtual.virtual	f
6438	6388	\N	\N	24-1@virtual.virtual	f
6439	6389	\N	\N	25-0@virtual.virtual	f
6440	6390	\N	\N	25-1@virtual.virtual	f
6441	6391	\N	\N	26-0@virtual.virtual	f
6442	6392	\N	\N	26-1@virtual.virtual	f
6443	6393	\N	\N	27-0@virtual.virtual	f
6444	6394	\N	\N	27-1@virtual.virtual	f
6445	6395	\N	\N	28-0@virtual.virtual	f
6446	6396	\N	\N	28-1@virtual.virtual	f
6447	6397	\N	\N	29-0@virtual.virtual	f
6448	6398	\N	\N	29-1@virtual.virtual	f
6449	6399	\N	\N	30-0@virtual.virtual	f
6450	6400	\N	\N	30-1@virtual.virtual	f
6501	6451	\N	\N	31-0@virtual.virtual	f
6502	6452	\N	\N	31-1@virtual.virtual	f
6503	6453	\N	\N	32-0@virtual.virtual	f
6504	6454	\N	\N	32-1@virtual.virtual	f
6505	6455	\N	\N	33-0@virtual.virtual	f
6506	6456	\N	\N	33-1@virtual.virtual	f
6507	6457	\N	\N	34-0@virtual.virtual	f
6508	6458	\N	\N	34-1@virtual.virtual	f
6509	6459	\N	\N	35-0@virtual.virtual	f
6510	6460	\N	\N	35-1@virtual.virtual	f
6511	6461	\N	\N	36-0@virtual.virtual	f
6512	6462	\N	\N	36-1@virtual.virtual	f
6513	6463	\N	\N	37-0@virtual.virtual	f
6514	6464	\N	\N	37-1@virtual.virtual	f
6515	6465	\N	\N	38-0@virtual.virtual	f
6516	6466	\N	\N	38-1@virtual.virtual	f
6517	6467	\N	\N	39-0@virtual.virtual	f
6518	6468	\N	\N	39-1@virtual.virtual	f
6519	6469	\N	\N	40-0@virtual.virtual	f
6520	6470	\N	\N	40-1@virtual.virtual	f
6521	6471	\N	\N	41-0@virtual.virtual	f
6522	6472	\N	\N	41-1@virtual.virtual	f
6523	6473	\N	\N	42-0@virtual.virtual	f
6524	6474	\N	\N	42-1@virtual.virtual	f
6525	6475	\N	\N	43-0@virtual.virtual	f
6526	6476	\N	\N	43-1@virtual.virtual	f
6527	6477	\N	\N	44-0@virtual.virtual	f
6528	6478	\N	\N	44-1@virtual.virtual	f
6529	6479	\N	\N	45-0@virtual.virtual	f
6530	6480	\N	\N	45-1@virtual.virtual	f
6531	6481	\N	\N	46-0@virtual.virtual	f
6532	6482	\N	\N	46-1@virtual.virtual	f
6533	6483	\N	\N	47-0@virtual.virtual	f
6534	6484	\N	\N	47-1@virtual.virtual	f
6535	6485	\N	\N	48-0@virtual.virtual	f
6536	6486	\N	\N	48-1@virtual.virtual	f
6537	6487	\N	\N	49-0@virtual.virtual	f
6538	6488	\N	\N	49-1@virtual.virtual	f
81804	81754	81704	\N	ludek-r@volny.cz	f
\.


--
-- TOC entry 3058 (class 0 OID 76858)
-- Dependencies: 223
-- Data for Name: person_group; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.person_group (id, group_role, person_id, group_id) FROM stdin;
83801	ADMIN	2201	83751
\.


--
-- TOC entry 3053 (class 0 OID 60495)
-- Dependencies: 218
-- Data for Name: personal_data; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.personal_data (id, first_name, last_name, birth_date, nationality) FROM stdin;
2851	Jan	Selinger	2018-11-16 14:04:58.205	cz
2151	Luděk	Rous	1985-11-01 00:00:00	cz
6451	31 let	úroveň 0	1987-07-01 14:55:17.838	\N
6452	31 let	úroveň 1	1987-07-01 14:55:17.869	\N
6453	32 let	úroveň 0	1986-07-01 14:55:17.9	\N
6454	32 let	úroveň 1	1986-07-01 14:55:17.934	\N
6455	33 let	úroveň 0	1985-07-01 14:55:17.961	\N
6456	33 let	úroveň 1	1985-07-01 14:55:18.004	\N
6457	34 let	úroveň 0	1984-07-01 14:55:18.037	\N
6458	34 let	úroveň 1	1984-07-01 14:55:18.079	\N
6459	35 let	úroveň 0	1983-07-01 14:55:18.116	\N
6460	35 let	úroveň 1	1983-07-01 14:55:18.149	\N
6461	36 let	úroveň 0	1982-07-01 14:55:18.182	\N
6462	36 let	úroveň 1	1982-07-01 14:55:18.23	\N
6463	37 let	úroveň 0	1981-07-01 14:55:18.269	\N
6464	37 let	úroveň 1	1981-07-01 14:55:18.304	\N
6465	38 let	úroveň 0	1980-07-01 14:55:18.337	\N
6053	6 let	úroveň 2	2012-07-01 00:00:00	\N
6054	6 let	úroveň 3	2012-07-01 00:00:00	\N
6052	6 let	úroveň 1	2012-07-01 00:00:00	\N
6466	38 let	úroveň 1	1980-07-01 14:55:18.367	\N
6467	39 let	úroveň 0	1979-07-01 14:55:18.4	\N
6468	39 let	úroveň 1	1979-07-01 14:55:18.448	\N
6469	40 let	úroveň 0	1978-07-01 14:55:18.498	\N
6051	7 let	úroveň 0	2011-07-01 00:00:00	cz
6201	7 let	úroveň 1	2011-07-01 00:00:00	cz
6202	7 let	úroveň 2	2011-07-01 00:00:00	cz
6203	7 let	úroveň 3	2011-07-01 00:00:00	cz
6204	6 let	úroveň 0	2012-07-01 00:00:00	\N
6205	8 let	úroveň 0	2010-07-01 00:00:00	\N
6206	8 let	úroveň 1	2010-07-01 00:00:00	\N
6207	8 let	úroveň 2	2010-07-01 00:00:00	\N
6470	40 let	úroveň 1	1978-07-01 14:55:18.533	\N
6208	9 let	úroveň 0	2009-07-01 00:00:00	\N
6212	8 let	úroveň 3	2010-07-01 00:00:00	\N
6209	9 let	úroveň 1	2009-07-01 00:00:00	\N
6210	9 let	úroveň 2	2009-07-01 00:00:00	\N
6211	9 let	úroveň 3	2009-07-01 00:00:00	\N
6351	6 let	úroveň 0	2012-07-01 14:55:15.66	\N
6352	6 let	úroveň 1	2012-07-01 14:55:15.813	\N
6353	7 let	úroveň 0	2011-07-01 14:55:15.854	\N
6354	7 let	úroveň 1	2011-07-01 14:55:15.898	\N
6355	8 let	úroveň 0	2010-07-01 14:55:15.934	\N
6356	8 let	úroveň 1	2010-07-01 14:55:16.002	\N
6357	9 let	úroveň 0	2009-07-01 14:55:16.037	\N
6358	9 let	úroveň 1	2009-07-01 14:55:16.09	\N
6359	10 let	úroveň 0	2008-07-01 14:55:16.131	\N
6360	10 let	úroveň 1	2008-07-01 14:55:16.193	\N
6361	11 let	úroveň 0	2007-07-01 14:55:16.24	\N
6362	11 let	úroveň 1	2007-07-01 14:55:16.286	\N
6363	12 let	úroveň 0	2006-07-01 14:55:16.342	\N
6364	12 let	úroveň 1	2006-07-01 14:55:16.392	\N
6365	13 let	úroveň 0	2005-07-01 14:55:16.431	\N
6366	13 let	úroveň 1	2005-07-01 14:55:16.463	\N
6367	14 let	úroveň 0	2004-07-01 14:55:16.496	\N
6368	14 let	úroveň 1	2004-07-01 14:55:16.535	\N
6369	15 let	úroveň 0	2003-07-01 14:55:16.586	\N
6370	15 let	úroveň 1	2003-07-01 14:55:16.632	\N
6371	16 let	úroveň 0	2002-07-01 14:55:16.668	\N
6372	16 let	úroveň 1	2002-07-01 14:55:16.707	\N
6373	17 let	úroveň 0	2001-07-01 14:55:16.752	\N
6374	17 let	úroveň 1	2001-07-01 14:55:16.78	\N
6375	18 let	úroveň 0	2000-07-01 14:55:16.82	\N
6376	18 let	úroveň 1	2000-07-01 14:55:16.879	\N
6377	19 let	úroveň 0	1999-07-01 14:55:16.907	\N
6378	19 let	úroveň 1	1999-07-01 14:55:16.946	\N
6379	20 let	úroveň 0	1998-07-01 14:55:17	\N
6380	20 let	úroveň 1	1998-07-01 14:55:17.044	\N
6381	21 let	úroveň 0	1997-07-01 14:55:17.081	\N
6382	21 let	úroveň 1	1997-07-01 14:55:17.123	\N
6383	22 let	úroveň 0	1996-07-01 14:55:17.158	\N
6384	22 let	úroveň 1	1996-07-01 14:55:17.197	\N
6385	23 let	úroveň 0	1995-07-01 14:55:17.231	\N
6386	23 let	úroveň 1	1995-07-01 14:55:17.259	\N
6387	24 let	úroveň 0	1994-07-01 14:55:17.293	\N
6388	24 let	úroveň 1	1994-07-01 14:55:17.327	\N
6389	25 let	úroveň 0	1993-07-01 14:55:17.366	\N
6390	25 let	úroveň 1	1993-07-01 14:55:17.406	\N
6391	26 let	úroveň 0	1992-07-01 14:55:17.441	\N
6392	26 let	úroveň 1	1992-07-01 14:55:17.503	\N
6393	27 let	úroveň 0	1991-07-01 14:55:17.533	\N
6394	27 let	úroveň 1	1991-07-01 14:55:17.566	\N
6395	28 let	úroveň 0	1990-07-01 14:55:17.607	\N
6396	28 let	úroveň 1	1990-07-01 14:55:17.646	\N
6397	29 let	úroveň 0	1989-07-01 14:55:17.693	\N
6398	29 let	úroveň 1	1989-07-01 14:55:17.723	\N
6399	30 let	úroveň 0	1988-07-01 14:55:17.776	\N
6400	30 let	úroveň 1	1988-07-01 14:55:17.81	\N
6471	41 let	úroveň 0	1977-07-01 14:55:18.569	\N
6472	41 let	úroveň 1	1977-07-01 14:55:18.608	\N
6473	42 let	úroveň 0	1976-07-01 14:55:18.645	\N
6474	42 let	úroveň 1	1976-07-01 14:55:18.686	\N
6475	43 let	úroveň 0	1975-07-01 14:55:18.718	\N
6476	43 let	úroveň 1	1975-07-01 14:55:18.755	\N
6477	44 let	úroveň 0	1974-07-01 14:55:18.792	\N
6478	44 let	úroveň 1	1974-07-01 14:55:18.834	\N
6479	45 let	úroveň 0	1973-07-01 14:55:18.873	\N
6480	45 let	úroveň 1	1973-07-01 14:55:18.908	\N
6481	46 let	úroveň 0	1972-07-01 14:55:18.94	\N
6482	46 let	úroveň 1	1972-07-01 14:55:18.981	\N
6483	47 let	úroveň 0	1971-07-01 14:55:19.031	\N
6484	47 let	úroveň 1	1971-07-01 14:55:19.074	\N
6485	48 let	úroveň 0	1970-07-01 14:55:19.109	\N
6486	48 let	úroveň 1	1970-07-01 14:55:19.143	\N
6487	49 let	úroveň 0	1969-07-01 14:55:19.174	\N
6488	49 let	úroveň 1	1969-07-01 14:55:19.205	\N
84051	Admin	Admin	2019-01-10 00:00:00	cz
81754	Luděk	Rous	1985-11-01 00:00:00	cz
80452	Luděk	Rouss	1985-11-01 00:00:00	cz
\.


--
-- TOC entry 3055 (class 0 OID 60511)
-- Dependencies: 220
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.sport (id, name) FROM stdin;
\.


--
-- TOC entry 3047 (class 0 OID 60455)
-- Dependencies: 212
-- Data for Name: test_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.test_category (id, name, jhi_key, description) FROM stdin;
82001	Pokus kategorie testu	\N	Popis pokusné kategorie testu
\.


--
-- TOC entry 3050 (class 0 OID 60476)
-- Dependencies: 215
-- Data for Name: test_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY public.test_result (id, note, event_result_id, test_id) FROM stdin;
82635	Poznámka k testu Pokusný test. Osooba: Luděk Rouss	82585	82051
82636	Poznámka k testu Pokusný test. Osooba: 6 let úroveň 0	82586	82051
82637	Poznámka k testu Pokusný test. Osooba: 7 let úroveň 0	82587	82051
82638	Poznámka k testu Pokusný test. Osooba: Jan Selinger	82588	82051
82639	Poznámka k testu Pokusný test. Osooba: 8 let úroveň 0	82589	82051
82640	Poznámka k testu Pokusný test. Osooba: Luděk Rouss	82590	82051
82641	Poznámka k testu Pokusný test. Osooba: 6 let úroveň 0	82591	82051
82642	Poznámka k testu Pokusný test. Osooba: 7 let úroveň 0	82592	82051
82626	Poznámka k testu Pokusný test. Osooba: 6 let úroveň 0	82576	82051
82627	Poznámka k testu Pokusný test. Osooba: 7 let úroveň 0	82577	82051
82628	Poznámka k testu Pokusný test. Osooba: Jan Selinger	82578	82051
82629	Poznámka k testu Pokusný test. Osooba: 8 let úroveň 0	82579	82051
82630	Poznámka k testu Pokusný test. Osooba: Luděk Rouss	82580	82051
82631	Poznámka k testu Pokusný test. Osooba: 6 let úroveň 0	82581	82051
82632	Poznámka k testu Pokusný test. Osooba: 7 let úroveň 0	82582	82051
82633	Poznámka k testu Pokusný test. Osooba: Jan Selinger	82583	82051
82634	Poznámka k testu Pokusný test. Osooba: 8 let úroveň 0	82584	82051
82643	Poznámka k testu Pokusný test. Osooba: Jan Selinger	82593	82051
82644	Poznámka k testu Pokusný test. Osooba: 8 let úroveň 0	82594	82051
82645	Poznámka k testu Pokusný test. Osooba: Luděk Rouss	82595	82051
82646	Poznámka k testu Pokusný test. Osooba: 6 let úroveň 0	82596	82051
82647	Poznámka k testu Pokusný test. Osooba: 7 let úroveň 0	82597	82051
82648	Poznámka k testu Pokusný test. Osooba: Jan Selinger	82598	82051
82649	Poznámka k testu Pokusný test. Osooba: 8 let úroveň 0	82599	82051
82650	Poznámka k testu Pokusný test. Osooba: Luděk Rouss	82600	82051
\.


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 198
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: jt-testing
--

SELECT pg_catalog.setval('public.hibernate_sequence', 84300, true);


--
-- TOC entry 2834 (class 2606 OID 60454)
-- Name: activity_categories activity_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_categories
    ADD CONSTRAINT activity_categories_pkey PRIMARY KEY (activities_id, categories_id);


--
-- TOC entry 2871 (class 2606 OID 76914)
-- Name: activity_group_activities activity_group_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activities
    ADD CONSTRAINT activity_group_activities_pkey PRIMARY KEY (activity_groups_id, activities_id);


--
-- TOC entry 2873 (class 2606 OID 76919)
-- Name: activity_group_activity_group_categories activity_group_activity_group_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activity_group_categories
    ADD CONSTRAINT activity_group_activity_group_categories_pkey PRIMARY KEY (activity_groups_id, activity_group_categories_id);


--
-- TOC entry 2861 (class 2606 OID 60624)
-- Name: event_attached_persons event_attached_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_attached_persons
    ADD CONSTRAINT event_attached_persons_pkey PRIMARY KEY (events_id, attached_persons_id);


--
-- TOC entry 2822 (class 2606 OID 60418)
-- Name: event_tests event_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_tests
    ADD CONSTRAINT event_tests_pkey PRIMARY KEY (events_id, tests_id);


--
-- TOC entry 2818 (class 2606 OID 60401)
-- Name: jhi_persistent_audit_evt_data jhi_persistent_audit_evt_data_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_persistent_audit_evt_data
    ADD CONSTRAINT jhi_persistent_audit_evt_data_pkey PRIMARY KEY (event_id, name);


--
-- TOC entry 2812 (class 2606 OID 60381)
-- Name: jhi_user_authority jhi_user_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user_authority
    ADD CONSTRAINT jhi_user_authority_pkey PRIMARY KEY (user_id, authority_name);


--
-- TOC entry 2826 (class 2606 OID 60431)
-- Name: jttest_activities jttest_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_activities
    ADD CONSTRAINT jttest_activities_pkey PRIMARY KEY (jttests_id, activities_id);


--
-- TOC entry 2828 (class 2606 OID 60436)
-- Name: jttest_categories jttest_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_categories
    ADD CONSTRAINT jttest_categories_pkey PRIMARY KEY (jttests_id, categories_id);


--
-- TOC entry 2830 (class 2606 OID 60441)
-- Name: jttest_sports jttest_sports_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_sports
    ADD CONSTRAINT jttest_sports_pkey PRIMARY KEY (jttests_id, sports_id);


--
-- TOC entry 2847 (class 2606 OID 60494)
-- Name: person person_address_id_key; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_address_id_key UNIQUE (address_id);


--
-- TOC entry 2849 (class 2606 OID 60492)
-- Name: person person_personal_data_id_key; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_personal_data_id_key UNIQUE (personal_data_id);


--
-- TOC entry 2832 (class 2606 OID 60449)
-- Name: activity pk_activity; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id);


--
-- TOC entry 2838 (class 2606 OID 60470)
-- Name: activity_category pk_activity_category; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_category
    ADD CONSTRAINT pk_activity_category PRIMARY KEY (id);


--
-- TOC entry 2869 (class 2606 OID 76909)
-- Name: activity_group pk_activity_group; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group
    ADD CONSTRAINT pk_activity_group PRIMARY KEY (id);


--
-- TOC entry 2867 (class 2606 OID 76901)
-- Name: activity_group_category pk_activity_group_category; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_category
    ADD CONSTRAINT pk_activity_group_category PRIMARY KEY (id);


--
-- TOC entry 2845 (class 2606 OID 60485)
-- Name: activity_result pk_activity_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT pk_activity_result PRIMARY KEY (id);


--
-- TOC entry 2857 (class 2606 OID 60510)
-- Name: address pk_address; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT pk_address PRIMARY KEY (id);


--
-- TOC entry 2802 (class 2606 OID 60350)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 2820 (class 2606 OID 60413)
-- Name: event pk_event; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT pk_event PRIMARY KEY (id);


--
-- TOC entry 2840 (class 2606 OID 60475)
-- Name: event_result pk_event_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT pk_event_result PRIMARY KEY (id);


--
-- TOC entry 2810 (class 2606 OID 60376)
-- Name: jhi_authority pk_jhi_authority; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_authority
    ADD CONSTRAINT pk_jhi_authority PRIMARY KEY (name);


--
-- TOC entry 2863 (class 2606 OID 76852)
-- Name: jhi_group pk_jhi_group; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_group
    ADD CONSTRAINT pk_jhi_group PRIMARY KEY (id);


--
-- TOC entry 2815 (class 2606 OID 60396)
-- Name: jhi_persistent_audit_event pk_jhi_persistent_audit_event; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_persistent_audit_event
    ADD CONSTRAINT pk_jhi_persistent_audit_event PRIMARY KEY (event_id);


--
-- TOC entry 2804 (class 2606 OID 60367)
-- Name: jhi_user pk_jhi_user; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user
    ADD CONSTRAINT pk_jhi_user PRIMARY KEY (id);


--
-- TOC entry 2824 (class 2606 OID 60426)
-- Name: jt_test pk_jt_test; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jt_test
    ADD CONSTRAINT pk_jt_test PRIMARY KEY (id);


--
-- TOC entry 2851 (class 2606 OID 60490)
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT pk_person PRIMARY KEY (id);


--
-- TOC entry 2865 (class 2606 OID 76862)
-- Name: person_group pk_person_group; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person_group
    ADD CONSTRAINT pk_person_group PRIMARY KEY (id);


--
-- TOC entry 2855 (class 2606 OID 60502)
-- Name: personal_data pk_personal_data; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.personal_data
    ADD CONSTRAINT pk_personal_data PRIMARY KEY (id);


--
-- TOC entry 2859 (class 2606 OID 60515)
-- Name: sport pk_sport; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT pk_sport PRIMARY KEY (id);


--
-- TOC entry 2836 (class 2606 OID 60462)
-- Name: test_category pk_test_category; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.test_category
    ADD CONSTRAINT pk_test_category PRIMARY KEY (id);


--
-- TOC entry 2842 (class 2606 OID 60480)
-- Name: test_result pk_test_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT pk_test_result PRIMARY KEY (id);


--
-- TOC entry 2853 (class 2606 OID 60613)
-- Name: person uc_personuser_id_col; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT uc_personuser_id_col UNIQUE (user_id);


--
-- TOC entry 2806 (class 2606 OID 60369)
-- Name: jhi_user ux_user_email; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user
    ADD CONSTRAINT ux_user_email UNIQUE (email);


--
-- TOC entry 2808 (class 2606 OID 60371)
-- Name: jhi_user ux_user_login; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user
    ADD CONSTRAINT ux_user_login UNIQUE (login);


--
-- TOC entry 2843 (class 1259 OID 76883)
-- Name: filter_index; Type: INDEX; Schema: public; Owner: jt-testing
--

CREATE INDEX filter_index ON public.activity_result USING btree (event_date, person_birth_date, activity_id, test_id, event_id, person_id);


--
-- TOC entry 2813 (class 1259 OID 60402)
-- Name: idx_persistent_audit_event; Type: INDEX; Schema: public; Owner: jt-testing
--

CREATE INDEX idx_persistent_audit_event ON public.jhi_persistent_audit_event USING btree (principal, event_date);


--
-- TOC entry 2816 (class 1259 OID 60403)
-- Name: idx_persistent_audit_evt_data; Type: INDEX; Schema: public; Owner: jt-testing
--

CREATE INDEX idx_persistent_audit_evt_data ON public.jhi_persistent_audit_evt_data USING btree (event_id);


--
-- TOC entry 2886 (class 2606 OID 76884)
-- Name: activity FK5uiqyj0efmyxdb0w52b184iai; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT "FK5uiqyj0efmyxdb0w52b184iai" FOREIGN KEY (author_id) REFERENCES public.person(id);


--
-- TOC entry 2897 (class 2606 OID 75354)
-- Name: activity_result FKbvddel0kqefqb2cbfyk5b8h1a; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT "FKbvddel0kqefqb2cbfyk5b8h1a" FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 2903 (class 2606 OID 60625)
-- Name: event_attached_persons FKcc1cq3mo95k6xp5duh287cfsv; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_attached_persons
    ADD CONSTRAINT "FKcc1cq3mo95k6xp5duh287cfsv" FOREIGN KEY (attached_persons_id) REFERENCES public.person(id);


--
-- TOC entry 2902 (class 2606 OID 60614)
-- Name: person FKe9y2rjb98wsg2nnk3eyrvc2ss; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT "FKe9y2rjb98wsg2nnk3eyrvc2ss" FOREIGN KEY (user_id) REFERENCES public.jhi_user(id);


--
-- TOC entry 2887 (class 2606 OID 76889)
-- Name: activity FKi38klfuakye3farjp75qw5jsl; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity
    ADD CONSTRAINT "FKi38klfuakye3farjp75qw5jsl" FOREIGN KEY (group_id) REFERENCES public.jhi_group(id);


--
-- TOC entry 2898 (class 2606 OID 75359)
-- Name: activity_result FKipbqegmh7qoia8ah6tgoene1s; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT "FKipbqegmh7qoia8ah6tgoene1s" FOREIGN KEY (test_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2890 (class 2606 OID 62476)
-- Name: activity_category FKnxdhln28xokjbv8cwfj372fny; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_category
    ADD CONSTRAINT "FKnxdhln28xokjbv8cwfj372fny" FOREIGN KEY (parent_id) REFERENCES public.activity_category(id);


--
-- TOC entry 2899 (class 2606 OID 75364)
-- Name: activity_result FKopx45p3m6dw4ixv94dpyxvuea; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT "FKopx45p3m6dw4ixv94dpyxvuea" FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- TOC entry 2904 (class 2606 OID 60630)
-- Name: event_attached_persons FKtlu2ktd0nahrhonnjrbjjrkwe; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_attached_persons
    ADD CONSTRAINT "FKtlu2ktd0nahrhonnjrbjjrkwe" FOREIGN KEY (events_id) REFERENCES public.event(id);


--
-- TOC entry 2888 (class 2606 OID 60561)
-- Name: activity_categories fk_activity_categories_activities_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_categories
    ADD CONSTRAINT fk_activity_categories_activities_id FOREIGN KEY (activities_id) REFERENCES public.activity(id);


--
-- TOC entry 2889 (class 2606 OID 60566)
-- Name: activity_categories fk_activity_categories_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_categories
    ADD CONSTRAINT fk_activity_categories_categories_id FOREIGN KEY (categories_id) REFERENCES public.activity_category(id);


--
-- TOC entry 2907 (class 2606 OID 76925)
-- Name: activity_group_activities fk_activity_group_activities_activities_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activities
    ADD CONSTRAINT fk_activity_group_activities_activities_id FOREIGN KEY (activities_id) REFERENCES public.activity(id);


--
-- TOC entry 2906 (class 2606 OID 76920)
-- Name: activity_group_activities fk_activity_group_activities_activity_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activities
    ADD CONSTRAINT fk_activity_group_activities_activity_groups_id FOREIGN KEY (activity_groups_id) REFERENCES public.activity_group(id);


--
-- TOC entry 2909 (class 2606 OID 76935)
-- Name: activity_group_activity_group_categories fk_activity_group_activity_group_categories_activity_group_cate; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activity_group_categories
    ADD CONSTRAINT fk_activity_group_activity_group_categories_activity_group_cate FOREIGN KEY (activity_group_categories_id) REFERENCES public.activity_group_category(id);


--
-- TOC entry 2908 (class 2606 OID 76930)
-- Name: activity_group_activity_group_categories fk_activity_group_activity_group_categories_activity_groups_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_group_activity_group_categories
    ADD CONSTRAINT fk_activity_group_activity_group_categories_activity_groups_id FOREIGN KEY (activity_groups_id) REFERENCES public.activity_group(id);


--
-- TOC entry 2896 (class 2606 OID 60596)
-- Name: activity_result fk_activity_result_activity_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT fk_activity_result_activity_id FOREIGN KEY (activity_id) REFERENCES public.activity(id);


--
-- TOC entry 2895 (class 2606 OID 60591)
-- Name: activity_result fk_activity_result_test_result_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.activity_result
    ADD CONSTRAINT fk_activity_result_test_result_id FOREIGN KEY (test_result_id) REFERENCES public.test_result(id);


--
-- TOC entry 2874 (class 2606 OID 60382)
-- Name: jhi_user_authority fk_authority_name; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user_authority
    ADD CONSTRAINT fk_authority_name FOREIGN KEY (authority_name) REFERENCES public.jhi_authority(name);


--
-- TOC entry 2877 (class 2606 OID 60516)
-- Name: event fk_event_address_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_event_address_id FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- TOC entry 2891 (class 2606 OID 60571)
-- Name: event_result fk_event_result_event_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT fk_event_result_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- TOC entry 2892 (class 2606 OID 60576)
-- Name: event_result fk_event_result_person_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_result
    ADD CONSTRAINT fk_event_result_person_id FOREIGN KEY (person_id) REFERENCES public.person(id);


--
-- TOC entry 2878 (class 2606 OID 60521)
-- Name: event_tests fk_event_tests_events_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_tests
    ADD CONSTRAINT fk_event_tests_events_id FOREIGN KEY (events_id) REFERENCES public.event(id);


--
-- TOC entry 2879 (class 2606 OID 60526)
-- Name: event_tests fk_event_tests_tests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.event_tests
    ADD CONSTRAINT fk_event_tests_tests_id FOREIGN KEY (tests_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2876 (class 2606 OID 60404)
-- Name: jhi_persistent_audit_evt_data fk_evt_pers_audit_evt_data; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_persistent_audit_evt_data
    ADD CONSTRAINT fk_evt_pers_audit_evt_data FOREIGN KEY (event_id) REFERENCES public.jhi_persistent_audit_event(event_id);


--
-- TOC entry 2905 (class 2606 OID 76853)
-- Name: jhi_group fk_group_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_group
    ADD CONSTRAINT fk_group_parent_id FOREIGN KEY (parent_id) REFERENCES public.jhi_group(id);


--
-- TOC entry 2881 (class 2606 OID 60536)
-- Name: jttest_activities fk_jttest_activities_activities_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_activities
    ADD CONSTRAINT fk_jttest_activities_activities_id FOREIGN KEY (activities_id) REFERENCES public.activity(id);


--
-- TOC entry 2880 (class 2606 OID 60531)
-- Name: jttest_activities fk_jttest_activities_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_activities
    ADD CONSTRAINT fk_jttest_activities_jttests_id FOREIGN KEY (jttests_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2883 (class 2606 OID 60546)
-- Name: jttest_categories fk_jttest_categories_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_categories
    ADD CONSTRAINT fk_jttest_categories_categories_id FOREIGN KEY (categories_id) REFERENCES public.test_category(id);


--
-- TOC entry 2882 (class 2606 OID 60541)
-- Name: jttest_categories fk_jttest_categories_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_categories
    ADD CONSTRAINT fk_jttest_categories_jttests_id FOREIGN KEY (jttests_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2884 (class 2606 OID 60551)
-- Name: jttest_sports fk_jttest_sports_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_sports
    ADD CONSTRAINT fk_jttest_sports_jttests_id FOREIGN KEY (jttests_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2885 (class 2606 OID 60556)
-- Name: jttest_sports fk_jttest_sports_sports_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jttest_sports
    ADD CONSTRAINT fk_jttest_sports_sports_id FOREIGN KEY (sports_id) REFERENCES public.sport(id);


--
-- TOC entry 2901 (class 2606 OID 60606)
-- Name: person fk_person_address_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fk_person_address_id FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- TOC entry 2900 (class 2606 OID 60601)
-- Name: person fk_person_personal_data_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT fk_person_personal_data_id FOREIGN KEY (personal_data_id) REFERENCES public.personal_data(id);


--
-- TOC entry 2893 (class 2606 OID 60581)
-- Name: test_result fk_test_result_event_result_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT fk_test_result_event_result_id FOREIGN KEY (event_result_id) REFERENCES public.event_result(id);


--
-- TOC entry 2894 (class 2606 OID 60586)
-- Name: test_result fk_test_result_test_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT fk_test_result_test_id FOREIGN KEY (test_id) REFERENCES public.jt_test(id);


--
-- TOC entry 2875 (class 2606 OID 60387)
-- Name: jhi_user_authority fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY public.jhi_user_authority
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.jhi_user(id);


-- Completed on 2019-01-29 07:29:16

--
-- PostgreSQL database dump complete
--

