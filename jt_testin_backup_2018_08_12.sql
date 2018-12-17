--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.1

-- Started on 2018-12-08 23:20:13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 210 (class 1259 OID 60442)
-- Name: activity; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE activity (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    help character varying(255),
    jhi_key character varying(255),
    primary_result_value_unit character varying(255) NOT NULL,
    secondary_result_value_unit character varying(255),
    min_age integer,
    max_age integer
);


ALTER TABLE activity OWNER TO "jt-testing";

--
-- TOC entry 211 (class 1259 OID 60450)
-- Name: activity_categories; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE activity_categories (
    categories_id bigint NOT NULL,
    activities_id bigint NOT NULL
);


ALTER TABLE activity_categories OWNER TO "jt-testing";

--
-- TOC entry 213 (class 1259 OID 60463)
-- Name: activity_category; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE activity_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_key character varying(255),
    description character varying(255),
    parent_id bigint
);


ALTER TABLE activity_category OWNER TO "jt-testing";

--
-- TOC entry 216 (class 1259 OID 60481)
-- Name: activity_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE activity_result (
    id bigint NOT NULL,
    primary_result_value real,
    secondary_result_value real,
    note character varying(255),
    test_result_id bigint,
    activity_id bigint NOT NULL
);


ALTER TABLE activity_result OWNER TO "jt-testing";

--
-- TOC entry 219 (class 1259 OID 60503)
-- Name: address; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE address (
    id bigint NOT NULL,
    country character varying(255),
    city character varying(255),
    street character varying(255),
    zip_code character varying(255)
);


ALTER TABLE address OWNER TO "jt-testing";

--
-- TOC entry 197 (class 1259 OID 60351)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE databasechangelog (
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


ALTER TABLE databasechangelog OWNER TO "jt-testing";

--
-- TOC entry 196 (class 1259 OID 60346)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO "jt-testing";

--
-- TOC entry 204 (class 1259 OID 60409)
-- Name: event; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE event (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_date timestamp without time zone,
    address_id bigint,
    max_age integer,
    min_age integer
);


ALTER TABLE event OWNER TO "jt-testing";

--
-- TOC entry 221 (class 1259 OID 60620)
-- Name: event_attached_persons; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE event_attached_persons (
    events_id bigint NOT NULL,
    attached_persons_id bigint NOT NULL
);


ALTER TABLE event_attached_persons OWNER TO "jt-testing";

--
-- TOC entry 214 (class 1259 OID 60471)
-- Name: event_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE event_result (
    id bigint NOT NULL,
    note character varying(255),
    actual_height_in_cm real,
    actual_weight_in_kg real,
    event_id bigint,
    person_id bigint NOT NULL
);


ALTER TABLE event_result OWNER TO "jt-testing";

--
-- TOC entry 205 (class 1259 OID 60414)
-- Name: event_tests; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE event_tests (
    tests_id bigint NOT NULL,
    events_id bigint NOT NULL
);


ALTER TABLE event_tests OWNER TO "jt-testing";

--
-- TOC entry 198 (class 1259 OID 60357)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: jt-testing
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1000
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO "jt-testing";

--
-- TOC entry 200 (class 1259 OID 60372)
-- Name: jhi_authority; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jhi_authority (
    name character varying(50) NOT NULL
);


ALTER TABLE jhi_authority OWNER TO "jt-testing";

--
-- TOC entry 202 (class 1259 OID 60392)
-- Name: jhi_persistent_audit_event; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jhi_persistent_audit_event (
    event_id bigint NOT NULL,
    principal character varying(50) NOT NULL,
    event_date timestamp without time zone,
    event_type character varying(255)
);


ALTER TABLE jhi_persistent_audit_event OWNER TO "jt-testing";

--
-- TOC entry 203 (class 1259 OID 60397)
-- Name: jhi_persistent_audit_evt_data; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jhi_persistent_audit_evt_data (
    event_id bigint NOT NULL,
    name character varying(150) NOT NULL,
    value character varying(255)
);


ALTER TABLE jhi_persistent_audit_evt_data OWNER TO "jt-testing";

--
-- TOC entry 199 (class 1259 OID 60359)
-- Name: jhi_user; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jhi_user (
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


ALTER TABLE jhi_user OWNER TO "jt-testing";

--
-- TOC entry 201 (class 1259 OID 60377)
-- Name: jhi_user_authority; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jhi_user_authority (
    user_id bigint NOT NULL,
    authority_name character varying(50) NOT NULL
);


ALTER TABLE jhi_user_authority OWNER TO "jt-testing";

--
-- TOC entry 206 (class 1259 OID 60419)
-- Name: jt_test; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jt_test (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    max_age integer,
    min_age integer
);


ALTER TABLE jt_test OWNER TO "jt-testing";

--
-- TOC entry 207 (class 1259 OID 60427)
-- Name: jttest_activities; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jttest_activities (
    activities_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE jttest_activities OWNER TO "jt-testing";

--
-- TOC entry 208 (class 1259 OID 60432)
-- Name: jttest_categories; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jttest_categories (
    categories_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE jttest_categories OWNER TO "jt-testing";

--
-- TOC entry 209 (class 1259 OID 60437)
-- Name: jttest_sports; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE jttest_sports (
    sports_id bigint NOT NULL,
    jttests_id bigint NOT NULL
);


ALTER TABLE jttest_sports OWNER TO "jt-testing";

--
-- TOC entry 217 (class 1259 OID 60486)
-- Name: person; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE person (
    id bigint NOT NULL,
    personal_data_id bigint,
    address_id bigint,
    user_id bigint,
    email character varying(255) NOT NULL,
    virtual boolean
);


ALTER TABLE person OWNER TO "jt-testing";

--
-- TOC entry 218 (class 1259 OID 60495)
-- Name: personal_data; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE personal_data (
    id bigint NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    birth_date timestamp without time zone NOT NULL,
    nationality character varying(255)
);


ALTER TABLE personal_data OWNER TO "jt-testing";

--
-- TOC entry 220 (class 1259 OID 60511)
-- Name: sport; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE sport (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE sport OWNER TO "jt-testing";

--
-- TOC entry 212 (class 1259 OID 60455)
-- Name: test_category; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE test_category (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    jhi_key character varying(255),
    description character varying(255)
);


ALTER TABLE test_category OWNER TO "jt-testing";

--
-- TOC entry 215 (class 1259 OID 60476)
-- Name: test_result; Type: TABLE; Schema: public; Owner: jt-testing
--

CREATE TABLE test_result (
    id bigint NOT NULL,
    note character varying(255),
    event_result_id bigint,
    test_id bigint NOT NULL
);


ALTER TABLE test_result OWNER TO "jt-testing";

--
-- TOC entry 2995 (class 0 OID 60442)
-- Dependencies: 210
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity (id, name, description, help, jhi_key, primary_result_value_unit, secondary_result_value_unit, min_age, max_age) FROM stdin;
5251	Jít na povel a pak zpět	\N	\N	\N	POINTS	SECONDS	\N	\N
5253	Stoj na jedné noze	\N	\N	\N	SECONDS	POINTS	\N	\N
5252	Zavázání boty	\N	\N	\N	POINTS	SECONDS	\N	\N
5254	Skok na jednu nohu	Cvičenec skočí ze stoje na jednu nohu a snaží se co nejdéle vydržet, aniž by se druhou nohou dotkl země	\N	\N	SECONDS	POINTS	\N	\N
5256	Letmý start	\N	\N	\N	SECONDS	POINTS	\N	\N
5255	Běh 5 metrů	\N	\N	\N	SECONDS	\N	\N	\N
5257	Překážková dráha	\N	\N	\N	SECONDS	POINTS	\N	\N
5258	Házet tenisákem a kopat do míče	\N	\N	\N	COUNTS	SECONDS	\N	\N
5259	Nožičky	\N	\N	\N	COUNTS	SECONDS	\N	\N
5260	Tři míče a vybere a zakončí	\N	\N	\N	SECONDS	GOALS	\N	\N
5261	Lowa brace test	\N	\N	\N	SECONDS	COUNTS	\N	\N
5262	Žebřík	\N	\N	\N	SECONDS	COUNTS	\N	\N
5263	Švihadlo - levá, pravá, obě	\N	\N	\N	SECONDS	COUNTS	\N	\N
5264	Hod míčem 2ks	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5265	Skok daleký	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5266	Kliky	\N	\N	\N	COUNTS	SECONDS	\N	\N
5267	Skok vysoký	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5268	běh 50 metrů	\N	\N	\N	SECONDS	POINTS	\N	\N
5269	slalom	\N	\N	\N	SECONDS	\N	\N	\N
5270	Člunkový běh	\N	\N	\N	SECONDS	POINTS	\N	\N
5271	Běh 1000 metrů	\N	\N	\N	SECONDS	MINUTES	\N	\N
5272	Předklon	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5273	Úklon	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5274	Hod pytlíkem do díry - San Simeon	\N	\N	\N	COUNTS	PERCENTS	\N	\N
5275	Výdrž ve sporu	\N	\N	\N	SECONDS	POINTS	\N	\N
5276	Slalom s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N
5277	Běh 50 metrů s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N
5278	Člunkový běh s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N
5279	Žebřík s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N
5280	Výskok s míčem	\N	\N	\N	CENTIMETERS	POINTS	\N	\N
5281	Basketbal - střelba z místa	\N	\N	\N	SECONDS	POINTS	\N	\N
5282	Basketbal - střelba z pohybu	\N	\N	\N	SECONDS	POINTS	\N	\N
5283	Basketbal - střelba z různých přihrávek	\N	\N	\N	SECONDS	POINTS	\N	\N
5351	Basketbal - střelba zleva	\N	\N	\N	POINTS	SECONDS	\N	\N
5284	Basketbal - střelba zprava	\N	\N	\N	POINTS	SECONDS	\N	\N
5352	Basketbal - střelba po otočce 360°	\N	\N	\N	POINTS	SECONDS	\N	\N
5353	Basketbal - střelba slabší rukou	\N	\N	\N	POINTS	SECONDS	\N	\N
5354	Basketbal - sebrat míč ze země a vystřelit	\N	\N	\N	SECONDS	POINTS	\N	\N
5355	Basketbal - driblink levou - lajny	\N	\N	\N	SECONDS	POINTS	\N	\N
5356	Basketbal - driblink pravou - lajny	\N	\N	\N	SECONDS	COUNTS	\N	\N
5357	Basketbal - slalom s míčem	\N	\N	\N	SECONDS	POINTS	\N	\N
5358	Basketbal - slalom s míčem a kopaní do teisového	\N	\N	\N	SECONDS	POINTS	\N	\N
5359	Basketbal - 50m s míčem	\N	\N	\N	SECONDS	\N	\N	\N
5360	Basketbal - 50m s míčem slabší rukou	\N	\N	\N	SECONDS	\N	\N	\N
5361	Basketbal - přihrávka z místa	\N	\N	\N	POINTS	\N	\N	\N
5362	Basketbal - přihrávka v pohybu	\N	\N	\N	POINTS	\N	\N	\N
5363	Basketbal - 5 kroků vpřed + střelba	\N	\N	\N	SECONDS	POINTS	\N	\N
5364	Basketbal - 5 kroků vpřed poslepu + střelba	\N	\N	\N	SECONDS	POINTS	\N	\N
5365	Basketbal - modifikovaný eurostep	\N	\N	\N	POINTS	\N	\N	\N
5366	Basketbal - dvoutakt se dvěma míči	\N	\N	\N	POINTS	\N	\N	\N
5367	Basketbal - střelba s obráncem	\N	\N	\N	POINTS	\N	\N	\N
5368	Basketbal - střelba bez obránce	\N	\N	\N	POINTS	\N	\N	\N
5369	Basketbal - proběhnout kužely	\N	\N	\N	SECONDS	\N	\N	\N
6701	Dřepy	\N	\N	\N	COUNTS	SECONDS	\N	\N
\.


--
-- TOC entry 2996 (class 0 OID 60450)
-- Dependencies: 211
-- Data for Name: activity_categories; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity_categories (categories_id, activities_id) FROM stdin;
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
\.


--
-- TOC entry 2998 (class 0 OID 60463)
-- Dependencies: 213
-- Data for Name: activity_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity_category (id, name, jhi_key, description, parent_id) FROM stdin;
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
\.


--
-- TOC entry 3001 (class 0 OID 60481)
-- Dependencies: 216
-- Data for Name: activity_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity_result (id, primary_result_value, secondary_result_value, note, test_result_id, activity_id) FROM stdin;
9601	39	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	9551	5274
9602	81	45	Poznámka k aktivitě Letmý start. Osooba: Jan Selinger	9551	5256
9603	63	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: Jan Selinger	9551	5253
9604	75	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: Jan Selinger	9551	5254
9605	68	46	Poznámka k aktivitě Překážková dráha. Osooba: Jan Selinger	9551	5257
9606	65	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	9551	5258
9607	20	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	9551	5275
9608	28	36	Poznámka k aktivitě Slalom s míčem. Osooba: Jan Selinger	9551	5276
9609	50	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Jan Selinger	9551	5277
9610	45	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Jan Selinger	9551	5260
9611	21	30	Poznámka k aktivitě Lowa brace test. Osooba: Jan Selinger	9551	5261
9612	55	37	Poznámka k aktivitě Žebřík. Osooba: Jan Selinger	9551	5262
9613	72	33	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	9551	5265
9614	57	\N	Poznámka k aktivitě slalom. Osooba: Jan Selinger	9551	5269
9615	81	40	Poznámka k aktivitě Žebřík. Osooba: Luděk Rous	9552	5262
9616	97	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: Luděk Rous	9552	5253
9617	39	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: Luděk Rous	9552	5254
9618	27	47	Poznámka k aktivitě Letmý start. Osooba: Luděk Rous	9552	5256
9619	65	41	Poznámka k aktivitě Překážková dráha. Osooba: Luděk Rous	9552	5257
9620	21	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rous	9552	5258
9621	35	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Luděk Rous	9552	5277
9622	20	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Luděk Rous	9552	5260
9623	69	45	Poznámka k aktivitě Slalom s míčem. Osooba: Luděk Rous	9552	5276
9624	95	45	Poznámka k aktivitě Lowa brace test. Osooba: Luděk Rous	9552	5261
9625	100	35	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rous	9552	5265
9626	46	\N	Poznámka k aktivitě slalom. Osooba: Luděk Rous	9552	5269
9627	63	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rous	9552	5274
9628	73	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rous	9552	5275
9629	58	47	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 0	9553	5256
9630	31	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 0	9553	5253
9631	66	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 0	9553	5254
9632	55	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	9553	5275
9633	23	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 0	9553	5277
9634	60	31	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 0	9553	5257
9635	72	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	9553	5258
9636	61	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 0	9553	5260
9637	80	38	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 0	9553	5276
9638	48	38	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 0	9553	5261
9639	43	39	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 0	9553	5262
9640	44	30	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	9553	5265
9641	56	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 0	9553	5269
9642	68	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	9553	5274
9643	88	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 1	9554	5260
9644	88	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 1	9554	5253
9645	82	31	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 1	9554	5276
9646	81	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 1	9554	5254
9647	83	34	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 1	9554	5256
9648	61	42	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 1	9554	5257
9649	86	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 1	9554	5258
9650	68	30	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 1	9554	5261
9651	24	32	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 1	9554	5262
9652	36	41	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 1	9554	5265
9653	84	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 1	9554	5269
9654	47	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 1	9554	5277
9655	97	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 1	9554	5274
9656	80	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 1	9554	5275
9657	41	31	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 0	9555	5262
9658	89	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 0	9555	5253
9659	57	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 0	9555	5254
9660	64	32	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 0	9555	5256
9661	95	39	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 0	9555	5257
9662	98	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	9555	5258
9663	22	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 0	9555	5260
9664	67	43	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 0	9555	5261
9665	48	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	9555	5275
9666	73	33	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	9555	5265
9667	52	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 0	9555	5277
9668	44	39	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 0	9555	5276
9669	90	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 0	9555	5269
9670	36	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	9555	5274
9671	22	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 1	9556	5258
9672	65	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 1	9556	5253
9673	54	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 1	9556	5254
9674	64	44	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 1	9556	5256
9675	77	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 1	9556	5277
9676	29	48	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 1	9556	5257
9677	24	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 1	9556	5260
9678	27	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 1	9556	5275
9679	48	46	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 1	9556	5261
9680	20	47	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 1	9556	5262
9681	51	42	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 1	9556	5265
9682	98	48	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 1	9556	5276
9683	52	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 1	9556	5269
9684	53	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 1	9556	5274
9685	21	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 0	9557	5253
9686	64	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 0	9557	5254
9687	100	34	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 0	9557	5256
9688	92	48	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 0	9557	5257
9689	80	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	9557	5258
9690	32	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	9557	5275
9691	94	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 0	9557	5277
9692	60	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 0	9557	5260
9693	78	32	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 0	9557	5261
9694	72	34	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 0	9557	5262
9695	79	31	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	9557	5265
9696	95	49	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 0	9557	5276
9697	97	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 0	9557	5269
9698	45	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	9557	5274
9699	77	30	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 1	9558	5257
9700	86	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 1	9558	5253
9701	96	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 1	9558	5254
9702	41	35	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 1	9558	5256
9703	53	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 1	9558	5258
9704	89	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 1	9558	5260
9705	45	32	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 1	9558	5276
9706	39	38	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 1	9558	5261
9707	24	45	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 1	9558	5262
9708	60	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 1	9558	5277
9709	65	37	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 1	9558	5265
9710	51	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 1	9558	5269
9711	95	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 1	9558	5274
9712	55	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 1	9558	5275
9713	60	39	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 0	9559	5257
9714	41	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 0	9559	5253
9715	35	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 0	9559	5254
9716	48	35	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 0	9559	5276
9717	26	38	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 0	9559	5256
9718	82	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 0	9559	5258
9719	57	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 0	9559	5260
9720	26	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 0	9559	5275
9721	59	49	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 0	9559	5261
9722	85	44	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 0	9559	5262
9723	27	39	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 0	9559	5265
9724	39	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 0	9559	5269
9725	69	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 0	9559	5274
9726	20	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 0	9559	5277
9727	43	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 1	9560	5254
9728	27	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 1	9560	5253
9729	35	48	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 1	9560	5256
9730	24	43	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 1	9560	5257
9731	33	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 1	9560	5258
9732	52	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 1	9560	5260
9733	75	30	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 1	9560	5261
9734	78	39	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 1	9560	5262
9735	42	41	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 1	9560	5265
9736	56	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 1	9560	5269
9737	54	41	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 1	9560	5276
9738	27	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 1	9560	5275
9739	21	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 1	9560	5274
9740	80	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 1	9560	5277
9741	45	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 0	9561	5253
9742	21	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 0	9561	5254
9743	41	35	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 0	9561	5256
9744	67	36	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 0	9561	5257
9745	93	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 0	9561	5258
9746	35	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 0	9561	5260
9747	23	34	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 0	9561	5276
9748	38	50	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 0	9561	5261
9749	23	31	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 0	9561	5262
9750	78	32	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 0	9561	5265
9751	57	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 0	9561	5275
9752	96	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 0	9561	5277
9753	58	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 0	9561	5269
9754	23	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 0	9561	5274
9755	53	34	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 1	9562	5256
9756	95	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 1	9562	5253
9757	32	36	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 1	9562	5276
9758	94	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 1	9562	5254
9759	46	41	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 1	9562	5257
9760	72	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 1	9562	5258
9761	71	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 1	9562	5260
9762	94	50	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 1	9562	5261
9763	57	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 1	9562	5277
9764	51	38	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 1	9562	5262
9765	68	39	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 1	9562	5265
9766	75	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 1	9562	5275
9767	78	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 1	9562	5269
9768	83	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 1	9562	5274
9769	70	40	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 0	9563	5262
9770	36	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 0	9563	5253
9771	70	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 0	9563	5254
9772	50	50	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 0	9563	5256
9773	30	40	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 0	9563	5257
9774	45	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 0	9563	5277
9775	100	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 0	9563	5258
9776	26	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 0	9563	5260
9777	63	47	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 0	9563	5276
9778	68	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 0	9563	5275
9779	51	40	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 0	9563	5261
9780	35	42	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 0	9563	5265
9781	77	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 0	9563	5269
9782	34	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 0	9563	5274
9783	48	50	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 1	9564	5256
9784	29	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 1	9564	5253
9785	68	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 1	9564	5254
9786	56	45	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 1	9564	5257
9787	73	37	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 1	9564	5276
9788	100	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 1	9564	5277
9789	55	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 1	9564	5275
9790	83	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 1	9564	5258
9791	94	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 1	9564	5260
9792	53	48	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 1	9564	5261
9793	38	40	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 1	9564	5262
9794	54	41	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 1	9564	5265
9795	92	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 1	9564	5269
9796	83	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 1	9564	5274
9797	51	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 0	9565	5253
9798	34	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 0	9565	5254
9799	100	38	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 0	9565	5256
9800	26	50	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 0	9565	5257
9801	39	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 0	9565	5258
9802	78	46	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 0	9565	5276
9803	28	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 0	9565	5260
9804	75	31	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 0	9565	5261
9805	60	41	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 0	9565	5262
9806	35	30	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 0	9565	5265
9807	27	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 0	9565	5269
9808	97	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 0	9565	5277
9809	43	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 0	9565	5274
9810	25	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 0	9565	5275
9811	47	42	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 1	9566	5257
9812	89	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 1	9566	5253
9813	78	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 1	9566	5254
9814	60	35	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 1	9566	5256
9815	50	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 1	9566	5258
9816	39	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 1	9566	5260
9817	52	50	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 1	9566	5261
9818	84	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 1	9566	5275
9819	73	42	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 1	9566	5276
9820	90	49	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 1	9566	5262
9821	99	37	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 1	9566	5265
9822	50	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 1	9566	5269
9823	97	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 1	9566	5274
9824	78	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 1	9566	5277
9825	20	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 0	9567	5253
9826	35	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 0	9567	5254
9827	31	48	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 0	9567	5276
9828	97	36	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 0	9567	5256
9829	45	30	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 0	9567	5257
9830	64	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 0	9567	5258
9831	57	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 0	9567	5260
9832	76	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 0	9567	5277
9833	79	43	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 0	9567	5261
9834	41	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 0	9567	5275
9835	96	32	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 0	9567	5262
9836	63	38	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 0	9567	5265
9837	80	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 0	9567	5269
9838	29	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 0	9567	5274
9839	21	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 1	9568	5253
9840	26	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 1	9568	5254
9841	69	44	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 1	9568	5256
9842	29	45	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 1	9568	5276
9843	29	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 1	9568	5277
9844	33	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 1	9568	5275
9845	32	36	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 1	9568	5257
9846	51	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 1	9568	5258
9847	43	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 1	9568	5260
9848	45	33	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 1	9568	5261
9849	65	42	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 1	9568	5262
9850	51	41	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 1	9568	5265
9851	72	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 1	9568	5269
9852	46	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 1	9568	5274
9853	83	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 0	9569	5254
9854	44	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 0	9569	5253
9855	68	30	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 0	9569	5256
9856	86	37	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 0	9569	5257
9857	76	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 0	9569	5258
9858	22	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 0	9569	5260
9859	69	35	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 0	9569	5261
9860	82	32	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 0	9569	5276
9861	38	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 0	9569	5277
9862	53	42	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 0	9569	5262
9863	72	37	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 0	9569	5265
9864	79	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 0	9569	5269
9865	83	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 0	9569	5274
9866	44	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 0	9569	5275
9867	73	42	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 1	9570	5256
9868	75	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 1	9570	5253
9869	75	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 1	9570	5277
9870	73	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 1	9570	5254
9871	48	34	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 1	9570	5257
9872	87	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 1	9570	5258
9873	35	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 1	9570	5260
9874	79	46	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 1	9570	5276
9875	50	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 1	9570	5275
9876	49	38	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 1	9570	5261
9877	46	43	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 1	9570	5262
9878	27	34	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 1	9570	5265
9879	25	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 1	9570	5269
9880	93	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 1	9570	5274
9881	63	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 0	9571	5254
9882	45	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 0	9571	5253
9883	71	42	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 0	9571	5256
9884	52	35	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 0	9571	5257
9885	48	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 0	9571	5277
9886	80	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 0	9571	5258
9887	20	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 0	9571	5260
9888	70	41	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 0	9571	5261
9889	96	44	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 0	9571	5262
9890	94	41	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 0	9571	5265
9891	49	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 0	9571	5269
9892	70	38	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 0	9571	5276
9893	77	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 0	9571	5275
9894	33	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 0	9571	5274
9895	66	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 1	9572	5254
9896	60	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 1	9572	5253
9897	99	36	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 1	9572	5256
9898	85	41	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 1	9572	5257
9899	61	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 1	9572	5258
9900	87	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 1	9572	5260
9901	38	50	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 1	9572	5261
9902	53	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 1	9572	5277
9903	78	30	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 1	9572	5262
9904	60	38	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 1	9572	5265
9905	27	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 1	9572	5275
9906	55	40	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 1	9572	5276
9907	47	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 1	9572	5269
9908	48	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 1	9572	5274
9909	89	50	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 0	9573	5257
9910	63	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 0	9573	5253
9911	93	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 0	9573	5254
9912	76	41	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 0	9573	5256
9913	21	50	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 0	9573	5276
9914	92	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 0	9573	5277
9915	50	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 0	9573	5258
9916	77	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 0	9573	5260
9917	57	46	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 0	9573	5261
9918	34	39	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 0	9573	5262
9919	97	35	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 0	9573	5265
9920	63	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 0	9573	5269
9921	52	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 0	9573	5275
9922	69	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 0	9573	5274
9923	31	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 1	9574	5260
9924	22	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 1	9574	5253
9925	23	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 1	9574	5254
9926	33	34	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 1	9574	5256
9927	78	45	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 1	9574	5257
9928	88	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 1	9574	5275
9929	47	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 1	9574	5277
9930	41	44	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 1	9574	5276
9931	74	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 1	9574	5258
9932	95	36	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 1	9574	5261
9933	81	34	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 1	9574	5262
9934	75	39	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 1	9574	5265
9935	33	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 1	9574	5269
9936	68	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 1	9574	5274
9937	91	36	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 0	9575	5256
9938	97	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 0	9575	5253
9939	79	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 0	9575	5254
9940	41	50	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 0	9575	5257
9941	71	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 0	9575	5258
9942	48	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 0	9575	5260
9943	55	45	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 0	9575	5261
9944	40	47	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 0	9575	5276
9945	58	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 0	9575	5277
9946	88	38	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 0	9575	5262
9947	91	37	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 0	9575	5265
9948	40	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 0	9575	5275
9949	48	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 0	9575	5269
9950	38	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 0	9575	5274
9951	28	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 1	9576	5253
9952	39	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 1	9576	5254
9953	52	42	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 1	9576	5276
9954	65	32	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 1	9576	5256
9955	71	36	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 1	9576	5257
9956	69	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 1	9576	5258
9957	69	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 1	9576	5260
9958	99	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 1	9576	5275
9959	42	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 1	9576	5277
9960	71	45	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 1	9576	5261
9961	93	34	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 1	9576	5262
9962	53	45	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 1	9576	5265
9963	97	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 1	9576	5269
9964	31	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 1	9576	5274
9965	52	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 0	9577	5260
9966	22	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 0	9577	5253
9967	22	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 0	9577	5275
9968	34	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 0	9577	5254
9969	22	30	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 0	9577	5256
9970	36	40	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 0	9577	5257
9971	41	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 0	9577	5258
9972	30	41	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 0	9577	5261
9973	47	34	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 0	9577	5262
9974	61	50	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 0	9577	5276
9975	80	49	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 0	9577	5265
9976	21	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 0	9577	5269
9977	64	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 0	9577	5274
9978	56	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 0	9577	5277
9979	52	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 1	9578	5253
9980	40	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 1	9578	5254
9981	73	36	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 1	9578	5256
9982	75	47	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 1	9578	5257
9983	73	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 1	9578	5258
9984	81	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 1	9578	5277
9985	22	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 1	9578	5260
9986	97	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 1	9578	5275
9987	34	34	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 1	9578	5261
9988	97	46	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 1	9578	5262
9989	87	33	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 1	9578	5276
9990	64	36	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 1	9578	5265
9991	65	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 1	9578	5269
9992	90	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 1	9578	5274
9993	91	30	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 0	9579	5265
9994	36	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 0	9579	5253
9995	100	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 0	9579	5254
9996	99	48	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 0	9579	5256
9997	37	30	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 0	9579	5257
9998	30	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 0	9579	5258
9999	75	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 0	9579	5260
10000	96	41	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 0	9579	5276
10001	40	33	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 0	9579	5261
10002	66	50	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 0	9579	5262
10003	55	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 0	9579	5277
10004	33	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 0	9579	5269
10005	70	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 0	9579	5275
10006	95	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 0	9579	5274
10007	88	42	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 1	9580	5261
10008	46	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 1	9580	5253
10009	40	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 1	9580	5254
10010	56	45	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 1	9580	5256
10011	50	45	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 1	9580	5257
10012	35	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 1	9580	5258
10013	58	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 1	9580	5260
10014	97	46	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 1	9580	5262
10015	46	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 1	9580	5275
10016	32	46	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 1	9580	5265
10017	88	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 1	9580	5269
10018	72	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 1	9580	5277
10019	24	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 1	9580	5274
10020	93	31	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 1	9580	5276
10021	53	33	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 0	9581	5256
10022	33	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 0	9581	5253
10023	34	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 0	9581	5254
10024	74	36	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 0	9581	5257
10025	91	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 0	9581	5277
10026	62	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 0	9581	5258
10027	74	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 0	9581	5260
10028	61	31	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 0	9581	5261
10029	69	50	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 0	9581	5276
10030	48	40	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 0	9581	5262
10031	81	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 0	9581	5275
10032	96	38	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 0	9581	5265
10033	94	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 0	9581	5269
10034	26	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 0	9581	5274
10035	59	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 1	9582	5254
10036	91	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 1	9582	5253
10037	72	34	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 1	9582	5256
10038	54	45	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 1	9582	5257
10039	89	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 1	9582	5258
10040	40	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 1	9582	5260
10041	77	38	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 1	9582	5261
10042	30	34	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 1	9582	5262
10043	66	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 1	9582	5275
10044	60	32	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 1	9582	5276
10045	66	37	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 1	9582	5265
10046	29	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 1	9582	5277
10047	41	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 1	9582	5269
10048	20	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 1	9582	5274
10049	78	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 0	9583	5260
10050	59	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 0	9583	5253
10051	86	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 0	9583	5254
10052	33	33	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 0	9583	5256
10053	40	44	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 0	9583	5257
10054	37	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 0	9583	5258
10055	41	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 0	9583	5277
10056	88	38	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 0	9583	5261
10057	94	39	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 0	9583	5262
10058	63	45	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 0	9583	5276
10059	50	30	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 0	9583	5265
10060	44	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 0	9583	5269
10061	65	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 0	9583	5274
10062	84	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 0	9583	5275
10063	42	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 1	9584	5254
10064	38	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 1	9584	5253
10065	47	45	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 1	9584	5256
10066	96	50	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 1	9584	5257
10067	25	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 1	9584	5277
10068	98	32	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 1	9584	5276
10069	55	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 1	9584	5258
10070	53	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 1	9584	5260
10071	92	49	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 1	9584	5261
10072	67	36	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 1	9584	5262
10073	58	47	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 1	9584	5265
10074	90	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 1	9584	5275
10075	81	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 1	9584	5269
10076	20	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 1	9584	5274
10077	69	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 0	9585	5254
10078	44	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 0	9585	5253
10079	20	44	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 0	9585	5256
10080	83	49	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 0	9585	5257
10081	80	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 0	9585	5258
10082	55	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 0	9585	5275
10083	47	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 0	9585	5260
10084	52	38	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 0	9585	5261
10085	95	38	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 0	9585	5262
10086	31	41	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 0	9585	5265
10087	70	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 0	9585	5269
10088	81	47	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 0	9585	5276
10089	20	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 0	9585	5274
10090	98	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 0	9585	5277
10091	43	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 1	9586	5253
10092	87	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 1	9586	5254
10093	28	34	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 1	9586	5256
10094	29	43	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 1	9586	5257
10095	32	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 1	9586	5258
10096	53	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 1	9586	5260
10097	71	33	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 1	9586	5261
10098	66	34	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 1	9586	5262
10099	56	41	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 1	9586	5265
10100	64	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 1	9586	5269
10101	64	37	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 1	9586	5276
10102	43	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 1	9586	5277
10103	46	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 1	9586	5274
10104	42	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 1	9586	5275
10105	44	30	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 0	9587	5256
10106	62	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 0	9587	5253
10107	64	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 0	9587	5254
10108	22	35	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 0	9587	5257
10109	99	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 0	9587	5258
10110	91	34	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 0	9587	5276
10111	94	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 0	9587	5260
10112	79	36	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 0	9587	5261
10113	92	44	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 0	9587	5262
10114	44	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 0	9587	5277
10115	61	30	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 0	9587	5265
10116	25	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 0	9587	5275
10117	88	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 0	9587	5269
10118	78	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 0	9587	5274
10119	33	40	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 1	9588	5262
10120	36	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 1	9588	5253
10121	89	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 1	9588	5254
10122	21	45	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 1	9588	5256
10123	33	35	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 1	9588	5257
10124	46	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 1	9588	5275
10125	26	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 1	9588	5258
10126	67	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 1	9588	5277
10127	34	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 1	9588	5260
10128	98	42	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 1	9588	5261
10129	95	48	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 1	9588	5265
10130	87	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 1	9588	5269
10131	71	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 1	9588	5274
10132	32	41	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 1	9588	5276
10133	38	42	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 0	9589	5257
10134	61	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 0	9589	5253
10135	20	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 0	9589	5254
10136	23	39	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 0	9589	5256
10137	84	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 0	9589	5275
10138	42	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 0	9589	5258
10139	55	43	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 0	9589	5276
10140	32	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 0	9589	5260
10141	35	38	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 0	9589	5261
10142	35	32	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 0	9589	5262
10143	99	35	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 0	9589	5265
10144	40	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 0	9589	5269
10145	73	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 0	9589	5277
10146	83	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 0	9589	5274
10147	23	45	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 1	9590	5256
10148	75	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 1	9590	5253
10149	41	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 1	9590	5254
10150	92	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 1	9590	5275
10151	61	41	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 1	9590	5257
10152	22	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 1	9590	5258
10153	73	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 1	9590	5260
10154	23	30	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 1	9590	5261
10155	62	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 1	9590	5277
10156	38	49	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 1	9590	5262
10157	98	46	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 1	9590	5265
10158	96	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 1	9590	5269
10159	65	32	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 1	9590	5276
10160	100	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 1	9590	5274
10161	27	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 0	9591	5253
10162	54	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 0	9591	5254
10163	57	46	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 0	9591	5256
10164	54	39	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 0	9591	5257
10165	69	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 0	9591	5258
10166	52	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 0	9591	5260
10167	90	50	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 0	9591	5261
10168	66	50	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 0	9591	5262
10169	23	37	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 0	9591	5265
10170	32	30	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 0	9591	5276
10171	20	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 0	9591	5269
10172	48	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 0	9591	5277
10173	88	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 0	9591	5274
10174	97	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 0	9591	5275
10175	73	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 1	9592	5258
10176	88	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 1	9592	5253
10177	47	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 1	9592	5254
10178	78	36	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 1	9592	5256
10179	80	48	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 1	9592	5257
10180	42	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 1	9592	5260
10181	36	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 1	9592	5277
10182	69	37	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 1	9592	5261
10183	29	45	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 1	9592	5262
10184	65	42	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 1	9592	5276
10185	77	41	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 1	9592	5265
10186	64	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 1	9592	5275
10187	95	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 1	9592	5269
10188	29	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 1	9592	5274
10189	63	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 0	9593	5254
10190	27	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 0	9593	5253
10191	31	47	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 0	9593	5256
10192	51	42	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 0	9593	5257
10193	20	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 0	9593	5277
10194	88	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 0	9593	5258
10195	98	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 0	9593	5260
10196	90	39	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 0	9593	5261
10197	72	50	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 0	9593	5262
10198	96	39	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 0	9593	5265
10199	34	41	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 0	9593	5276
10200	29	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 0	9593	5269
10201	70	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 0	9593	5274
10202	70	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 0	9593	5275
10203	68	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 1	9594	5254
10204	77	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 1	9594	5253
10205	66	38	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 1	9594	5256
10206	82	45	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 1	9594	5257
10207	47	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 1	9594	5275
10208	85	41	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 1	9594	5276
10209	55	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 1	9594	5258
10210	26	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 1	9594	5260
10211	32	46	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 1	9594	5261
10212	55	34	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 1	9594	5262
10213	31	35	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 1	9594	5265
10214	76	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 1	9594	5277
10215	46	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 1	9594	5269
10216	51	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 1	9594	5274
10217	68	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 0	9595	5254
10218	76	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 0	9595	5253
10219	82	31	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 0	9595	5256
10220	86	44	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 0	9595	5257
10221	77	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 0	9595	5277
10222	32	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 0	9595	5258
10223	95	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 0	9595	5260
10224	73	50	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 0	9595	5261
10225	32	34	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 0	9595	5262
10226	60	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 0	9595	5275
10227	43	47	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 0	9595	5265
10228	55	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 0	9595	5269
10229	35	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 0	9595	5274
10230	77	50	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 0	9595	5276
10231	90	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 1	9596	5253
10232	53	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 1	9596	5254
10233	41	50	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 1	9596	5256
10234	69	38	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 1	9596	5257
10235	92	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 1	9596	5258
10236	20	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 1	9596	5260
10237	60	33	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 1	9596	5261
10238	46	50	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 1	9596	5276
10239	59	48	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 1	9596	5262
10240	30	39	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 1	9596	5265
10241	28	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 1	9596	5275
10242	71	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 1	9596	5269
10243	97	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 1	9596	5277
10244	25	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 1	9596	5274
10245	99	45	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 0	9597	5261
10246	45	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 0	9597	5253
10247	76	45	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 0	9597	5276
10248	86	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 0	9597	5254
10249	58	46	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 0	9597	5256
10250	53	31	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 0	9597	5257
10251	65	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 0	9597	5258
10252	54	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 0	9597	5275
10253	89	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 0	9597	5260
10254	88	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 0	9597	5277
10255	52	46	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 0	9597	5262
10256	99	31	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 0	9597	5265
10257	71	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 0	9597	5269
10258	95	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 0	9597	5274
10259	26	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 1	9598	5254
10260	85	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 1	9598	5253
10261	39	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 1	9598	5277
10262	22	33	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 1	9598	5256
10263	58	33	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 1	9598	5257
10264	37	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 1	9598	5258
10265	69	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 1	9598	5260
10266	82	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 1	9598	5275
10267	40	32	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 1	9598	5261
10268	83	31	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 1	9598	5262
10269	56	50	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 1	9598	5265
10270	78	32	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 1	9598	5276
10271	22	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 1	9598	5269
10272	56	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 1	9598	5274
10273	75	37	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 0	9599	5256
10274	23	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 0	9599	5253
10275	44	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 0	9599	5254
10276	91	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 0	9599	5275
10277	55	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 0	9599	5277
10278	74	33	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 0	9599	5257
10279	32	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 0	9599	5258
10280	46	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 0	9599	5260
10281	88	41	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 0	9599	5261
10282	39	43	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 0	9599	5276
10283	57	33	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 0	9599	5262
10284	53	40	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 0	9599	5265
10285	53	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 0	9599	5269
10286	63	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 0	9599	5274
10287	78	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 1	9600	5258
10288	60	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 1	9600	5253
10289	63	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 1	9600	5254
10290	31	35	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 1	9600	5276
10291	30	34	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 1	9600	5256
10292	95	50	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 1	9600	5257
10293	92	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 1	9600	5260
10294	75	45	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 1	9600	5261
10295	44	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 1	9600	5275
10296	92	45	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 1	9600	5262
10297	81	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 1	9600	5277
10298	54	44	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 1	9600	5265
10299	69	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 1	9600	5269
10300	93	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 1	9600	5274
10401	21	49	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 0	10351	5256
10402	75	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 0	10351	5253
10403	44	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 0	10351	5254
10404	58	41	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 0	10351	5257
10405	40	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 0	10351	5258
10406	23	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 0	10351	5260
10407	90	38	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 0	10351	5261
10408	49	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 0	10351	5277
10409	25	44	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 0	10351	5262
10410	91	40	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 0	10351	5265
10411	60	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 0	10351	5269
10412	51	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 0	10351	5274
10413	24	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 0	10351	5275
10414	97	45	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 0	10351	5276
10415	28	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 1	10352	5258
10416	55	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 1	10352	5253
10417	84	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 1	10352	5254
10418	26	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 1	10352	5275
10419	98	44	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 1	10352	5256
10420	62	36	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 1	10352	5257
10421	22	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 1	10352	5260
10422	31	48	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 1	10352	5261
10423	64	43	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 1	10352	5276
10424	95	31	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 1	10352	5262
10425	33	42	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 1	10352	5265
10426	38	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 1	10352	5269
10427	20	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 1	10352	5274
10428	29	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 1	10352	5277
10429	28	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 0	10353	5258
10430	54	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 0	10353	5253
10431	53	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 0	10353	5254
10432	52	30	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 0	10353	5256
10433	53	37	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 0	10353	5257
10434	66	35	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 0	10353	5276
10435	65	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 0	10353	5260
10436	38	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 0	10353	5275
10437	73	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 0	10353	5277
10438	86	39	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 0	10353	5261
10439	24	40	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 0	10353	5262
10440	86	41	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 0	10353	5265
10441	73	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 0	10353	5269
10442	98	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 0	10353	5274
10443	46	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 1	10354	5254
10444	56	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 1	10354	5253
10445	22	33	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 1	10354	5256
10446	77	35	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 1	10354	5257
10447	43	37	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 1	10354	5276
10448	53	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 1	10354	5277
10449	83	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 1	10354	5258
10450	98	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 1	10354	5260
10451	22	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 1	10354	5275
10452	90	46	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 1	10354	5261
10453	92	37	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 1	10354	5262
10454	25	46	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 1	10354	5265
10455	34	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 1	10354	5269
10456	55	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 1	10354	5274
10457	36	48	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 0	10355	5261
10458	88	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 0	10355	5253
10459	24	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 0	10355	5254
10460	95	50	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 0	10355	5256
10461	21	35	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 0	10355	5257
10462	58	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 0	10355	5258
10463	61	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 0	10355	5260
10464	57	46	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 0	10355	5276
10465	38	37	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 0	10355	5262
10466	83	33	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 0	10355	5265
10467	53	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 0	10355	5275
10468	87	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 0	10355	5277
10469	83	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 0	10355	5269
10470	41	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 0	10355	5274
10471	50	32	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 1	10356	5261
10472	84	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 1	10356	5254
10473	85	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 1	10356	5253
10474	34	47	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 1	10356	5256
10475	32	36	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 1	10356	5257
10476	69	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 1	10356	5277
10477	85	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 1	10356	5258
10478	50	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 1	10356	5260
10479	99	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 1	10356	5275
10480	33	37	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 1	10356	5276
10481	28	38	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 1	10356	5262
10482	72	35	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 1	10356	5265
10483	41	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 1	10356	5269
10484	67	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 1	10356	5274
10485	90	41	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 0	10357	5262
10486	81	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 0	10357	5253
10487	57	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 0	10357	5254
10488	73	32	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 0	10357	5276
10489	42	49	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 0	10357	5256
10490	30	36	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 0	10357	5257
10491	20	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 0	10357	5258
10492	70	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 0	10357	5260
10493	31	46	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 0	10357	5261
10494	62	35	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 0	10357	5265
10495	21	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 0	10357	5269
10496	26	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 0	10357	5277
10497	53	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 0	10357	5274
10498	91	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 0	10357	5275
10499	41	40	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 1	10358	5257
10500	49	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 1	10358	5253
10501	38	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 1	10358	5254
10502	81	32	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 1	10358	5256
10503	52	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 1	10358	5258
10504	82	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 1	10358	5260
10505	91	43	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 1	10358	5261
10506	84	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 1	10358	5277
10507	86	43	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 1	10358	5262
10508	47	31	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 1	10358	5265
10509	65	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 1	10358	5269
10510	98	41	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 1	10358	5276
10511	56	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 1	10358	5274
10512	47	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 1	10358	5275
10513	25	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 0	10359	5254
10514	73	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 0	10359	5253
10515	62	38	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 0	10359	5256
10516	91	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 0	10359	5277
10517	92	40	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 0	10359	5276
10518	53	30	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 0	10359	5257
10519	100	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 0	10359	5258
10520	66	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 0	10359	5260
10521	82	38	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 0	10359	5261
10522	69	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 0	10359	5275
10523	35	43	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 0	10359	5262
10524	68	49	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 0	10359	5265
10525	32	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 0	10359	5269
10526	88	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 0	10359	5274
10527	84	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 1	10360	5254
10528	60	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 1	10360	5253
10529	78	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 1	10360	5277
10530	26	38	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 1	10360	5276
10531	33	46	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 1	10360	5256
10532	90	32	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 1	10360	5257
10533	72	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 1	10360	5258
10534	43	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 1	10360	5260
10535	37	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 1	10360	5275
10536	77	30	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 1	10360	5261
10537	23	31	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 1	10360	5262
10538	33	38	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 1	10360	5265
10539	47	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 1	10360	5269
10540	96	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 1	10360	5274
10541	39	49	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 0	10361	5262
10542	85	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 0	10361	5253
10543	58	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 0	10361	5277
10544	61	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 0	10361	5254
10545	100	32	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 0	10361	5256
10546	49	37	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 0	10361	5276
10547	38	30	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 0	10361	5257
10548	92	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 0	10361	5258
10549	93	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 0	10361	5260
10550	80	34	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 0	10361	5261
10551	47	47	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 0	10361	5265
10552	94	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 0	10361	5275
10553	84	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 0	10361	5269
10554	89	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 0	10361	5274
10555	49	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 1	10362	5253
10556	75	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 1	10362	5254
10557	87	39	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 1	10362	5256
10558	90	49	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 1	10362	5257
10559	68	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 1	10362	5258
10560	62	31	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 1	10362	5276
10561	56	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 1	10362	5260
10562	49	47	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 1	10362	5261
10563	81	47	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 1	10362	5262
10564	52	31	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 1	10362	5265
10565	91	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 1	10362	5269
10566	24	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 1	10362	5277
10567	48	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 1	10362	5275
10568	99	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 1	10362	5274
10569	72	36	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 0	10363	5257
10570	28	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 0	10363	5253
10571	24	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 0	10363	5254
10572	67	47	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 0	10363	5256
10573	42	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 0	10363	5258
10574	27	43	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 0	10363	5276
10575	20	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 0	10363	5260
10576	46	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 0	10363	5275
10577	37	48	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 0	10363	5261
10578	95	38	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 0	10363	5262
10579	66	35	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 0	10363	5265
10580	59	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 0	10363	5269
10581	86	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 0	10363	5277
10582	59	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 0	10363	5274
10583	57	34	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 1	10364	5256
10584	93	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 1	10364	5253
10585	78	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 1	10364	5277
10586	29	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 1	10364	5254
10587	50	33	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 1	10364	5257
10588	75	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 1	10364	5258
10589	99	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 1	10364	5260
10590	58	47	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 1	10364	5261
10591	41	36	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 1	10364	5276
10592	67	50	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 1	10364	5262
10593	76	34	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 1	10364	5265
10594	68	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 1	10364	5269
10595	41	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 1	10364	5274
10596	64	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 1	10364	5275
10597	28	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 0	10365	5253
10598	74	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 0	10365	5254
10599	20	33	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 0	10365	5256
10600	39	47	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 0	10365	5257
10601	70	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 0	10365	5258
10602	90	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 0	10365	5260
10603	55	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 0	10365	5277
10604	62	48	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 0	10365	5261
10605	67	34	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 0	10365	5262
10606	55	39	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 0	10365	5265
10607	60	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 0	10365	5275
10608	25	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 0	10365	5269
10609	48	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 0	10365	5274
10610	63	33	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 0	10365	5276
10611	83	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 1	10366	5258
10612	35	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 1	10366	5253
10613	34	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 1	10366	5254
10614	50	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 1	10366	5275
10615	59	37	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 1	10366	5256
10616	54	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 1	10366	5277
10617	76	41	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 1	10366	5276
10618	82	46	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 1	10366	5257
10619	60	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 1	10366	5260
10620	52	37	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 1	10366	5261
10621	72	33	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 1	10366	5262
10622	37	47	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 1	10366	5265
10623	32	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 1	10366	5269
10624	46	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 1	10366	5274
10625	62	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 0	10367	5260
10626	33	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 0	10367	5253
10627	99	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 0	10367	5254
10628	79	49	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 0	10367	5256
10629	28	30	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 0	10367	5257
10630	50	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 0	10367	5275
10631	22	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 0	10367	5258
10632	54	39	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 0	10367	5261
10633	45	47	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 0	10367	5276
10634	85	38	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 0	10367	5262
10635	100	48	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 0	10367	5265
10636	45	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 0	10367	5269
10637	65	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 0	10367	5277
10638	78	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 0	10367	5274
10639	89	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 1	10368	5253
10640	45	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 1	10368	5254
10641	70	47	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 1	10368	5256
10642	75	48	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 1	10368	5257
10643	79	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 1	10368	5258
10644	21	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 1	10368	5260
10645	21	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 1	10368	5275
10646	57	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 1	10368	5277
10647	100	36	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 1	10368	5276
10648	33	43	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 1	10368	5261
10649	44	40	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 1	10368	5262
10650	20	34	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 1	10368	5265
10651	61	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 1	10368	5269
10652	76	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 1	10368	5274
10653	36	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 0	10369	5254
10654	28	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 0	10369	5253
10655	53	45	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 0	10369	5256
10656	72	50	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 0	10369	5276
10657	74	47	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 0	10369	5257
10658	53	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 0	10369	5258
10659	81	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 0	10369	5260
10660	83	39	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 0	10369	5261
10661	39	33	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 0	10369	5262
10662	32	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 0	10369	5275
10663	73	32	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 0	10369	5265
10664	68	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 0	10369	5269
10665	95	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 0	10369	5277
10666	62	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 0	10369	5274
10667	48	43	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 1	10370	5256
10668	58	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 1	10370	5253
10669	32	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 1	10370	5254
10670	35	46	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 1	10370	5276
10671	40	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 1	10370	5277
10672	22	31	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 1	10370	5257
10673	95	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 1	10370	5258
10674	64	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 1	10370	5260
10675	63	37	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 1	10370	5261
10676	71	46	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 1	10370	5262
10677	47	30	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 1	10370	5265
10678	89	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 1	10370	5269
10679	51	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 1	10370	5274
10680	86	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 1	10370	5275
10681	29	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 0	10371	5254
10682	70	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 0	10371	5253
10683	70	33	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 0	10371	5256
10684	28	45	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 0	10371	5257
10685	44	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 0	10371	5277
10686	47	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 0	10371	5258
10687	85	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 0	10371	5260
10688	30	38	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 0	10371	5261
10689	53	48	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 0	10371	5276
10690	24	45	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 0	10371	5262
10691	58	32	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 0	10371	5265
10692	90	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 0	10371	5275
10693	67	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 0	10371	5269
10694	66	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 0	10371	5274
10695	24	44	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 1	10372	5257
10696	27	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 1	10372	5253
10697	44	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 1	10372	5254
10698	86	37	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 1	10372	5256
10699	80	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 1	10372	5258
10700	28	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 1	10372	5275
10701	22	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 1	10372	5277
10702	98	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 1	10372	5260
10703	38	44	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 1	10372	5276
10704	95	39	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 1	10372	5261
10705	75	30	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 1	10372	5262
10706	21	41	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 1	10372	5265
10707	92	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 1	10372	5269
10708	81	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 1	10372	5274
10709	64	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 0	10373	5258
10710	28	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 0	10373	5253
10711	84	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 0	10373	5254
10712	97	46	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 0	10373	5276
10713	68	32	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 0	10373	5256
10714	73	42	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 0	10373	5257
10715	79	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 0	10373	5260
10716	38	31	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 0	10373	5261
10717	45	37	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 0	10373	5262
10718	51	36	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 0	10373	5265
10719	88	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 0	10373	5277
10720	100	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 0	10373	5269
10721	41	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 0	10373	5275
10722	96	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 0	10373	5274
10723	99	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 1	10374	5258
10724	68	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 1	10374	5253
10725	55	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 1	10374	5254
10726	27	41	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 1	10374	5256
10727	35	49	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 1	10374	5257
10728	52	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 1	10374	5260
10729	99	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 1	10374	5275
10730	83	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 1	10374	5277
10731	93	32	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 1	10374	5261
10732	43	34	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 1	10374	5276
10733	25	47	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 1	10374	5262
10734	85	43	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 1	10374	5265
10735	67	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 1	10374	5269
10736	23	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 1	10374	5274
10737	41	33	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 0	10375	5262
10738	45	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 0	10375	5253
10739	87	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 0	10375	5254
10740	93	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 0	10375	5275
10741	59	31	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 0	10375	5256
10742	21	30	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 0	10375	5257
10743	45	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 0	10375	5258
10744	83	42	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 0	10375	5276
10745	24	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 0	10375	5260
10746	97	41	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 0	10375	5261
10747	54	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 0	10375	5277
10748	58	50	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 0	10375	5265
10749	63	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 0	10375	5269
10750	46	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 0	10375	5274
10751	73	35	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 1	10376	5265
10752	78	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 1	10376	5253
10753	43	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 1	10376	5254
10754	75	43	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 1	10376	5256
10755	66	37	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 1	10376	5257
10756	93	48	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 1	10376	5276
10757	32	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 1	10376	5258
10758	81	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 1	10376	5260
10759	47	48	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 1	10376	5261
10760	36	40	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 1	10376	5262
10761	25	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 1	10376	5275
10762	32	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 1	10376	5269
10763	87	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 1	10376	5277
10764	43	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 1	10376	5274
10765	82	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 0	10377	5258
10766	36	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 0	10377	5253
10767	65	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 0	10377	5254
10768	57	36	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 0	10377	5256
10769	46	37	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 0	10377	5257
10770	86	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 0	10377	5260
10771	86	30	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 0	10377	5276
10772	52	30	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 0	10377	5261
10773	33	41	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 0	10377	5262
10774	91	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 0	10377	5277
10775	59	42	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 0	10377	5265
10776	98	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 0	10377	5269
10777	94	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 0	10377	5274
10778	29	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 0	10377	5275
10779	71	40	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 1	10378	5256
10780	53	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 1	10378	5253
10781	41	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 1	10378	5254
10782	52	44	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 1	10378	5257
10783	85	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 1	10378	5258
10784	56	44	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 1	10378	5276
10785	38	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 1	10378	5260
10786	98	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 1	10378	5277
10787	58	38	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 1	10378	5261
10788	33	40	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 1	10378	5262
10789	24	42	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 1	10378	5265
10790	38	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 1	10378	5275
10791	63	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 1	10378	5269
10792	94	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 1	10378	5274
10793	47	43	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 0	10379	5256
10794	31	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 0	10379	5253
10795	38	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 0	10379	5254
10796	94	31	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 0	10379	5257
10797	41	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 0	10379	5258
10798	100	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 0	10379	5260
10799	84	44	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 0	10379	5261
10800	96	39	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 0	10379	5262
10801	88	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 0	10379	5275
10802	64	33	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 0	10379	5265
10803	70	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 0	10379	5277
10804	88	48	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 0	10379	5276
10805	34	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 0	10379	5269
10806	99	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 0	10379	5274
10807	99	45	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 1	10380	5256
10808	56	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 1	10380	5253
10809	70	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 1	10380	5254
10810	66	32	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 1	10380	5257
10811	72	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 1	10380	5258
10812	97	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 1	10380	5260
10813	86	40	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 1	10380	5261
10814	85	48	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 1	10380	5262
10815	39	45	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 1	10380	5265
10816	89	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 1	10380	5269
10817	83	49	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 1	10380	5276
10818	50	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 1	10380	5275
10819	36	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 1	10380	5274
10820	88	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 1	10380	5277
10821	26	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 0	10381	5254
10822	40	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 0	10381	5253
10823	43	46	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 0	10381	5256
10824	45	45	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 0	10381	5257
10825	88	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 0	10381	5258
10826	54	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 0	10381	5277
10827	75	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 0	10381	5260
10828	64	38	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 0	10381	5261
10829	93	49	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 0	10381	5262
10830	76	38	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 0	10381	5265
10831	99	44	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 0	10381	5276
10832	77	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 0	10381	5269
10833	99	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 0	10381	5275
10834	92	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 0	10381	5274
10835	64	50	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 1	10382	5256
10836	42	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 1	10382	5253
10837	55	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 1	10382	5275
10838	24	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 1	10382	5254
10839	92	35	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 1	10382	5257
10840	70	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 1	10382	5258
10841	45	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 1	10382	5260
10842	36	38	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 1	10382	5276
10843	45	32	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 1	10382	5261
10844	54	41	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 1	10382	5262
10845	35	39	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 1	10382	5265
10846	36	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 1	10382	5269
10847	29	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 1	10382	5277
10848	77	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 1	10382	5274
10849	40	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 0	10383	5253
10850	57	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 0	10383	5254
10851	82	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 0	10383	5277
10852	91	49	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 0	10383	5256
10853	64	40	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 0	10383	5257
10854	39	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 0	10383	5258
10855	37	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 0	10383	5260
10856	24	47	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 0	10383	5261
10857	43	33	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 0	10383	5262
10858	66	47	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 0	10383	5265
10859	33	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 0	10383	5269
10860	93	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 0	10383	5275
10861	90	47	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 0	10383	5276
10862	97	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 0	10383	5274
10863	63	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 1	10384	5253
10864	99	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 1	10384	5254
10865	42	39	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 1	10384	5256
10866	96	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 1	10384	5275
10867	25	31	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 1	10384	5257
10868	21	34	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 1	10384	5276
10869	97	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 1	10384	5258
10870	67	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 1	10384	5260
10871	50	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 1	10384	5277
10872	57	49	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 1	10384	5261
10873	81	38	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 1	10384	5262
10874	61	48	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 1	10384	5265
10875	77	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 1	10384	5269
10876	54	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 1	10384	5274
10877	69	47	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 0	10385	5256
10878	86	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 0	10385	5253
10879	64	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 0	10385	5254
10880	52	40	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 0	10385	5276
10881	78	33	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 0	10385	5257
10882	32	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 0	10385	5258
10883	53	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 0	10385	5260
10884	68	50	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 0	10385	5261
10885	30	40	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 0	10385	5262
10886	57	47	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 0	10385	5265
10887	56	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 0	10385	5269
10888	65	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 0	10385	5274
10889	20	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 0	10385	5277
10890	98	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 0	10385	5275
10891	76	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 1	10386	5253
10892	87	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 1	10386	5254
10893	79	49	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 1	10386	5276
10894	57	38	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 1	10386	5256
10895	28	35	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 1	10386	5257
10896	80	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 1	10386	5275
10897	71	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 1	10386	5258
10898	94	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 1	10386	5260
10899	51	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 1	10386	5277
10900	69	49	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 1	10386	5261
10901	81	33	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 1	10386	5262
10902	34	35	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 1	10386	5265
10903	58	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 1	10386	5269
10904	48	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 1	10386	5274
10905	83	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 0	10387	5254
10906	51	30	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 0	10387	5256
10907	60	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 0	10387	5253
10908	25	47	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 0	10387	5257
10909	25	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 0	10387	5258
10910	68	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 0	10387	5260
10911	22	46	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 0	10387	5261
10912	66	44	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 0	10387	5262
10913	75	36	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 0	10387	5265
10914	20	50	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 0	10387	5276
10915	21	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 0	10387	5277
10916	90	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 0	10387	5269
10917	38	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 0	10387	5274
10918	66	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 0	10387	5275
10919	49	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 1	10388	5254
10920	73	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 1	10388	5253
10921	85	49	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 1	10388	5256
10922	44	45	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 1	10388	5257
10923	84	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 1	10388	5275
10924	38	30	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 1	10388	5276
10925	38	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 1	10388	5258
10926	44	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 1	10388	5260
10927	68	34	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 1	10388	5261
10928	83	35	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 1	10388	5262
10929	23	33	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 1	10388	5265
10930	100	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 1	10388	5269
10931	76	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 1	10388	5277
10932	29	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 1	10388	5274
10933	76	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 0	10389	5253
10934	58	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 0	10389	5254
10935	20	36	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 0	10389	5256
10936	24	40	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 0	10389	5257
10937	65	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 0	10389	5258
10938	99	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 0	10389	5260
10939	58	40	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 0	10389	5261
10940	48	31	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 0	10389	5262
10941	54	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 0	10389	5275
10942	37	48	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 0	10389	5265
10943	46	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 0	10389	5269
10944	43	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 0	10389	5277
10945	21	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 0	10389	5274
10946	68	49	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 0	10389	5276
10947	82	30	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 1	10390	5256
10948	25	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 1	10390	5253
10949	42	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 1	10390	5254
10950	89	36	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 1	10390	5257
10951	26	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 1	10390	5258
10952	72	48	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 1	10390	5276
10953	61	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 1	10390	5277
10954	97	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 1	10390	5260
10955	85	50	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 1	10390	5261
10956	73	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 1	10390	5275
10957	79	46	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 1	10390	5262
10958	74	38	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 1	10390	5265
10959	59	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 1	10390	5269
10960	37	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 1	10390	5274
10961	73	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	10391	5251
10962	77	46	Poznámka k aktivitě Výskok s míčem. Osooba: Jan Selinger	10391	5280
10963	98	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: Jan Selinger	10391	5253
10964	99	44	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	10391	5268
10965	80	49	Poznámka k aktivitě Běh 1000 metrů. Osooba: Jan Selinger	10391	5271
10966	27	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	10391	5275
10967	81	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: Jan Selinger	10391	5254
10968	42	39	Poznámka k aktivitě Letmý start. Osooba: Jan Selinger	10391	5256
10969	82	38	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	10391	5267
10970	37	\N	Poznámka k aktivitě slalom. Osooba: Jan Selinger	10391	5269
10971	51	30	Poznámka k aktivitě Kliky. Osooba: Jan Selinger	10391	5266
10972	93	36	Poznámka k aktivitě Slalom s míčem. Osooba: Jan Selinger	10391	5276
10973	73	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	10391	5274
10974	27	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Jan Selinger	10391	5277
10975	87	30	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	10391	5279
10976	88	40	Poznámka k aktivitě Překážková dráha. Osooba: Jan Selinger	10391	5257
10977	49	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	10391	5258
10978	73	46	Poznámka k aktivitě Lowa brace test. Osooba: Jan Selinger	10391	5261
10979	52	41	Poznámka k aktivitě Žebřík. Osooba: Jan Selinger	10391	5262
10980	32	43	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	10391	5265
10981	62	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	10391	5263
10982	93	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	10391	5264
10983	84	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rous	10392	5251
10984	48	46	Poznámka k aktivitě Výskok s míčem. Osooba: Luděk Rous	10392	5280
10985	39	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: Luděk Rous	10392	5253
10986	34	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rous	10392	5274
10987	88	\N	Poznámka k aktivitě slalom. Osooba: Luděk Rous	10392	5269
10988	74	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rous	10392	5275
10989	76	42	Poznámka k aktivitě Slalom s míčem. Osooba: Luděk Rous	10392	5276
10990	98	37	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rous	10392	5265
10991	67	32	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rous	10392	5267
10992	68	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: Luděk Rous	10392	5254
10993	99	39	Poznámka k aktivitě Letmý start. Osooba: Luděk Rous	10392	5256
10994	36	43	Poznámka k aktivitě Překážková dráha. Osooba: Luděk Rous	10392	5257
10995	27	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rous	10392	5258
10996	78	49	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rous	10392	5268
10997	26	41	Poznámka k aktivitě Lowa brace test. Osooba: Luděk Rous	10392	5261
10998	24	49	Poznámka k aktivitě Žebřík. Osooba: Luděk Rous	10392	5262
10999	26	46	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rous	10392	5279
11000	31	34	Poznámka k aktivitě Kliky. Osooba: Luděk Rous	10392	5266
11001	95	31	Poznámka k aktivitě Běh 1000 metrů. Osooba: Luděk Rous	10392	5271
11002	38	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rous	10392	5263
11003	87	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rous	10392	5264
11004	58	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Luděk Rous	10392	5277
11005	50	37	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 0	10393	5257
11006	20	32	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 0	10393	5280
11007	77	36	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	10393	5268
11008	25	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	10393	5275
11009	37	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	10393	5251
11010	57	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 0	10393	5253
11011	92	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 0	10393	5254
11012	28	46	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 0	10393	5256
11013	96	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 0	10393	5269
11014	83	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	10393	5258
11015	92	31	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	10393	5267
11016	56	30	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 0	10393	5266
11017	80	49	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 0	10393	5276
11018	87	43	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 0	10393	5261
11019	33	42	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 0	10393	5271
11020	58	50	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 0	10393	5262
11021	32	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	10393	5274
11022	87	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	10393	5263
11023	25	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	10393	5264
11024	91	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 0	10393	5277
11025	72	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	10393	5279
11026	93	46	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	10393	5265
11027	67	44	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 1	10394	5280
11028	57	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 1	10394	5251
11029	22	46	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 1	10394	5266
11030	72	34	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 1	10394	5265
11031	33	42	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 1	10394	5268
11032	88	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 1	10394	5253
11033	28	47	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 1	10394	5267
11034	87	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 1	10394	5269
11035	24	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 1	10394	5254
11036	43	44	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 1	10394	5276
11037	59	50	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 1	10394	5256
11038	71	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 1	10394	5274
11039	52	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 1	10394	5277
11040	90	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 1	10394	5275
11041	99	36	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 1	10394	5257
11042	21	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 1	10394	5258
11043	54	50	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 1	10394	5261
11044	97	43	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 1	10394	5262
11045	27	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 1	10394	5263
11046	100	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 1	10394	5279
11047	25	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 1	10394	5264
11048	63	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 6 let úroveň 1	10394	5271
11049	82	35	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 0	10395	5261
11050	85	39	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 0	10395	5280
11051	83	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	10395	5251
11052	39	50	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	10395	5265
11053	38	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 0	10395	5253
11054	56	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 0	10395	5254
11055	47	30	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	10395	5267
11056	76	36	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 0	10395	5256
11057	65	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	10395	5279
11058	84	49	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 0	10395	5257
11059	74	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	10395	5258
11060	38	50	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 0	10395	5262
11061	94	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 0	10395	5271
11062	77	44	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 0	10395	5276
11063	98	46	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 0	10395	5266
11064	41	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	10395	5274
11065	30	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 0	10395	5269
11066	55	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	10395	5263
11067	62	35	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	10395	5268
11068	25	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	10395	5275
11069	75	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	10395	5264
11070	44	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 0	10395	5277
11071	84	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 1	10396	5253
11072	53	30	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 1	10396	5280
11073	70	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 1	10396	5275
11074	77	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 1	10396	5251
11075	32	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 1	10396	5254
11076	58	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 1	10396	5269
11077	60	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 1	10396	5274
11078	27	37	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 1	10396	5268
11079	67	36	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 1	10396	5256
11080	27	40	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 1	10396	5265
11081	68	30	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 1	10396	5267
11082	34	44	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 1	10396	5257
11083	80	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 1	10396	5258
11084	91	32	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 1	10396	5261
11085	96	48	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 1	10396	5266
11086	92	47	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 1	10396	5276
11087	100	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 1	10396	5279
11088	20	34	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 1	10396	5262
11089	68	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: 7 let úroveň 1	10396	5271
11090	54	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 1	10396	5263
11091	41	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 1	10396	5264
11092	37	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 1	10396	5277
11093	89	50	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 0	10397	5261
11094	76	50	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 0	10397	5280
11095	63	40	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 0	10397	5276
11096	85	31	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	10397	5268
11097	44	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	10397	5251
11098	35	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 0	10397	5253
11099	90	46	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 0	10397	5266
11100	35	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 0	10397	5271
11101	98	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 0	10397	5254
11102	90	40	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 0	10397	5256
11103	36	39	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 0	10397	5257
11104	74	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	10397	5258
11105	53	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	10397	5279
11106	85	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	10397	5275
11107	74	41	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 0	10397	5262
11108	69	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	10397	5263
11109	82	44	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	10397	5267
11110	97	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 0	10397	5269
11111	85	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	10397	5274
11112	21	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 0	10397	5277
11113	53	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	10397	5264
11114	100	47	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	10397	5265
11115	55	38	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 1	10398	5257
11116	86	43	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 1	10398	5280
11117	62	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 1	10398	5251
11118	69	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 1	10398	5253
11119	60	40	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 1	10398	5266
11120	71	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 1	10398	5279
11121	70	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 1	10398	5275
11122	96	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 1	10398	5277
11123	51	40	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 1	10398	5276
11124	26	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 1	10398	5254
11125	67	30	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 1	10398	5256
11126	36	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 1	10398	5258
11127	87	50	Poznámka k aktivitě Běh 1000 metrů. Osooba: 8 let úroveň 1	10398	5271
11128	57	30	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 1	10398	5267
11129	65	50	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 1	10398	5268
11130	61	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 1	10398	5269
11131	25	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 1	10398	5274
11132	55	34	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 1	10398	5261
11133	42	46	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 1	10398	5265
11134	61	36	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 1	10398	5262
11135	96	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 1	10398	5263
11136	74	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 1	10398	5264
11137	98	35	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 0	10399	5256
11138	76	50	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 0	10399	5280
11139	63	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 0	10399	5251
11140	29	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 0	10399	5253
11141	50	39	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 0	10399	5267
11142	61	43	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 0	10399	5266
11143	43	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 0	10399	5279
11144	85	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 0	10399	5254
11145	51	43	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 0	10399	5257
11146	41	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 0	10399	5258
11147	75	31	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 0	10399	5265
11148	68	32	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 0	10399	5261
11149	42	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 0	10399	5275
11150	20	50	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 0	10399	5268
11151	94	44	Poznámka k aktivitě Běh 1000 metrů. Osooba: 9 let úroveň 0	10399	5271
11152	95	32	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 0	10399	5276
11153	37	30	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 0	10399	5262
11154	50	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 0	10399	5269
11155	62	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 0	10399	5263
11156	38	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 0	10399	5264
11157	90	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 0	10399	5274
11158	32	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 0	10399	5277
11159	86	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 1	10400	5254
11160	32	43	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 1	10400	5280
11161	43	40	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 1	10400	5265
11162	100	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 1	10400	5275
11163	43	45	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 1	10400	5266
11164	35	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 1	10400	5251
11165	29	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 1	10400	5253
11166	79	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 1	10400	5274
11167	80	50	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 1	10400	5256
11168	93	46	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 1	10400	5257
11169	68	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 1	10400	5258
11170	51	30	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 1	10400	5261
11171	76	50	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 1	10400	5268
11172	31	46	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 1	10400	5262
11173	74	30	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 1	10400	5267
11174	50	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 1	10400	5269
11175	68	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 1	10400	5279
11176	82	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 1	10400	5263
11177	28	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 1	10400	5264
11178	55	39	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 1	10400	5276
11179	58	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 9 let úroveň 1	10400	5271
11180	69	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 1	10400	5277
11181	44	39	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 0	11251	5256
11182	25	31	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 0	11251	5280
11183	87	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 0	11251	5251
11184	51	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 0	11251	5253
11185	72	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 0	11251	5254
11186	68	43	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 0	11251	5265
11187	22	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 0	11251	5269
11188	89	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 0	11251	5277
11189	35	33	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 0	11251	5257
11190	51	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 0	11251	5258
11191	89	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 0	11251	5279
11192	51	32	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 0	11251	5261
11193	21	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 0	11251	5274
11194	95	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 0	11251	5275
11195	36	49	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 0	11251	5266
11196	29	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 10 let úroveň 0	11251	5271
11197	74	34	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 0	11251	5276
11198	49	33	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 0	11251	5267
11199	78	47	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 0	11251	5262
11200	30	32	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 0	11251	5268
11301	49	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 0	11251	5263
11302	31	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 0	11251	5264
11303	30	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 1	11252	5258
11304	28	32	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 1	11252	5280
11305	30	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 1	11252	5251
11306	29	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 1	11252	5275
11307	55	38	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 1	11252	5265
11308	42	40	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 1	11252	5266
11309	78	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 1	11252	5253
11310	22	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 1	11252	5274
11311	47	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 1	11252	5254
11312	21	50	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 1	11252	5256
11313	28	49	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 1	11252	5257
11314	60	34	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 1	11252	5261
11315	23	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 1	11252	5277
11316	97	37	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 1	11252	5262
11317	76	32	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 1	11252	5267
11318	24	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 1	11252	5279
11319	60	40	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 1	11252	5276
11320	34	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 1	11252	5263
11321	98	47	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 1	11252	5268
11322	89	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 1	11252	5264
11323	98	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 10 let úroveň 1	11252	5271
11324	39	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 1	11252	5269
11325	23	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 0	11253	5251
11326	98	36	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 0	11253	5280
11327	71	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 0	11253	5253
11328	93	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 0	11253	5277
11329	37	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 0	11253	5269
11330	20	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 0	11253	5275
11331	82	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 0	11253	5254
11332	91	47	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 0	11253	5256
11333	27	38	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 0	11253	5257
11334	52	50	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 0	11253	5265
11335	99	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 0	11253	5279
11336	30	38	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 0	11253	5276
11337	59	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 0	11253	5274
11338	52	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 0	11253	5258
11339	85	43	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 0	11253	5268
11340	47	30	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 0	11253	5261
11341	67	40	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 0	11253	5262
11342	90	48	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 0	11253	5266
11343	24	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 0	11253	5263
11344	69	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 0	11253	5264
11345	93	40	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 0	11253	5267
11346	69	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 11 let úroveň 0	11253	5271
11347	61	47	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 1	11254	5261
11348	97	41	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 1	11254	5280
11349	21	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 1	11254	5251
11350	21	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 1	11254	5253
11351	65	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 1	11254	5254
11352	42	39	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 1	11254	5256
11353	72	31	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 1	11254	5265
11354	37	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 1	11254	5279
11355	62	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 1	11254	5269
11356	25	37	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 1	11254	5267
11357	100	48	Poznámka k aktivitě Běh 1000 metrů. Osooba: 11 let úroveň 1	11254	5271
11358	64	35	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 1	11254	5276
11359	97	33	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 1	11254	5268
11360	38	36	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 1	11254	5266
11361	43	36	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 1	11254	5257
11362	31	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 1	11254	5277
11363	76	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 1	11254	5258
11364	81	43	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 1	11254	5262
11365	46	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 1	11254	5274
11366	88	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 1	11254	5263
11367	46	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 1	11254	5275
11368	49	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 1	11254	5264
11369	33	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 0	11255	5253
11370	76	33	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 0	11255	5280
11371	37	38	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 0	11255	5266
11372	36	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 0	11255	5251
11373	22	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 0	11255	5254
11374	38	43	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 0	11255	5268
11375	73	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 0	11255	5274
11376	88	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 0	11255	5277
11377	64	39	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 0	11255	5256
11378	94	30	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 0	11255	5257
11379	38	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 0	11255	5258
11380	26	36	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 0	11255	5261
11381	21	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 0	11255	5279
11382	32	33	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 0	11255	5262
11383	40	33	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 0	11255	5265
11384	48	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 0	11255	5263
11385	20	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 12 let úroveň 0	11255	5271
11386	97	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 0	11255	5275
11387	85	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 0	11255	5269
11388	95	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 0	11255	5264
11389	91	44	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 0	11255	5267
11390	79	48	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 0	11255	5276
11391	31	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 1	11256	5254
11392	90	43	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 1	11256	5280
11393	83	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 1	11256	5251
11394	40	37	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 1	11256	5268
11395	97	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 1	11256	5275
11396	71	50	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 1	11256	5276
11397	43	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 1	11256	5253
11398	80	36	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 1	11256	5256
11399	79	33	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 1	11256	5266
11400	97	47	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 1	11256	5257
11401	35	44	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 1	11256	5265
11402	91	30	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 1	11256	5267
11403	91	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 1	11256	5258
11404	94	47	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 1	11256	5261
11405	70	43	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 1	11256	5262
11406	88	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 1	11256	5274
11407	91	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 12 let úroveň 1	11256	5271
11408	64	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 1	11256	5279
11409	78	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 1	11256	5263
11410	38	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 1	11256	5264
11411	36	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 1	11256	5269
11412	34	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 1	11256	5277
11413	93	30	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 0	11257	5280
11414	37	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 0	11257	5251
11415	37	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 0	11257	5253
11416	41	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 0	11257	5269
11417	76	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 0	11257	5254
11418	86	30	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 0	11257	5256
11419	91	34	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 0	11257	5257
11420	31	46	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 0	11257	5266
11421	48	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 0	11257	5258
11422	50	46	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 0	11257	5261
11423	21	30	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 0	11257	5265
11424	84	38	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 0	11257	5268
11425	76	32	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 0	11257	5262
11426	52	37	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 0	11257	5267
11427	60	31	Poznámka k aktivitě Běh 1000 metrů. Osooba: 13 let úroveň 0	11257	5271
11428	20	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 0	11257	5277
11429	68	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 0	11257	5263
11430	54	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 0	11257	5275
11431	34	37	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 0	11257	5276
11432	70	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 0	11257	5279
11433	85	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 0	11257	5274
11434	65	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 0	11257	5264
11435	34	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 1	11258	5253
11436	58	37	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 1	11258	5280
11437	87	36	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 1	11258	5268
11438	29	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 1	11258	5277
11439	92	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 1	11258	5269
11440	99	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 1	11258	5275
11441	88	37	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 1	11258	5267
11442	84	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 1	11258	5279
11443	73	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 1	11258	5274
11444	86	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 1	11258	5251
11445	62	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 1	11258	5254
11446	33	32	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 1	11258	5256
11447	74	30	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 1	11258	5257
11448	53	46	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 1	11258	5276
11449	82	36	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 1	11258	5266
11450	59	50	Poznámka k aktivitě Běh 1000 metrů. Osooba: 13 let úroveň 1	11258	5271
11451	69	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 1	11258	5258
11452	47	45	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 1	11258	5261
11453	64	30	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 1	11258	5265
11454	20	39	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 1	11258	5262
11455	60	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 1	11258	5263
11456	86	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 1	11258	5264
11457	25	37	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 0	11259	5261
11458	31	34	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 0	11259	5280
11459	46	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 0	11259	5251
11460	93	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 0	11259	5277
11461	59	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 0	11259	5253
11462	35	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 0	11259	5254
11463	70	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 0	11259	5274
11464	43	44	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 0	11259	5256
11465	24	42	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 0	11259	5257
11466	34	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 0	11259	5258
11467	67	47	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 0	11259	5268
11468	90	30	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 0	11259	5276
11469	69	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 0	11259	5269
11470	92	34	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 0	11259	5266
11471	32	45	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 0	11259	5262
11472	43	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 0	11259	5279
11473	40	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: 14 let úroveň 0	11259	5271
11474	87	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 0	11259	5263
11475	28	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 0	11259	5264
11476	99	40	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 0	11259	5265
11477	32	40	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 0	11259	5267
11478	61	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 0	11259	5275
11479	74	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 1	11260	5251
11480	39	30	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 1	11260	5280
11481	66	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 1	11260	5253
11482	98	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 1	11260	5254
11483	31	42	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 1	11260	5256
11484	87	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 1	11260	5279
11485	35	31	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 1	11260	5257
11486	76	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 1	11260	5258
11487	95	36	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 1	11260	5267
11488	75	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 14 let úroveň 1	11260	5271
11489	38	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 1	11260	5275
11490	47	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 1	11260	5274
11491	66	32	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 1	11260	5266
11492	82	45	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 1	11260	5261
11493	58	31	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 1	11260	5262
11494	97	41	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 1	11260	5265
11495	52	36	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 1	11260	5268
11496	77	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 1	11260	5263
11497	90	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 1	11260	5277
11498	41	50	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 1	11260	5276
11499	58	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 1	11260	5264
11500	59	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 1	11260	5269
11501	35	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 0	11261	5253
11502	82	50	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 0	11261	5280
11503	49	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 0	11261	5275
11504	51	41	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 0	11261	5266
11505	38	40	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 0	11261	5268
11506	98	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 0	11261	5251
11507	36	45	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 0	11261	5267
11508	88	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 0	11261	5277
11509	57	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 0	11261	5254
11510	82	35	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 0	11261	5256
11511	59	34	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 0	11261	5257
11512	100	43	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 0	11261	5276
11513	66	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 0	11261	5279
11514	39	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 0	11261	5258
11515	49	49	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 0	11261	5261
11516	25	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 0	11261	5274
11517	57	32	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 0	11261	5265
11518	76	45	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 0	11261	5262
11519	60	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 0	11261	5263
11520	47	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 15 let úroveň 0	11261	5271
11521	64	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 0	11261	5269
11522	72	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 0	11261	5264
11523	67	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 1	11262	5254
11524	26	33	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 1	11262	5280
11525	76	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 1	11262	5251
11526	22	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 1	11262	5253
11527	53	39	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 1	11262	5265
11528	57	30	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 1	11262	5256
11529	66	38	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 1	11262	5257
11530	64	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 1	11262	5258
11531	84	49	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 1	11262	5261
11532	50	34	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 1	11262	5262
11533	83	31	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 1	11262	5276
11534	54	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 1	11262	5269
11535	81	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 1	11262	5279
11536	68	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 15 let úroveň 1	11262	5271
11537	46	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 1	11262	5263
11538	55	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 1	11262	5277
11539	100	36	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 1	11262	5268
11540	46	32	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 1	11262	5266
11541	95	43	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 1	11262	5267
11542	60	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 1	11262	5274
11543	75	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 1	11262	5275
11544	71	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 1	11262	5264
11545	30	38	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 0	11263	5261
11546	81	45	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 0	11263	5280
11547	54	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 0	11263	5275
11548	92	33	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 0	11263	5276
11549	89	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 0	11263	5251
11550	79	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 0	11263	5253
11551	89	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 0	11263	5254
11552	49	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 0	11263	5277
11553	31	44	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 0	11263	5256
11554	67	50	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 0	11263	5257
11555	59	30	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 0	11263	5265
11556	46	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 0	11263	5279
11557	92	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 0	11263	5258
11558	22	31	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 0	11263	5268
11559	49	37	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 0	11263	5262
11560	98	45	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 0	11263	5266
11561	29	32	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 0	11263	5267
11562	29	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 16 let úroveň 0	11263	5271
11563	38	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 0	11263	5263
11564	79	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 0	11263	5264
11565	49	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 0	11263	5269
11566	24	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 0	11263	5274
11567	94	41	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 1	11264	5257
11568	70	36	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 1	11264	5280
11569	61	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 1	11264	5251
11570	67	48	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 1	11264	5267
11571	77	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 1	11264	5253
11572	44	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 1	11264	5254
11573	85	36	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 1	11264	5256
11574	33	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 1	11264	5279
11575	63	31	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 1	11264	5268
11576	29	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 1	11264	5258
11577	48	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 1	11264	5277
11578	62	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 1	11264	5275
11579	69	42	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 1	11264	5261
11580	35	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 1	11264	5274
11581	59	38	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 1	11264	5262
11582	67	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 1	11264	5263
11583	40	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 1	11264	5269
11584	24	36	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 1	11264	5265
11585	41	50	Poznámka k aktivitě Běh 1000 metrů. Osooba: 16 let úroveň 1	11264	5271
11586	34	42	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 1	11264	5276
11587	65	38	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 1	11264	5266
11588	83	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 1	11264	5264
11589	35	48	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 0	11265	5256
11590	70	46	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 0	11265	5280
11591	50	50	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 0	11265	5266
11592	78	47	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 0	11265	5268
11593	39	30	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 0	11265	5267
11594	87	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 0	11265	5251
11595	42	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 0	11265	5253
11596	66	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 0	11265	5254
11597	93	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 17 let úroveň 0	11265	5271
11598	54	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 0	11265	5279
11599	29	38	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 0	11265	5257
11600	35	33	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 0	11265	5276
11601	46	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 0	11265	5258
11602	76	42	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 0	11265	5265
11603	43	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 0	11265	5277
11604	58	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 0	11265	5274
11605	45	30	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 0	11265	5261
11606	50	30	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 0	11265	5262
11607	32	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 0	11265	5263
11608	20	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 0	11265	5264
11609	59	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 0	11265	5275
11610	93	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 0	11265	5269
11611	35	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 1	11266	5253
11612	27	42	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 1	11266	5280
11613	48	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 17 let úroveň 1	11266	5271
11614	45	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 1	11266	5269
11615	30	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 1	11266	5251
11616	88	36	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 1	11266	5266
11617	78	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 1	11266	5275
11618	77	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 1	11266	5254
11619	64	42	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 1	11266	5265
11620	34	48	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 1	11266	5267
11621	32	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 1	11266	5274
11622	35	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 1	11266	5279
11623	36	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 1	11266	5277
11624	27	41	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 1	11266	5256
11625	38	39	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 1	11266	5268
11626	72	31	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 1	11266	5257
11627	21	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 1	11266	5258
11628	70	40	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 1	11266	5261
11629	26	35	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 1	11266	5262
11630	60	43	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 1	11266	5276
11631	56	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 1	11266	5263
11632	99	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 1	11266	5264
11633	47	42	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 0	11267	5280
11634	77	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 0	11267	5251
11635	20	30	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 0	11267	5265
11636	27	50	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 0	11267	5266
11637	79	37	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 0	11267	5268
11638	34	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 0	11267	5279
11639	38	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 0	11267	5253
11640	98	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 0	11267	5254
11641	55	46	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 0	11267	5276
11642	82	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 0	11267	5277
11643	59	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 0	11267	5274
11644	56	30	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 0	11267	5256
11645	64	48	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 0	11267	5257
11646	27	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 0	11267	5258
11647	69	42	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 0	11267	5261
11648	82	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: 18 let úroveň 0	11267	5271
11649	78	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 0	11267	5275
11650	25	43	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 0	11267	5262
11651	21	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 0	11267	5263
11652	96	33	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 0	11267	5267
11653	58	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 0	11267	5264
11654	56	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 0	11267	5269
11655	45	40	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 1	11268	5280
11656	61	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 1	11268	5251
11657	44	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 1	11268	5253
11658	43	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 1	11268	5254
11659	24	35	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 1	11268	5256
11660	78	45	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 1	11268	5257
11661	94	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 1	11268	5258
11662	61	40	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 1	11268	5267
11663	37	30	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 1	11268	5268
11664	35	33	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 1	11268	5266
11665	78	31	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 1	11268	5261
11666	90	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 1	11268	5275
11667	48	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 18 let úroveň 1	11268	5271
11668	88	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 1	11268	5274
11669	53	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 1	11268	5277
11670	23	39	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 1	11268	5262
11671	91	33	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 1	11268	5276
11672	70	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 1	11268	5263
11673	24	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 1	11268	5269
11674	76	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 1	11268	5279
11675	99	42	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 1	11268	5265
11676	26	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 1	11268	5264
11677	93	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 0	11269	5253
11678	27	47	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 0	11269	5280
11679	73	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 0	11269	5251
11680	55	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 0	11269	5254
11681	48	39	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 0	11269	5266
11682	90	44	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 0	11269	5256
11683	56	44	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 0	11269	5257
11684	87	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 0	11269	5258
11685	43	37	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 0	11269	5261
11686	73	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 0	11269	5269
11687	47	37	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 0	11269	5267
11688	24	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 0	11269	5274
11689	33	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 0	11269	5277
11690	23	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 0	11269	5279
11691	90	37	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 0	11269	5262
11692	24	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 0	11269	5263
11693	83	31	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 0	11269	5268
11694	92	44	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 0	11269	5276
11695	35	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 0	11269	5264
11696	96	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 19 let úroveň 0	11269	5271
11697	57	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 0	11269	5275
11698	71	31	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 0	11269	5265
11699	61	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 1	11270	5251
11700	78	50	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 1	11270	5280
11701	34	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 1	11270	5253
11702	62	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 1	11270	5254
11703	28	50	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 1	11270	5256
11704	23	47	Poznámka k aktivitě Běh 1000 metrů. Osooba: 19 let úroveň 1	11270	5271
11705	42	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 1	11270	5275
11706	90	42	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 1	11270	5257
11707	67	45	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 1	11270	5268
11708	21	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 1	11270	5258
11709	35	34	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 1	11270	5261
11710	76	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 1	11270	5274
11711	62	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 1	11270	5269
11712	58	34	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 1	11270	5262
11713	27	43	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 1	11270	5267
11714	76	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 1	11270	5277
11715	53	37	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 1	11270	5266
11716	63	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 1	11270	5263
11717	90	39	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 1	11270	5276
11718	59	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 1	11270	5279
11719	50	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 1	11270	5264
11720	50	42	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 1	11270	5265
11721	97	39	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 0	11271	5280
11722	86	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 0	11271	5251
11723	88	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 0	11271	5253
11724	63	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 0	11271	5254
11725	99	46	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 0	11271	5268
11726	84	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 0	11271	5274
11727	34	30	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 0	11271	5256
11728	82	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: 20 let úroveň 0	11271	5271
11729	100	32	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 0	11271	5257
11730	94	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 0	11271	5275
11731	71	43	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 0	11271	5265
11732	87	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 0	11271	5269
11733	54	38	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 0	11271	5267
11734	25	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 0	11271	5258
11735	56	34	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 0	11271	5276
11736	75	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 0	11271	5279
11737	57	36	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 0	11271	5261
11738	44	47	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 0	11271	5266
11739	80	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 0	11271	5277
11740	80	32	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 0	11271	5262
11741	63	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 0	11271	5263
11742	23	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 0	11271	5264
11743	57	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 1	11272	5253
11744	20	31	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 1	11272	5280
11745	27	38	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 1	11272	5265
11746	71	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 1	11272	5251
11747	74	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 1	11272	5254
11748	69	33	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 1	11272	5256
11749	29	45	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 1	11272	5267
11750	86	34	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 1	11272	5257
11751	84	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 1	11272	5269
11752	69	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 1	11272	5277
11753	30	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 1	11272	5258
11754	56	30	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 1	11272	5261
11755	27	30	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 1	11272	5266
11756	94	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 1	11272	5279
11757	56	38	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 1	11272	5262
11758	62	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 1	11272	5263
11759	57	47	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 1	11272	5268
11760	74	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 1	11272	5275
11761	42	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 1	11272	5274
11762	51	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 1	11272	5264
11763	90	47	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 1	11272	5276
11764	100	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 20 let úroveň 1	11272	5271
11765	50	42	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 0	11273	5262
11766	21	38	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 0	11273	5280
11767	85	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 0	11273	5251
11768	39	37	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 0	11273	5265
11769	40	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 0	11273	5253
11770	35	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 0	11273	5254
11771	52	43	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 0	11273	5256
11772	71	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 0	11273	5277
11773	47	33	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 0	11273	5257
11774	44	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 0	11273	5258
11775	22	37	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 0	11273	5268
11776	83	42	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 0	11273	5266
11777	24	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 0	11273	5279
11778	96	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 0	11273	5275
11779	59	50	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 0	11273	5261
11780	22	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 0	11273	5263
11781	22	31	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 0	11273	5267
11782	98	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 0	11273	5269
11783	86	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 0	11273	5274
11784	38	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 0	11273	5264
11785	94	43	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 0	11273	5276
11786	55	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 21 let úroveň 0	11273	5271
11787	96	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 1	11274	5258
11788	55	30	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 1	11274	5280
11789	34	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 1	11274	5275
11790	89	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 1	11274	5251
11791	66	42	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 1	11274	5265
11792	54	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 1	11274	5253
11793	56	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 1	11274	5254
11794	47	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 1	11274	5274
11795	88	31	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 1	11274	5267
11796	86	31	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 1	11274	5276
11797	84	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 1	11274	5269
11798	60	49	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 1	11274	5256
11799	49	46	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 1	11274	5257
11800	43	39	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 1	11274	5261
11801	48	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 21 let úroveň 1	11274	5271
11802	81	32	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 1	11274	5268
11803	53	46	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 1	11274	5262
11804	57	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 1	11274	5263
11805	66	42	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 1	11274	5266
11806	62	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 1	11274	5279
11807	41	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 1	11274	5277
11808	80	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 1	11274	5264
11809	69	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 0	11275	5258
11810	56	46	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 0	11275	5280
11811	51	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 0	11275	5251
11812	23	33	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 0	11275	5267
11813	77	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 0	11275	5269
11814	59	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 0	11275	5253
11815	29	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 0	11275	5254
11816	43	46	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 0	11275	5256
11817	85	34	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 0	11275	5266
11818	46	44	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 0	11275	5276
11819	55	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 0	11275	5279
11820	93	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 0	11275	5277
11821	35	50	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 0	11275	5257
11822	53	41	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 0	11275	5265
11823	52	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 0	11275	5274
11824	72	40	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 0	11275	5261
11825	35	42	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 0	11275	5262
11826	33	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 0	11275	5263
11827	57	35	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 0	11275	5268
11828	75	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 0	11275	5264
11829	39	48	Poznámka k aktivitě Běh 1000 metrů. Osooba: 22 let úroveň 0	11275	5271
11830	58	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 0	11275	5275
11831	21	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 1	11276	5258
11832	37	44	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 1	11276	5280
11833	37	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 1	11276	5277
11834	81	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 1	11276	5279
11835	42	34	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 1	11276	5265
11836	64	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 1	11276	5251
11837	89	34	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 1	11276	5267
11838	62	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 1	11276	5275
11839	98	40	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 1	11276	5276
11840	55	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 1	11276	5253
11841	26	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 1	11276	5254
11842	73	30	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 1	11276	5256
11843	79	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 1	11276	5269
11844	23	34	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 1	11276	5257
11845	34	42	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 1	11276	5266
11846	76	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: 22 let úroveň 1	11276	5271
11847	46	30	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 1	11276	5261
11848	93	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 1	11276	5274
11849	70	46	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 1	11276	5262
11850	55	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 1	11276	5263
11851	20	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 1	11276	5264
11852	81	35	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 1	11276	5268
11853	82	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 0	11277	5251
11854	76	38	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 0	11277	5280
11855	77	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 0	11277	5253
11856	90	39	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 0	11277	5265
11857	77	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 0	11277	5279
11858	84	39	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 0	11277	5268
11859	35	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 23 let úroveň 0	11277	5271
11860	94	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 0	11277	5254
11861	86	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 0	11277	5274
11862	62	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 0	11277	5269
11863	66	44	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 0	11277	5256
11864	35	42	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 0	11277	5257
11865	44	50	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 0	11277	5276
11866	69	47	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 0	11277	5266
11867	30	32	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 0	11277	5267
11868	28	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 0	11277	5258
11869	80	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 0	11277	5277
11870	39	46	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 0	11277	5261
11871	62	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 0	11277	5275
11872	93	34	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 0	11277	5262
11873	48	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 0	11277	5263
11874	98	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 0	11277	5264
11875	62	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 1	11278	5251
11876	70	50	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 1	11278	5280
11877	53	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 1	11278	5253
11878	93	38	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 1	11278	5267
11879	32	30	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 1	11278	5268
11880	44	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 1	11278	5254
11881	22	30	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 1	11278	5256
11882	56	44	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 1	11278	5257
11883	76	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 1	11278	5279
11884	66	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 1	11278	5277
11885	44	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 1	11278	5275
11886	82	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 1	11278	5258
11887	91	34	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 1	11278	5261
11888	93	33	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 1	11278	5276
11889	95	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 1	11278	5274
11890	67	38	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 1	11278	5262
11891	55	45	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 1	11278	5265
11892	35	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 1	11278	5263
11893	24	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 23 let úroveň 1	11278	5271
11894	73	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 1	11278	5264
11895	81	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 1	11278	5269
11896	99	38	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 1	11278	5266
11897	28	42	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 0	11279	5280
11898	83	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 0	11279	5251
11899	33	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 0	11279	5253
11900	94	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 24 let úroveň 0	11279	5271
11901	46	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 0	11279	5254
11902	43	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 0	11279	5275
11903	96	46	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 0	11279	5256
11904	46	41	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 0	11279	5267
11905	39	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 0	11279	5277
11906	46	42	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 0	11279	5257
11907	55	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 0	11279	5258
11908	58	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 0	11279	5274
11909	34	32	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 0	11279	5261
11910	70	45	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 0	11279	5268
11911	97	46	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 0	11279	5262
11912	97	40	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 0	11279	5265
11913	76	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 0	11279	5279
11914	94	32	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 0	11279	5266
11915	73	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 0	11279	5263
11916	96	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 0	11279	5264
11917	75	49	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 0	11279	5276
11918	57	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 0	11279	5269
11919	58	42	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 1	11280	5280
11920	46	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 1	11280	5251
11921	42	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 1	11280	5253
11922	69	50	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 1	11280	5267
11923	64	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 1	11280	5254
11924	29	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 24 let úroveň 1	11280	5271
11925	74	49	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 1	11280	5256
11926	81	46	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 1	11280	5268
11927	25	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 1	11280	5274
11928	96	47	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 1	11280	5265
11929	58	45	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 1	11280	5266
11930	73	45	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 1	11280	5257
11931	66	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 1	11280	5269
11932	75	42	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 1	11280	5276
11933	54	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 1	11280	5277
11934	86	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 1	11280	5258
11935	46	30	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 1	11280	5261
11936	65	43	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 1	11280	5262
11937	28	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 1	11280	5263
11938	94	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 1	11280	5264
11939	37	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 1	11280	5275
11940	43	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 1	11280	5279
11941	87	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 0	11281	5253
11942	76	39	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 0	11281	5280
11943	49	48	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 0	11281	5265
11944	21	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 0	11281	5274
11945	36	31	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 0	11281	5276
11946	99	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 0	11281	5269
11947	61	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 0	11281	5251
11948	77	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 0	11281	5254
11949	91	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 25 let úroveň 0	11281	5271
11950	31	50	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 0	11281	5256
11951	94	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 0	11281	5275
11952	87	30	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 0	11281	5257
11953	99	32	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 0	11281	5266
11954	63	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 0	11281	5258
11955	76	48	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 0	11281	5261
11956	67	37	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 0	11281	5268
11957	88	32	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 0	11281	5262
11958	31	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 0	11281	5279
11959	41	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 0	11281	5263
11960	26	48	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 0	11281	5267
11961	22	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 0	11281	5277
11962	52	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 0	11281	5264
11963	25	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 1	11282	5258
11964	72	43	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 1	11282	5280
11965	71	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 1	11282	5251
11966	98	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 1	11282	5253
11967	50	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 1	11282	5254
11968	46	33	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 1	11282	5256
11969	90	45	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 1	11282	5267
11970	94	39	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 1	11282	5268
11971	35	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 1	11282	5277
11972	45	44	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 1	11282	5276
11973	93	42	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 1	11282	5257
11974	63	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 1	11282	5274
11975	67	43	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 1	11282	5266
11976	50	49	Poznámka k aktivitě Běh 1000 metrů. Osooba: 25 let úroveň 1	11282	5271
11977	77	35	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 1	11282	5261
11978	44	45	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 1	11282	5262
11979	67	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 1	11282	5263
11980	97	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 1	11282	5269
11981	67	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 1	11282	5275
11982	65	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 1	11282	5264
11983	46	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 1	11282	5279
11984	83	49	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 1	11282	5265
11985	100	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 0	11283	5251
11986	89	44	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 0	11283	5280
11987	78	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 0	11283	5253
11988	64	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 0	11283	5254
11989	50	50	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 0	11283	5256
11990	95	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 0	11283	5277
11991	44	40	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 0	11283	5257
11992	96	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 0	11283	5269
11993	30	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 0	11283	5275
11994	99	47	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 0	11283	5276
11995	68	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 0	11283	5258
11996	58	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 0	11283	5279
11997	21	37	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 0	11283	5261
11998	23	47	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 0	11283	5262
11999	33	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 0	11283	5274
12000	32	42	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 0	11283	5268
12001	41	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 26 let úroveň 0	11283	5271
12002	84	34	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 0	11283	5267
12003	82	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 0	11283	5263
12004	53	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 0	11283	5264
12005	84	44	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 0	11283	5266
12006	89	41	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 0	11283	5265
12007	75	41	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 1	11284	5280
12008	30	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 1	11284	5251
12009	55	48	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 1	11284	5265
12010	32	35	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 1	11284	5276
12011	86	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 1	11284	5279
12012	82	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 1	11284	5253
12013	70	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 1	11284	5254
12014	54	47	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 1	11284	5256
12015	62	39	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 1	11284	5257
12016	21	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 1	11284	5258
12017	68	31	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 1	11284	5261
12018	53	49	Poznámka k aktivitě Běh 1000 metrů. Osooba: 26 let úroveň 1	11284	5271
12019	93	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 1	11284	5277
12020	29	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 1	11284	5274
12021	89	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 1	11284	5275
12022	89	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 1	11284	5269
12023	21	50	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 1	11284	5262
12024	82	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 1	11284	5263
12025	71	42	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 1	11284	5266
12026	92	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 1	11284	5264
12027	45	37	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 1	11284	5267
12028	41	45	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 1	11284	5268
12029	29	34	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 0	11285	5280
12030	94	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 0	11285	5251
12031	79	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 0	11285	5269
12032	98	34	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 0	11285	5276
12033	66	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 0	11285	5253
12034	53	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 0	11285	5274
12035	71	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 0	11285	5277
12036	85	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 0	11285	5254
12037	98	44	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 0	11285	5268
12038	61	32	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 0	11285	5256
12039	63	33	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 0	11285	5257
12040	48	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 0	11285	5258
12041	97	43	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 0	11285	5261
12042	39	35	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 0	11285	5262
12043	36	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 27 let úroveň 0	11285	5271
12044	40	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 0	11285	5263
12045	21	46	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 0	11285	5265
12046	80	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 0	11285	5279
12047	99	50	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 0	11285	5267
12048	37	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 0	11285	5264
12049	43	43	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 0	11285	5266
12050	27	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 0	11285	5275
12051	82	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 1	11286	5251
12052	75	41	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 1	11286	5280
12053	52	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 1	11286	5253
12054	54	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 1	11286	5269
12055	82	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 1	11286	5277
12056	54	38	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 1	11286	5267
12057	82	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 1	11286	5275
12058	91	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 1	11286	5274
12059	51	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 1	11286	5254
12060	65	36	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 1	11286	5276
12061	30	49	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 1	11286	5256
12062	76	46	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 1	11286	5257
12063	50	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 1	11286	5258
12064	47	43	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 1	11286	5261
12065	49	43	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 1	11286	5268
12066	76	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 1	11286	5279
12067	45	46	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 1	11286	5262
12068	46	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 1	11286	5263
12069	51	31	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 1	11286	5266
12070	61	49	Poznámka k aktivitě Běh 1000 metrů. Osooba: 27 let úroveň 1	11286	5271
12071	24	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 1	11286	5264
12072	37	41	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 1	11286	5265
12073	87	44	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 0	11287	5280
12074	55	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 0	11287	5251
12075	84	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 0	11287	5253
12076	69	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 0	11287	5254
12077	77	43	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 0	11287	5256
12078	63	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 0	11287	5269
12079	84	49	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 0	11287	5257
12080	30	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 0	11287	5258
12081	99	42	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 0	11287	5276
12082	42	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 0	11287	5277
12083	77	46	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 0	11287	5261
12084	87	44	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 0	11287	5268
12085	59	43	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 0	11287	5262
12086	95	47	Poznámka k aktivitě Běh 1000 metrů. Osooba: 28 let úroveň 0	11287	5271
12087	31	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 0	11287	5263
12088	38	34	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 0	11287	5267
12089	32	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 0	11287	5274
12090	70	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 0	11287	5275
12091	27	31	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 0	11287	5265
12092	37	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 0	11287	5279
12093	87	34	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 0	11287	5266
12094	83	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 0	11287	5264
12095	71	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 1	11288	5253
12096	82	32	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 1	11288	5280
12097	76	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 1	11288	5251
12098	66	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 1	11288	5269
12099	22	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 1	11288	5254
12100	49	37	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 1	11288	5266
12101	82	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 1	11288	5274
12102	81	45	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 1	11288	5268
12103	97	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 1	11288	5275
12104	65	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 28 let úroveň 1	11288	5271
12105	75	42	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 1	11288	5256
12106	87	34	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 1	11288	5265
12107	54	39	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 1	11288	5276
12108	35	39	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 1	11288	5257
12109	82	39	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 1	11288	5267
12110	99	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 1	11288	5277
12111	21	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 1	11288	5279
12112	71	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 1	11288	5258
12113	95	31	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 1	11288	5261
12114	43	50	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 1	11288	5262
12115	51	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 1	11288	5263
12116	74	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 1	11288	5264
12117	30	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 0	11289	5253
12118	58	30	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 0	11289	5280
12119	53	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 0	11289	5251
12120	94	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 0	11289	5254
12121	93	36	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 0	11289	5256
12122	85	39	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 0	11289	5267
12123	65	39	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 0	11289	5257
12124	30	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 0	11289	5258
12125	85	44	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 0	11289	5261
12126	94	44	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 0	11289	5266
12127	79	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 0	11289	5277
12128	85	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 0	11289	5279
12129	32	40	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 0	11289	5268
12130	24	38	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 0	11289	5262
12131	96	46	Poznámka k aktivitě Běh 1000 metrů. Osooba: 29 let úroveň 0	11289	5271
12132	43	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 0	11289	5274
12133	25	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 0	11289	5263
12134	64	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 0	11289	5264
12135	32	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 0	11289	5269
12136	69	40	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 0	11289	5265
12137	56	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 0	11289	5275
12138	62	45	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 0	11289	5276
12139	84	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 1	11290	5253
12140	82	45	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 1	11290	5280
12141	71	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 1	11290	5251
12142	44	44	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 1	11290	5268
12143	28	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 1	11290	5269
12144	56	30	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 1	11290	5267
12145	67	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 1	11290	5274
12146	30	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 1	11290	5254
12147	69	31	Poznámka k aktivitě Běh 1000 metrů. Osooba: 29 let úroveň 1	11290	5271
12148	72	38	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 1	11290	5256
12149	30	44	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 1	11290	5276
12150	21	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 1	11290	5279
12151	49	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 1	11290	5275
12152	73	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 1	11290	5277
12153	62	34	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 1	11290	5257
12154	66	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 1	11290	5258
12155	98	31	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 1	11290	5261
12156	42	33	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 1	11290	5262
12157	65	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 1	11290	5263
12158	34	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 1	11290	5264
12159	58	49	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 1	11290	5266
12160	96	31	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 1	11290	5265
12161	82	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 0	11291	5258
12162	37	32	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 0	11291	5280
12163	33	42	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 0	11291	5268
12164	20	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 0	11291	5279
12165	89	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 30 let úroveň 0	11291	5271
12166	65	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 0	11291	5277
12167	94	31	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 0	11291	5266
12168	44	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 0	11291	5251
12169	47	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 0	11291	5274
12170	32	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 0	11291	5253
12171	68	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 0	11291	5254
12172	77	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 0	11291	5275
12173	67	33	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 0	11291	5256
12174	59	39	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 0	11291	5257
12175	75	48	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 0	11291	5267
12176	63	47	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 0	11291	5261
12177	86	38	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 0	11291	5276
12178	52	43	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 0	11291	5262
12179	59	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 0	11291	5263
12180	27	30	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 0	11291	5265
12181	45	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 0	11291	5269
12182	82	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 0	11291	5264
12183	94	30	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 1	11292	5257
12184	33	38	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 1	11292	5280
12185	57	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 1	11292	5251
12186	100	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 1	11292	5253
12187	44	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 1	11292	5254
12188	100	32	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 1	11292	5256
12189	38	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 1	11292	5258
12190	48	31	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 1	11292	5266
12191	56	38	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 1	11292	5261
12192	71	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 1	11292	5274
12193	49	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 30 let úroveň 1	11292	5271
12194	23	35	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 1	11292	5276
12195	62	47	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 1	11292	5262
12196	70	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 1	11292	5263
12197	73	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 1	11292	5269
12198	34	32	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 1	11292	5265
12199	97	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 1	11292	5279
12200	27	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 1	11292	5275
12201	88	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 1	11292	5277
12202	54	41	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 1	11292	5267
12203	21	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 1	11292	5264
12204	38	40	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 1	11292	5268
12205	23	38	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 0	11293	5256
12206	30	33	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 0	11293	5280
12207	100	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 0	11293	5251
12208	94	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 0	11293	5253
12209	45	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 0	11293	5254
12210	53	50	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 0	11293	5257
12211	20	32	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 0	11293	5267
12212	54	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 0	11293	5275
12213	37	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 0	11293	5258
12214	37	31	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 0	11293	5276
12215	25	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 31 let úroveň 0	11293	5271
12216	56	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 0	11293	5274
12217	72	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 0	11293	5277
12218	50	35	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 0	11293	5261
12219	61	49	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 0	11293	5268
12220	74	45	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 0	11293	5262
12221	34	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 0	11293	5269
12222	81	39	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 0	11293	5265
12223	49	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 0	11293	5263
12224	61	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 0	11293	5279
12225	69	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 0	11293	5264
12226	98	40	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 0	11293	5266
12227	29	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 1	11294	5251
12228	85	49	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 1	11294	5280
12229	75	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 1	11294	5279
12230	34	49	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 1	11294	5268
12231	92	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 1	11294	5253
12232	77	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 31 let úroveň 1	11294	5271
12233	84	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 1	11294	5254
12234	40	49	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 1	11294	5266
12235	73	39	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 1	11294	5276
12236	42	42	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 1	11294	5267
12237	38	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 1	11294	5274
12238	83	43	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 1	11294	5256
12239	41	32	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 1	11294	5257
12240	48	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 1	11294	5258
12241	66	34	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 1	11294	5261
12242	71	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 1	11294	5277
12243	57	43	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 1	11294	5262
12244	21	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 1	11294	5263
12245	33	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 1	11294	5275
12246	80	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 1	11294	5264
12247	88	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 1	11294	5269
12248	25	39	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 1	11294	5265
12249	68	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 0	11295	5254
12250	83	30	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 0	11295	5280
12251	52	33	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 0	11295	5266
12252	42	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 0	11295	5251
12253	55	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 0	11295	5253
12254	88	48	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 0	11295	5268
12255	64	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 0	11295	5275
12256	46	32	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 0	11295	5256
12257	73	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 0	11295	5274
12258	87	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 0	11295	5277
12259	72	36	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 0	11295	5257
12260	52	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 0	11295	5269
12261	26	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 32 let úroveň 0	11295	5271
12262	95	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 0	11295	5258
12263	71	45	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 0	11295	5261
12264	65	38	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 0	11295	5262
12265	81	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 0	11295	5263
12266	24	49	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 0	11295	5265
12267	40	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 0	11295	5279
12268	100	40	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 0	11295	5276
12269	53	40	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 0	11295	5267
12270	95	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 0	11295	5264
12271	48	31	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 1	11296	5256
12272	53	32	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 1	11296	5280
12273	52	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 1	11296	5251
12274	99	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 1	11296	5253
12275	40	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 1	11296	5254
12276	38	39	Poznámka k aktivitě Běh 1000 metrů. Osooba: 32 let úroveň 1	11296	5271
12277	70	49	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 1	11296	5268
12278	24	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 1	11296	5269
12279	78	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 1	11296	5275
12280	44	42	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 1	11296	5257
12281	48	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 1	11296	5258
12282	60	49	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 1	11296	5261
12283	82	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 1	11296	5277
12284	41	33	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 1	11296	5265
12285	63	39	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 1	11296	5267
12286	58	38	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 1	11296	5262
12287	34	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 1	11296	5279
12288	39	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 1	11296	5263
12289	30	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 1	11296	5264
12290	42	39	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 1	11296	5276
12291	96	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 1	11296	5274
12292	47	49	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 1	11296	5266
12293	21	35	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 0	11297	5262
12294	35	36	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 0	11297	5280
12295	66	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 0	11297	5251
12296	36	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 0	11297	5253
12297	50	30	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 0	11297	5276
12298	74	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 0	11297	5254
12299	37	37	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 0	11297	5256
12300	52	41	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 0	11297	5257
12301	61	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 0	11297	5275
12302	86	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 0	11297	5279
12303	89	43	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 0	11297	5265
12304	76	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 0	11297	5274
12305	74	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 0	11297	5258
12306	68	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 33 let úroveň 0	11297	5271
12307	21	39	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 0	11297	5266
12308	82	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 0	11297	5277
12309	63	36	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 0	11297	5261
12310	29	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 0	11297	5269
12311	52	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 0	11297	5263
12312	83	30	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 0	11297	5268
12313	50	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 0	11297	5264
12314	68	44	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 0	11297	5267
12315	53	33	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 1	11298	5256
12316	57	42	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 1	11298	5280
12317	69	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 1	11298	5251
12318	64	37	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 1	11298	5266
12319	63	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 1	11298	5279
12320	89	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 1	11298	5253
12321	84	50	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 1	11298	5268
12322	87	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 1	11298	5254
12323	99	34	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 1	11298	5257
12324	64	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 1	11298	5277
12325	84	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 1	11298	5258
12326	84	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 33 let úroveň 1	11298	5271
12327	67	50	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 1	11298	5261
12328	55	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 1	11298	5275
12329	64	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 1	11298	5269
12330	36	41	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 1	11298	5262
12331	33	33	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 1	11298	5267
12332	79	49	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 1	11298	5276
12333	71	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 1	11298	5274
12334	71	49	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 1	11298	5265
12335	45	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 1	11298	5263
12336	63	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 1	11298	5264
12337	42	50	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 0	11299	5261
12338	63	40	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 0	11299	5280
12339	66	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 0	11299	5279
12340	46	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 0	11299	5251
12341	35	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 0	11299	5253
12342	45	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 0	11299	5254
12343	64	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 0	11299	5274
12344	61	48	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 0	11299	5266
12345	69	49	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 0	11299	5267
12346	27	43	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 0	11299	5256
12347	88	40	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 0	11299	5257
12348	81	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 0	11299	5277
12349	20	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 0	11299	5258
12350	86	36	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 0	11299	5262
12351	44	33	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 0	11299	5276
12352	80	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 0	11299	5269
12353	28	33	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 0	11299	5265
12354	59	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 0	11299	5263
12355	29	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 0	11299	5264
12356	92	37	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 0	11299	5268
12357	87	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 0	11299	5275
12358	39	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 34 let úroveň 0	11299	5271
12359	73	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 1	11300	5253
12360	78	44	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 1	11300	5280
12361	36	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 1	11300	5251
12362	32	42	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 1	11300	5276
12363	40	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 1	11300	5277
12364	91	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 1	11300	5254
12365	48	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 1	11300	5269
12366	37	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 1	11300	5274
12367	30	30	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 1	11300	5256
12368	94	47	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 1	11300	5267
12369	44	33	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 1	11300	5257
12370	61	37	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 1	11300	5265
12371	67	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 1	11300	5258
12372	97	35	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 1	11300	5261
12373	68	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 1	11300	5275
12374	99	36	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 1	11300	5262
12375	63	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 1	11300	5263
12376	54	37	Poznámka k aktivitě Běh 1000 metrů. Osooba: 34 let úroveň 1	11300	5271
12377	99	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 1	11300	5264
12378	62	49	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 1	11300	5268
12379	41	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 1	11300	5279
12380	46	34	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 1	11300	5266
12381	47	36	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 0	12451	5257
12382	26	35	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 0	12451	5280
12383	46	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 35 let úroveň 0	12451	5271
12384	79	49	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 0	12451	5266
12385	48	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 0	12451	5279
12386	93	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 0	12451	5275
12387	79	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 0	12451	5277
12388	55	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 0	12451	5251
12389	44	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 0	12451	5253
12390	43	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 0	12451	5254
12391	74	39	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 0	12451	5256
12392	31	33	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 0	12451	5265
12393	63	45	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 0	12451	5276
12394	67	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 0	12451	5258
12395	56	48	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 0	12451	5267
12396	63	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 0	12451	5269
12397	76	49	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 0	12451	5261
12398	27	37	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 0	12451	5268
12399	100	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 0	12451	5274
12400	46	38	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 0	12451	5262
12501	31	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 0	12451	5263
12502	64	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 0	12451	5264
12503	98	49	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 1	12452	5257
12504	50	39	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 1	12452	5280
12505	74	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 1	12452	5251
12506	48	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 1	12452	5253
12507	41	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 1	12452	5254
12508	40	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 1	12452	5277
12509	38	43	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 1	12452	5256
12510	38	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 1	12452	5258
12511	45	44	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 1	12452	5261
12512	85	46	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 1	12452	5266
12513	92	31	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 1	12452	5265
12514	86	36	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 1	12452	5262
12515	65	45	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 1	12452	5268
12516	75	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 1	12452	5269
12517	81	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 1	12452	5279
12518	63	36	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 1	12452	5267
12519	88	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 1	12452	5274
12520	35	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 35 let úroveň 1	12452	5271
12521	48	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 1	12452	5275
12522	41	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 1	12452	5263
12523	42	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 1	12452	5264
12524	81	40	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 1	12452	5276
12525	70	40	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 0	12453	5280
12526	85	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 0	12453	5251
12527	72	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 0	12453	5253
12528	70	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 0	12453	5275
12529	89	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 0	12453	5254
12530	86	40	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 0	12453	5265
12531	64	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 0	12453	5269
12532	21	40	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 0	12453	5266
12533	88	40	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 0	12453	5256
12534	55	48	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 0	12453	5257
12535	44	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 0	12453	5274
12536	40	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 0	12453	5258
12537	51	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 0	12453	5277
12538	91	41	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 0	12453	5261
12539	90	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 0	12453	5279
12540	37	35	Poznámka k aktivitě Běh 1000 metrů. Osooba: 36 let úroveň 0	12453	5271
12541	92	42	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 0	12453	5262
12542	38	38	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 0	12453	5276
12543	83	50	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 0	12453	5267
12544	54	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 0	12453	5263
12545	54	32	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 0	12453	5268
12546	44	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 0	12453	5264
12547	88	47	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 1	12454	5280
12548	33	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 1	12454	5251
12549	66	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 1	12454	5253
12550	46	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 1	12454	5254
12551	96	39	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 1	12454	5276
12552	54	33	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 1	12454	5256
12553	32	42	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 1	12454	5257
12554	95	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 1	12454	5258
12555	78	39	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 1	12454	5261
12556	21	47	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 1	12454	5265
12557	74	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 1	12454	5275
12558	96	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 1	12454	5277
12559	71	48	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 1	12454	5262
12560	46	43	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 1	12454	5268
12561	98	49	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 1	12454	5266
12562	83	34	Poznámka k aktivitě Běh 1000 metrů. Osooba: 36 let úroveň 1	12454	5271
12563	73	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 1	12454	5263
12564	36	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 1	12454	5274
12565	68	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 1	12454	5264
12566	51	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 1	12454	5269
12567	79	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 1	12454	5279
12568	24	40	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 1	12454	5267
12569	67	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 0	12455	5258
12570	53	43	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 0	12455	5280
12571	23	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 0	12455	5251
12572	87	39	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 0	12455	5266
12573	64	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 0	12455	5253
12574	23	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 0	12455	5254
12575	51	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 0	12455	5275
12576	56	49	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 0	12455	5256
12577	90	43	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 0	12455	5257
12578	89	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 0	12455	5274
12579	83	47	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 0	12455	5261
12580	56	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 0	12455	5269
12581	98	36	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 0	12455	5262
12582	83	30	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 0	12455	5267
12583	62	31	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 0	12455	5265
12584	100	32	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 0	12455	5276
12585	77	47	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 0	12455	5268
12586	54	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 0	12455	5277
12587	49	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 37 let úroveň 0	12455	5271
12588	41	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 0	12455	5263
12589	55	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 0	12455	5264
12590	52	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 0	12455	5279
12591	23	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 1	12456	5251
12592	34	49	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 1	12456	5280
12593	82	45	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 1	12456	5268
12594	41	30	Poznámka k aktivitě Běh 1000 metrů. Osooba: 37 let úroveň 1	12456	5271
12595	75	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 1	12456	5253
12596	40	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 1	12456	5269
12597	70	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 1	12456	5279
12598	51	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 1	12456	5254
12599	47	48	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 1	12456	5256
12600	50	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 1	12456	5274
12601	64	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 1	12456	5275
12602	78	44	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 1	12456	5257
12603	20	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 1	12456	5258
12604	52	42	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 1	12456	5261
12605	54	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 1	12456	5277
12606	86	44	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 1	12456	5267
12607	59	46	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 1	12456	5262
12608	81	40	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 1	12456	5265
12609	74	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 1	12456	5263
12610	69	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 1	12456	5264
12611	68	46	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 1	12456	5276
12612	70	46	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 1	12456	5266
12613	88	43	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 0	12457	5257
12614	35	35	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 0	12457	5280
12615	88	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 0	12457	5251
12616	51	50	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 0	12457	5267
12617	81	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 0	12457	5274
12618	51	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: 38 let úroveň 0	12457	5271
12619	62	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 0	12457	5253
12620	95	41	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 0	12457	5265
12621	73	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 0	12457	5269
12622	22	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 0	12457	5254
12623	85	49	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 0	12457	5256
12624	80	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 0	12457	5279
12625	80	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 0	12457	5258
12626	67	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 0	12457	5277
12627	30	44	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 0	12457	5276
12628	40	43	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 0	12457	5261
12629	28	42	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 0	12457	5262
12630	95	50	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 0	12457	5266
12631	40	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 0	12457	5263
12632	68	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 0	12457	5275
12633	70	48	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 0	12457	5268
12634	95	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 0	12457	5264
12635	65	50	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 1	12458	5262
12636	59	46	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 1	12458	5280
12637	60	33	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 1	12458	5267
12638	22	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 38 let úroveň 1	12458	5271
12639	89	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 1	12458	5251
12640	76	37	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 1	12458	5265
12641	88	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 1	12458	5279
12642	70	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 1	12458	5274
12643	86	45	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 1	12458	5276
12644	56	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 1	12458	5253
12645	79	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 1	12458	5254
12646	29	48	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 1	12458	5256
12647	31	35	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 1	12458	5257
12648	82	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 1	12458	5258
12649	86	35	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 1	12458	5268
12650	66	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 1	12458	5277
12651	22	31	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 1	12458	5261
12652	72	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 1	12458	5263
12653	94	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 1	12458	5269
12654	23	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 1	12458	5264
12655	33	37	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 1	12458	5266
12656	49	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 1	12458	5275
12657	60	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 0	12459	5251
12658	51	39	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 0	12459	5280
12659	23	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 0	12459	5253
12660	96	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 0	12459	5269
12661	85	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 0	12459	5277
12662	29	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 0	12459	5254
12663	66	30	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 0	12459	5256
12664	30	33	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 0	12459	5257
12665	59	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 0	12459	5258
12666	82	33	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 0	12459	5268
12667	77	46	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 0	12459	5261
12668	90	50	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 0	12459	5262
12669	45	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 0	12459	5263
12670	30	37	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 0	12459	5267
12671	28	35	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 0	12459	5276
12672	55	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 0	12459	5279
12673	36	37	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 0	12459	5265
12674	100	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 0	12459	5274
12675	40	48	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 0	12459	5266
12676	27	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 0	12459	5264
12677	77	42	Poznámka k aktivitě Běh 1000 metrů. Osooba: 39 let úroveň 0	12459	5271
12678	77	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 0	12459	5275
12679	49	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 1	12460	5251
12680	65	44	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 1	12460	5280
12681	54	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 1	12460	5253
12682	50	42	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 1	12460	5268
12683	57	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 1	12460	5275
12684	33	40	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 1	12460	5276
12685	38	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 1	12460	5254
12686	91	33	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 1	12460	5256
12687	80	50	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 1	12460	5267
12688	100	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 1	12460	5279
12689	70	34	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 1	12460	5266
12690	93	37	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 1	12460	5257
12691	85	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 1	12460	5258
12692	65	44	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 1	12460	5261
12693	91	43	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 1	12460	5265
12694	84	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 1	12460	5274
12695	92	32	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 1	12460	5262
12696	98	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 39 let úroveň 1	12460	5271
12697	37	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 1	12460	5263
12698	95	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 1	12460	5264
12699	39	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 1	12460	5269
12700	28	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 1	12460	5277
12701	51	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 0	12461	5254
12702	47	37	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 0	12461	5280
12703	53	44	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 0	12461	5276
12704	44	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 0	12461	5251
12705	43	39	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 0	12461	5266
12706	99	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 0	12461	5253
12707	74	32	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 0	12461	5256
12708	86	43	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 0	12461	5257
12709	73	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 0	12461	5269
12710	37	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 0	12461	5258
12711	42	43	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 0	12461	5261
12712	59	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 0	12461	5277
12713	46	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 0	12461	5274
12714	40	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 0	12461	5275
12715	69	44	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 0	12461	5262
12716	20	39	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 0	12461	5267
12717	27	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 0	12461	5279
12718	89	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 0	12461	5263
12719	28	38	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 0	12461	5265
12720	70	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 0	12461	5264
12721	99	46	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 0	12461	5268
12722	36	47	Poznámka k aktivitě Běh 1000 metrů. Osooba: 40 let úroveň 0	12461	5271
12723	74	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 1	12462	5253
12724	66	31	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 1	12462	5280
12725	26	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 1	12462	5251
12726	84	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 1	12462	5254
12727	38	42	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 1	12462	5276
12728	42	39	Poznámka k aktivitě Běh 1000 metrů. Osooba: 40 let úroveň 1	12462	5271
12729	38	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 1	12462	5277
12730	52	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 1	12462	5275
12731	65	41	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 1	12462	5256
12732	30	48	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 1	12462	5257
12733	70	31	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 1	12462	5268
12734	99	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 1	12462	5258
12735	43	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 1	12462	5274
12736	67	31	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 1	12462	5261
12737	46	47	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 1	12462	5267
12738	39	43	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 1	12462	5265
12739	83	33	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 1	12462	5262
12740	71	41	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 1	12462	5266
12741	49	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 1	12462	5263
12742	44	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 1	12462	5279
12743	81	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 1	12462	5269
12744	81	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 1	12462	5264
12745	80	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 0	12463	5254
12746	63	39	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 0	12463	5280
12747	25	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 0	12463	5277
12748	94	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 0	12463	5274
12749	42	33	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 0	12463	5276
12750	28	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 0	12463	5251
12751	68	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 0	12463	5253
12752	38	48	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 0	12463	5256
12753	44	37	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 0	12463	5257
12754	48	38	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 0	12463	5265
12755	88	33	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 0	12463	5268
12756	28	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 0	12463	5258
12757	94	44	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 0	12463	5261
12758	80	36	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 0	12463	5262
12759	87	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 0	12463	5275
12760	63	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 0	12463	5263
12761	51	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 0	12463	5264
12762	62	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 41 let úroveň 0	12463	5271
12763	37	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 0	12463	5279
12764	65	41	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 0	12463	5267
12765	86	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 0	12463	5269
12766	40	38	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 0	12463	5266
12767	26	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 1	12464	5251
12768	96	32	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 1	12464	5280
12769	41	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 1	12464	5253
12770	97	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 1	12464	5254
12771	25	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 1	12464	5274
12772	41	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 1	12464	5269
12773	38	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 1	12464	5275
12774	58	38	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 1	12464	5256
12775	59	47	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 1	12464	5257
12776	45	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 1	12464	5258
12777	23	48	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 1	12464	5266
12778	99	40	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 1	12464	5267
12779	85	42	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 1	12464	5261
12780	88	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 1	12464	5277
12781	88	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 1	12464	5279
12782	83	40	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 1	12464	5262
12783	34	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 1	12464	5263
12784	91	46	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 1	12464	5276
12785	83	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 1	12464	5264
12786	24	43	Poznámka k aktivitě Běh 1000 metrů. Osooba: 41 let úroveň 1	12464	5271
12787	35	30	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 1	12464	5265
12788	37	37	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 1	12464	5268
12789	90	35	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 0	12465	5262
12790	81	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 0	12465	5253
12791	91	34	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 0	12465	5280
12792	70	45	Poznámka k aktivitě Běh 1000 metrů. Osooba: 42 let úroveň 0	12465	5271
12793	80	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 0	12465	5274
12794	51	35	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 0	12465	5265
12795	40	39	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 0	12465	5266
12796	81	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 0	12465	5251
12797	43	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 0	12465	5254
12798	79	40	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 0	12465	5276
12799	63	39	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 0	12465	5256
12800	21	35	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 0	12465	5257
12801	46	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 0	12465	5258
12802	32	32	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 0	12465	5261
12803	43	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 0	12465	5263
12804	35	30	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 0	12465	5268
12805	76	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 0	12465	5279
12806	33	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 0	12465	5264
12807	80	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 0	12465	5277
12808	40	49	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 0	12465	5267
12809	26	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 0	12465	5275
12810	72	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 0	12465	5269
12811	23	40	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 1	12466	5280
12812	100	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 1	12466	5251
12813	73	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 1	12466	5279
12814	89	31	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 1	12466	5268
12815	90	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 1	12466	5253
12816	92	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 1	12466	5254
12817	31	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 1	12466	5269
12818	64	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 1	12466	5277
12819	57	43	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 1	12466	5256
12820	94	37	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 1	12466	5276
12821	25	30	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 1	12466	5267
12822	27	32	Poznámka k aktivitě Běh 1000 metrů. Osooba: 42 let úroveň 1	12466	5271
12823	34	45	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 1	12466	5257
12824	96	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 1	12466	5258
12825	87	39	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 1	12466	5266
12826	21	46	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 1	12466	5261
12827	66	38	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 1	12466	5262
12828	20	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 1	12466	5274
12829	83	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 1	12466	5275
12830	67	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 1	12466	5263
12831	63	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 1	12466	5264
12832	73	39	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 1	12466	5265
12833	37	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 0	12467	5258
12834	43	33	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 0	12467	5280
12835	37	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 0	12467	5251
12836	30	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 0	12467	5253
12837	49	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 0	12467	5254
12838	49	44	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 0	12467	5266
12839	86	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 0	12467	5277
12840	30	32	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 0	12467	5268
12841	29	49	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 0	12467	5256
12842	80	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 0	12467	5269
12843	51	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 43 let úroveň 0	12467	5271
12844	25	50	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 0	12467	5257
12845	20	43	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 0	12467	5261
12846	36	49	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 0	12467	5265
12847	44	35	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 0	12467	5276
12848	33	40	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 0	12467	5267
12849	92	36	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 0	12467	5262
12850	99	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 0	12467	5279
12851	28	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 0	12467	5263
12852	40	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 0	12467	5264
12853	46	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 0	12467	5274
12854	23	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 0	12467	5275
12855	88	50	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 1	12468	5261
12856	55	47	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 1	12468	5280
12857	60	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 1	12468	5251
12858	63	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 1	12468	5275
12859	20	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 1	12468	5253
12860	75	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 1	12468	5254
12861	48	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 43 let úroveň 1	12468	5271
12862	26	45	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 1	12468	5276
12863	25	48	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 1	12468	5267
12864	73	38	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 1	12468	5268
12865	61	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 1	12468	5277
12866	89	45	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 1	12468	5256
12867	84	31	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 1	12468	5257
12868	40	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 1	12468	5269
12869	65	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 1	12468	5279
12870	78	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 1	12468	5258
12871	83	41	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 1	12468	5266
12872	28	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 1	12468	5274
12873	58	44	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 1	12468	5262
12874	64	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 1	12468	5263
12875	44	34	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 1	12468	5265
12876	91	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 1	12468	5264
12877	20	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 0	12469	5251
12878	72	49	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 0	12469	5280
12879	68	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 0	12469	5253
12880	69	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 0	12469	5277
12881	32	36	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 0	12469	5265
12882	65	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 0	12469	5254
12883	65	49	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 0	12469	5256
12884	53	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 0	12469	5279
12885	46	35	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 0	12469	5257
12886	56	50	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 0	12469	5267
12887	22	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 44 let úroveň 0	12469	5271
12888	40	49	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 0	12469	5276
12889	71	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 0	12469	5275
12890	20	50	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 0	12469	5268
12891	59	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 0	12469	5269
12892	80	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 0	12469	5258
12893	57	49	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 0	12469	5261
12894	25	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 0	12469	5274
12895	71	49	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 0	12469	5262
12896	73	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 0	12469	5263
12897	35	45	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 0	12469	5266
12898	95	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 0	12469	5264
12899	60	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 1	12470	5253
12900	40	43	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 1	12470	5280
12901	95	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 1	12470	5275
12902	91	30	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 1	12470	5266
12903	20	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 1	12470	5251
12904	85	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 1	12470	5254
12905	98	32	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 1	12470	5268
12906	63	32	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 1	12470	5256
12907	28	30	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 1	12470	5257
12908	87	49	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 1	12470	5267
12909	82	46	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 1	12470	5276
12910	48	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 1	12470	5277
12911	56	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 1	12470	5258
12912	35	38	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 1	12470	5265
12913	69	35	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 1	12470	5261
12914	30	43	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 1	12470	5262
12915	38	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 1	12470	5274
12916	44	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 44 let úroveň 1	12470	5271
13040	80	35	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 1	12476	5266
12917	24	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 1	12470	5263
12918	65	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 1	12470	5269
12919	46	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 1	12470	5264
12920	35	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 1	12470	5279
12921	41	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 0	12471	5254
12922	26	50	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 0	12471	5280
12923	68	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 0	12471	5269
12924	28	45	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 0	12471	5276
12925	31	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 0	12471	5251
12926	98	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 0	12471	5253
12927	31	44	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 0	12471	5256
12928	88	38	Poznámka k aktivitě Běh 1000 metrů. Osooba: 45 let úroveň 0	12471	5271
12929	46	46	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 0	12471	5267
12930	94	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 0	12471	5277
12931	43	40	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 0	12471	5257
12932	98	47	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 0	12471	5268
12933	58	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 0	12471	5258
12934	24	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 0	12471	5275
12935	37	38	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 0	12471	5261
12936	57	45	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 0	12471	5266
12937	37	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 0	12471	5279
12938	29	49	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 0	12471	5262
12939	61	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 0	12471	5263
12940	81	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 0	12471	5274
12941	31	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 0	12471	5264
12942	43	49	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 0	12471	5265
12943	66	41	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 1	12472	5257
12944	46	42	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 1	12472	5280
12945	42	46	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 1	12472	5266
12946	34	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 1	12472	5279
12947	70	30	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 1	12472	5268
12948	67	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 1	12472	5251
12949	33	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 1	12472	5253
12950	22	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 1	12472	5254
12951	29	45	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 1	12472	5256
12952	33	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 1	12472	5275
12953	49	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 1	12472	5269
12954	76	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 1	12472	5274
12955	24	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 1	12472	5258
12956	20	48	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 1	12472	5276
12957	65	43	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 1	12472	5261
12958	64	35	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 1	12472	5262
12959	26	37	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 1	12472	5267
12960	97	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 1	12472	5263
12961	76	37	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 1	12472	5265
12962	63	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 1	12472	5264
12963	58	42	Poznámka k aktivitě Běh 1000 metrů. Osooba: 45 let úroveň 1	12472	5271
12964	26	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 1	12472	5277
12965	81	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 0	12473	5253
12966	81	50	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 0	12473	5280
12967	32	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 0	12473	5251
12968	40	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 0	12473	5254
12969	89	34	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 0	12473	5256
12970	39	41	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 0	12473	5257
12971	81	36	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 0	12473	5265
12972	57	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 0	12473	5258
12973	84	34	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 0	12473	5266
12974	84	44	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 0	12473	5276
12975	72	35	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 0	12473	5261
12976	20	39	Poznámka k aktivitě Běh 1000 metrů. Osooba: 46 let úroveň 0	12473	5271
12977	33	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 0	12473	5274
12978	46	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 0	12473	5277
12979	73	47	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 0	12473	5268
12980	50	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 0	12473	5269
12981	23	36	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 0	12473	5262
12982	82	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 0	12473	5279
12983	94	48	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 0	12473	5267
12984	91	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 0	12473	5275
12985	68	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 0	12473	5263
12986	62	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 0	12473	5264
12987	73	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 1	12474	5251
12988	74	30	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 1	12474	5280
12989	93	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 1	12474	5274
12990	76	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 1	12474	5253
12991	72	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 1	12474	5254
12992	99	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 1	12474	5275
12993	91	30	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 1	12474	5266
12994	86	33	Poznámka k aktivitě Běh 1000 metrů. Osooba: 46 let úroveň 1	12474	5271
12995	51	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 1	12474	5269
12996	76	39	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 1	12474	5256
12997	57	42	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 1	12474	5257
12998	29	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 1	12474	5258
12999	61	38	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 1	12474	5261
13000	67	32	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 1	12474	5262
13001	41	45	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 1	12474	5267
13002	60	46	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 1	12474	5276
13003	41	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 1	12474	5279
13004	37	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 1	12474	5263
13005	57	30	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 1	12474	5265
13006	75	42	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 1	12474	5268
13007	52	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 1	12474	5277
13008	67	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 1	12474	5264
13009	42	39	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 0	12475	5280
13010	99	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 0	12475	5251
13011	60	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 0	12475	5253
13012	89	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 0	12475	5269
13013	52	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 0	12475	5254
13014	76	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 0	12475	5279
13015	95	37	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 0	12475	5267
13016	66	41	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 0	12475	5256
13017	92	48	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 0	12475	5257
13018	66	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 0	12475	5258
13019	57	39	Poznámka k aktivitě Běh 1000 metrů. Osooba: 47 let úroveň 0	12475	5271
13020	72	43	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 0	12475	5261
13021	67	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 0	12475	5277
13022	35	38	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 0	12475	5276
13023	90	46	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 0	12475	5265
13024	43	35	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 0	12475	5266
13025	76	45	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 0	12475	5268
13026	59	45	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 0	12475	5262
13027	94	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 0	12475	5263
13028	47	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 0	12475	5274
13029	50	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 0	12475	5275
13030	31	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 0	12475	5264
13031	59	39	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 1	12476	5280
13032	31	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 1	12476	5251
13033	99	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 1	12476	5253
13034	36	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 1	12476	5254
13035	32	34	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 1	12476	5256
13036	40	42	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 1	12476	5257
13037	100	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 1	12476	5275
13038	39	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 1	12476	5258
13039	27	47	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 1	12476	5261
13041	32	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 1	12476	5269
13042	65	42	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 1	12476	5268
13043	74	48	Poznámka k aktivitě Běh 1000 metrů. Osooba: 47 let úroveň 1	12476	5271
13044	78	41	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 1	12476	5276
13045	92	44	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 1	12476	5262
13046	34	41	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 1	12476	5267
13047	21	33	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 1	12476	5265
13048	94	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 1	12476	5274
13049	38	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 1	12476	5277
13050	41	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 1	12476	5263
13051	92	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 1	12476	5264
13052	20	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 1	12476	5279
13053	34	44	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 0	12477	5280
13054	31	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 0	12477	5251
13055	30	50	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 0	12477	5267
13056	68	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 0	12477	5253
13057	63	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 0	12477	5254
13058	50	50	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 0	12477	5256
13059	48	39	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 0	12477	5257
13060	24	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 0	12477	5279
13061	75	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 0	12477	5277
13062	90	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 0	12477	5258
13063	96	41	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 0	12477	5261
13064	38	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 0	12477	5275
13065	69	48	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 0	12477	5262
13066	74	36	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 0	12477	5266
13067	52	36	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 0	12477	5265
13068	97	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 0	12477	5263
13069	89	37	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 0	12477	5268
13070	74	40	Poznámka k aktivitě Běh 1000 metrů. Osooba: 48 let úroveň 0	12477	5271
13071	63	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 0	12477	5274
13072	42	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 0	12477	5264
13073	67	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 0	12477	5269
13074	45	47	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 0	12477	5276
13075	59	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 1	12478	5251
13076	60	38	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 1	12478	5280
13077	27	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 1	12478	5253
13078	31	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 1	12478	5254
13079	46	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 1	12478	5279
13080	33	49	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 1	12478	5256
13081	86	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 1	12478	5269
13082	90	31	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 1	12478	5276
13083	30	41	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 1	12478	5267
13084	37	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 1	12478	5275
13085	78	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 1	12478	5277
13086	34	48	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 1	12478	5257
13087	24	34	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 1	12478	5268
13088	83	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 1	12478	5258
13089	80	50	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 1	12478	5265
13090	98	41	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 1	12478	5266
13091	81	36	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 1	12478	5261
13092	54	40	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 1	12478	5262
13093	78	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 1	12478	5263
13094	82	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 1	12478	5264
13095	20	30	Poznámka k aktivitě Běh 1000 metrů. Osooba: 48 let úroveň 1	12478	5271
13096	82	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 1	12478	5274
13097	52	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 0	12479	5263
13098	28	40	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 0	12479	5280
13099	54	36	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 0	12479	5265
13100	76	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 0	12479	5277
13101	68	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 0	12479	5251
13102	30	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 0	12479	5253
13103	93	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 0	12479	5254
13104	53	32	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 0	12479	5256
13105	29	36	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 0	12479	5257
13106	58	39	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 0	12479	5276
13107	83	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 0	12479	5258
13108	51	37	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 0	12479	5261
13109	60	45	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 0	12479	5268
13110	53	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 0	12479	5269
13111	84	35	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 0	12479	5262
13112	53	37	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 0	12479	5267
13113	21	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 0	12479	5274
13114	36	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 0	12479	5279
13115	71	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 0	12479	5264
13116	61	34	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 0	12479	5266
13117	90	36	Poznámka k aktivitě Běh 1000 metrů. Osooba: 49 let úroveň 0	12479	5271
13118	77	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 0	12479	5275
13119	99	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 1	12480	5251
13120	38	34	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 1	12480	5280
13121	29	44	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 1	12480	5268
13122	65	47	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 1	12480	5276
13123	46	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 1	12480	5277
13124	68	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 1	12480	5253
13125	51	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 1	12480	5254
13126	93	40	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 1	12480	5256
13127	34	41	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 1	12480	5257
13128	23	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 1	12480	5258
13129	69	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 1	12480	5269
13130	86	41	Poznámka k aktivitě Běh 1000 metrů. Osooba: 49 let úroveň 1	12480	5271
13131	23	46	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 1	12480	5266
13132	39	32	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 1	12480	5267
13133	89	46	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 1	12480	5261
13134	80	38	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 1	12480	5262
13135	23	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 1	12480	5263
13136	49	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 1	12480	5274
13137	27	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 1	12480	5279
13138	34	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 1	12480	5275
13139	58	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 1	12480	5264
13140	33	47	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 1	12480	5265
13141	21	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: Jan Selinger	12481	5253
13142	81	46	Poznámka k aktivitě Výskok s míčem. Osooba: Jan Selinger	12481	5280
13143	80	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	12481	5251
13144	100	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: Jan Selinger	12481	5254
13145	34	34	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	12481	5279
13146	44	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	12481	5264
13147	69	30	Poznámka k aktivitě Letmý start. Osooba: Jan Selinger	12481	5256
13148	75	38	Poznámka k aktivitě Překážková dráha. Osooba: Jan Selinger	12481	5257
13149	66	\N	Poznámka k aktivitě slalom. Osooba: Jan Selinger	12481	5269
13150	29	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	12481	5258
13151	32	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Jan Selinger	12481	5260
13152	49	35	Poznámka k aktivitě Kliky. Osooba: Jan Selinger	12481	5266
13153	73	50	Poznámka k aktivitě Lowa brace test. Osooba: Jan Selinger	12481	5261
13154	70	46	Poznámka k aktivitě Slalom s míčem. Osooba: Jan Selinger	12481	5276
13155	20	39	Poznámka k aktivitě Žebřík. Osooba: Jan Selinger	12481	5262
13156	63	34	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	12481	5268
13157	29	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	12481	5275
13158	55	46	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	12481	5265
13159	92	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	12481	5263
13160	80	41	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	12481	5267
13161	37	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Jan Selinger	12481	5277
13162	21	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: Luděk Rous	12482	5253
13163	72	34	Poznámka k aktivitě Výskok s míčem. Osooba: Luděk Rous	12482	5280
13164	51	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rous	12482	5251
13165	84	44	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rous	12482	5267
13166	30	45	Poznámka k aktivitě Slalom s míčem. Osooba: Luděk Rous	12482	5276
13167	37	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: Luděk Rous	12482	5254
13168	82	40	Poznámka k aktivitě Letmý start. Osooba: Luděk Rous	12482	5256
13169	75	43	Poznámka k aktivitě Překážková dráha. Osooba: Luděk Rous	12482	5257
13170	33	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rous	12482	5258
13171	60	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rous	12482	5275
13172	82	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Luděk Rous	12482	5277
13173	65	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Luděk Rous	12482	5260
13174	96	41	Poznámka k aktivitě Lowa brace test. Osooba: Luděk Rous	12482	5261
13175	53	43	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rous	12482	5268
13176	81	\N	Poznámka k aktivitě slalom. Osooba: Luděk Rous	12482	5269
13177	27	31	Poznámka k aktivitě Žebřík. Osooba: Luděk Rous	12482	5262
13178	96	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rous	12482	5264
13179	44	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rous	12482	5263
13180	57	47	Poznámka k aktivitě Kliky. Osooba: Luděk Rous	12482	5266
13181	97	37	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rous	12482	5279
13182	83	43	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rous	12482	5265
13183	71	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	12483	5251
13184	76	31	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 0	12483	5280
13185	79	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 0	12483	5253
13186	83	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	12483	5275
13187	22	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	12483	5264
13188	39	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 0	12483	5254
13189	37	35	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 0	12483	5256
13190	99	48	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	12483	5265
13191	33	34	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	12483	5268
13192	75	41	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 0	12483	5266
13193	57	32	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 0	12483	5257
13194	30	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	12483	5258
13195	75	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 0	12483	5260
13196	85	43	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 0	12483	5261
13197	41	40	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 0	12483	5262
13198	90	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	12483	5263
13199	51	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 0	12483	5277
13200	64	48	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 0	12483	5276
13201	33	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	12483	5279
13202	77	42	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	12483	5267
13203	93	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 0	12483	5269
13204	38	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 1	12484	5251
13205	31	47	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 1	12484	5280
13206	63	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 1	12484	5253
13207	63	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 1	12484	5254
13208	21	31	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 1	12484	5256
13209	68	38	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 1	12484	5257
13210	78	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 1	12484	5258
13211	25	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 1	12484	5264
13212	90	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 1	12484	5269
13213	36	36	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 1	12484	5266
13214	89	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 1	12484	5260
13215	59	37	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 1	12484	5261
13216	82	45	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 1	12484	5262
13217	84	50	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 1	12484	5265
13218	43	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 1	12484	5279
13219	63	45	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 1	12484	5267
13220	92	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 1	12484	5263
13221	36	32	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 1	12484	5268
13222	68	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 1	12484	5275
13223	82	42	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 1	12484	5276
13224	99	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 1	12484	5277
13225	23	44	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 0	12485	5280
13226	85	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	12485	5251
13227	59	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 0	12485	5253
13228	72	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 0	12485	5254
13229	86	37	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	12485	5265
13230	42	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 0	12485	5277
13231	32	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 0	12485	5269
13232	83	33	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 0	12485	5256
13233	45	48	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 0	12485	5257
13234	44	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	12485	5258
13235	66	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	12485	5275
13236	42	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	12485	5264
13237	64	35	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 0	12485	5276
13238	74	34	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	12485	5268
13239	99	33	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	12485	5267
13240	26	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 0	12485	5260
13241	98	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	12485	5279
13242	77	38	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 0	12485	5261
13243	89	35	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 0	12485	5266
13244	88	43	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 0	12485	5262
13245	57	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	12485	5263
13246	36	31	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 1	12486	5256
13247	39	46	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 1	12486	5280
13248	27	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 1	12486	5264
13249	68	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 1	12486	5277
13250	21	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 1	12486	5251
13251	54	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 1	12486	5253
13252	21	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 1	12486	5279
13253	43	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 1	12486	5269
13254	64	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 1	12486	5254
13255	94	35	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 1	12486	5257
13256	95	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 1	12486	5258
13257	34	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 1	12486	5260
13258	65	43	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 1	12486	5261
13259	33	31	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 1	12486	5265
13260	42	50	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 1	12486	5266
13261	78	32	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 1	12486	5267
13262	77	45	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 1	12486	5276
13263	77	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 1	12486	5275
13264	69	35	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 1	12486	5262
13265	55	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 1	12486	5263
13266	48	49	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 1	12486	5268
13267	95	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	12487	5251
13268	24	36	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 0	12487	5280
13269	27	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 0	12487	5253
13270	35	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 0	12487	5254
13271	39	50	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 0	12487	5256
13272	32	38	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 0	12487	5257
13273	75	45	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 0	12487	5276
13274	69	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	12487	5258
13275	60	46	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	12487	5265
13276	37	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	12487	5279
13277	21	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 0	12487	5260
13278	92	46	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 0	12487	5261
13279	51	48	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	12487	5267
13280	90	40	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 0	12487	5262
13281	94	40	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	12487	5268
13282	53	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	12487	5264
13283	52	31	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 0	12487	5266
13284	30	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 0	12487	5269
13285	68	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 0	12487	5277
13286	79	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	12487	5263
13287	24	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	12487	5275
13288	41	48	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 1	12488	5280
13289	59	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 1	12488	5251
13290	21	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 1	12488	5253
13291	39	30	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 1	12488	5268
13292	72	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 1	12488	5279
13293	81	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 1	12488	5254
13294	53	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 1	12488	5277
13295	95	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 1	12488	5275
13296	26	34	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 1	12488	5256
13297	87	48	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 1	12488	5257
13298	59	38	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 1	12488	5276
13299	34	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 1	12488	5258
13300	99	31	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 1	12488	5267
13301	79	40	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 1	12488	5266
13302	34	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 1	12488	5260
13303	89	37	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 1	12488	5261
13304	51	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 1	12488	5269
13305	77	33	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 1	12488	5265
13306	33	50	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 1	12488	5262
13307	96	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 1	12488	5264
13308	22	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 1	12488	5263
13309	46	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 0	12489	5251
13310	28	38	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 0	12489	5280
13311	47	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 0	12489	5253
13312	31	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 0	12489	5254
13313	88	40	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 0	12489	5256
13314	29	40	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 0	12489	5257
13315	20	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 0	12489	5258
13316	34	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 0	12489	5269
13317	54	36	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 0	12489	5265
13318	77	49	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 0	12489	5266
13319	88	44	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 0	12489	5268
13320	83	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 0	12489	5275
13321	51	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 0	12489	5279
13322	74	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 0	12489	5260
13323	75	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 0	12489	5264
13324	54	49	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 0	12489	5261
13325	21	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 0	12489	5277
13326	48	33	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 0	12489	5262
13327	23	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 0	12489	5263
13328	22	34	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 0	12489	5267
13329	44	49	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 0	12489	5276
13330	31	46	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 1	12490	5280
13331	81	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 1	12490	5251
13332	55	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 1	12490	5253
13333	63	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 1	12490	5254
13334	43	31	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 1	12490	5256
13335	25	45	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 1	12490	5257
13336	42	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 1	12490	5269
13337	68	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 1	12490	5258
13338	45	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 1	12490	5275
13339	99	45	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 1	12490	5276
13340	38	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 1	12490	5260
13341	87	36	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 1	12490	5268
13342	37	47	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 1	12490	5261
13343	95	46	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 1	12490	5265
13344	60	34	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 1	12490	5266
13345	93	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 1	12490	5264
13346	92	32	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 1	12490	5262
13347	44	47	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 1	12490	5267
13348	57	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 1	12490	5279
13349	97	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 1	12490	5277
13350	89	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 1	12490	5263
13351	20	43	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 0	12491	5257
13352	83	42	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 0	12491	5280
13353	77	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 0	12491	5251
13354	26	42	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 0	12491	5266
13355	51	43	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 0	12491	5265
13356	33	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 0	12491	5269
13357	97	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 0	12491	5277
13358	89	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 0	12491	5253
13359	47	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 0	12491	5254
13360	31	40	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 0	12491	5276
13361	34	36	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 0	12491	5268
13362	63	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 0	12491	5275
13363	59	41	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 0	12491	5256
13364	24	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 0	12491	5258
13365	32	41	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 0	12491	5267
13366	41	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 0	12491	5260
13367	72	47	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 0	12491	5261
13368	56	37	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 0	12491	5262
13369	53	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 0	12491	5263
13370	54	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 0	12491	5279
13371	36	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 0	12491	5264
13372	25	31	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 1	12492	5261
13373	82	40	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 1	12492	5280
13374	77	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 1	12492	5251
13375	86	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 1	12492	5264
13376	23	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 1	12492	5253
13377	92	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 1	12492	5254
13378	67	46	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 1	12492	5256
13379	66	43	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 1	12492	5267
13380	27	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 1	12492	5269
13381	71	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 1	12492	5277
13382	85	49	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 1	12492	5268
13383	75	41	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 1	12492	5257
13384	96	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 1	12492	5279
13385	44	42	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 1	12492	5276
13386	92	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 1	12492	5258
13387	94	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 1	12492	5260
13388	20	44	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 1	12492	5266
13389	100	31	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 1	12492	5262
13390	65	42	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 1	12492	5265
13391	77	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 1	12492	5263
13392	61	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 1	12492	5275
13393	58	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 0	12493	5253
13394	21	38	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 0	12493	5280
13395	56	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 0	12493	5251
13396	83	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 0	12493	5277
13397	76	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 0	12493	5279
13398	27	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 0	12493	5275
13399	57	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 0	12493	5254
13400	55	31	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 0	12493	5256
13401	94	43	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 0	12493	5257
13402	75	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 0	12493	5264
13403	45	33	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 0	12493	5268
13404	77	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 0	12493	5258
13405	95	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 0	12493	5260
13406	29	47	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 0	12493	5261
13407	80	44	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 0	12493	5262
13408	51	49	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 0	12493	5267
13409	49	30	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 0	12493	5276
13410	62	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 0	12493	5263
13411	93	47	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 0	12493	5266
13412	54	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 0	12493	5269
13413	75	42	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 0	12493	5265
13414	80	30	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 1	12494	5256
13415	61	31	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 1	12494	5280
13416	22	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 1	12494	5251
13417	94	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 1	12494	5275
13418	95	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 1	12494	5253
13419	66	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 1	12494	5254
13420	52	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 1	12494	5264
13421	93	34	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 1	12494	5257
13422	47	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 1	12494	5258
13423	72	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 1	12494	5260
13424	100	36	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 1	12494	5261
13425	83	33	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 1	12494	5262
13426	99	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 1	12494	5269
13427	41	36	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 1	12494	5276
13428	31	39	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 1	12494	5268
13429	81	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 1	12494	5277
13430	97	35	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 1	12494	5265
13431	42	30	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 1	12494	5267
13432	31	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 1	12494	5279
13433	32	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 1	12494	5263
13434	74	31	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 1	12494	5266
13435	21	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 0	12495	5253
13436	80	45	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 0	12495	5280
13437	98	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 0	12495	5251
13438	31	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 0	12495	5254
13439	54	49	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 0	12495	5256
13440	66	39	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 0	12495	5257
13441	100	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 0	12495	5275
13442	35	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 0	12495	5258
13443	51	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 0	12495	5260
13444	76	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 0	12495	5279
13445	32	32	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 0	12495	5276
13446	51	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 0	12495	5264
13447	61	42	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 0	12495	5266
13448	24	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 0	12495	5277
13449	47	37	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 0	12495	5261
13450	69	49	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 0	12495	5267
13451	64	33	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 0	12495	5268
13452	33	47	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 0	12495	5262
13453	37	47	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 0	12495	5265
13454	76	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 0	12495	5263
13455	75	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 0	12495	5269
13456	99	37	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 1	12496	5280
13457	77	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 1	12496	5251
13458	38	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 1	12496	5253
13459	41	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 1	12496	5254
13460	66	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 1	12496	5279
13461	33	49	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 1	12496	5256
13462	68	38	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 1	12496	5257
13463	53	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 1	12496	5258
13464	29	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 1	12496	5260
13465	67	42	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 1	12496	5268
13466	89	34	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 1	12496	5265
13467	70	50	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 1	12496	5266
13468	82	50	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 1	12496	5267
13469	97	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 1	12496	5269
13470	61	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 1	12496	5275
13471	53	48	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 1	12496	5261
13472	86	44	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 1	12496	5276
13473	84	49	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 1	12496	5262
13474	76	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 1	12496	5277
13475	49	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 1	12496	5264
13476	48	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 1	12496	5263
13477	39	30	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 0	12497	5256
13478	95	42	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 0	12497	5280
13479	64	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 0	12497	5251
13480	33	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 0	12497	5275
13481	69	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 0	12497	5277
13482	60	31	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 0	12497	5267
13483	44	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 0	12497	5264
13484	59	50	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 0	12497	5266
13485	71	39	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 0	12497	5276
13486	22	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 0	12497	5253
13487	70	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 0	12497	5254
13488	84	33	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 0	12497	5268
13489	55	44	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 0	12497	5257
13490	43	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 0	12497	5258
13491	91	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 0	12497	5260
13492	86	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 0	12497	5269
13493	93	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 0	12497	5279
13494	79	42	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 0	12497	5261
13495	96	38	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 0	12497	5262
13496	86	44	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 0	12497	5265
13497	34	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 0	12497	5263
13498	76	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 1	12498	5254
13499	26	44	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 1	12498	5280
13500	24	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 1	12498	5251
13501	87	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 1	12498	5253
13502	30	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 1	12498	5264
13503	94	47	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 1	12498	5276
13504	20	41	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 1	12498	5256
13505	31	48	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 1	12498	5266
13506	95	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 1	12498	5275
13507	60	44	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 1	12498	5257
13508	80	44	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 1	12498	5265
13509	20	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 1	12498	5258
13510	78	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 1	12498	5260
13511	41	37	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 1	12498	5267
13512	40	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 1	12498	5269
13513	82	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 1	12498	5279
13514	43	48	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 1	12498	5261
13515	100	38	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 1	12498	5262
13516	33	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 1	12498	5263
13517	72	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 1	12498	5277
13518	86	34	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 1	12498	5268
13519	98	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 0	12499	5258
13520	31	33	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 0	12499	5280
13521	89	50	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 0	12499	5265
13522	82	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 0	12499	5251
13523	99	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 0	12499	5253
13524	34	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 0	12499	5254
13525	33	45	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 0	12499	5256
13526	69	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 0	12499	5269
13527	47	46	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 0	12499	5257
13528	45	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 0	12499	5260
13529	63	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 0	12499	5275
13530	53	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 0	12499	5277
13531	23	47	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 0	12499	5276
13532	34	40	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 0	12499	5261
13533	34	40	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 0	12499	5262
13534	68	37	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 0	12499	5266
13535	25	34	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 0	12499	5267
13536	77	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 0	12499	5264
13537	88	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 0	12499	5279
13538	37	39	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 0	12499	5268
13539	68	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 0	12499	5263
13540	32	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 1	12500	5251
13541	89	46	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 1	12500	5280
13542	50	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 1	12500	5253
13543	35	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 1	12500	5254
13544	85	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 1	12500	5264
13545	78	44	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 1	12500	5276
13546	68	44	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 1	12500	5268
13547	81	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 1	12500	5279
13548	41	37	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 1	12500	5266
13549	32	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 1	12500	5277
13550	94	49	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 1	12500	5267
13551	36	31	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 1	12500	5256
13552	25	48	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 1	12500	5257
13553	94	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 1	12500	5258
13554	24	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 1	12500	5260
13555	23	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 1	12500	5269
13556	31	44	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 1	12500	5265
13557	85	39	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 1	12500	5261
13558	33	45	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 1	12500	5262
13559	37	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 1	12500	5263
13560	42	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 1	12500	5275
13561	92	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 0	13651	5254
13562	61	45	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 0	13651	5280
13563	31	50	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 0	13651	5267
13564	96	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 0	13651	5251
13565	41	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 0	13651	5253
13566	73	30	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 0	13651	5256
13567	79	50	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 0	13651	5257
13568	39	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 0	13651	5258
13569	75	40	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 0	13651	5265
13570	40	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 0	13651	5269
13571	43	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 0	13651	5260
13572	41	39	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 0	13651	5268
13573	63	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 0	13651	5264
13574	24	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 0	13651	5277
13575	55	49	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 0	13651	5261
13576	26	49	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 0	13651	5266
13577	70	47	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 0	13651	5276
13578	77	45	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 0	13651	5262
13579	87	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 0	13651	5279
13580	66	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 0	13651	5263
13581	69	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 0	13651	5275
13582	45	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 1	13652	5258
13583	40	32	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 1	13652	5280
13584	36	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 1	13652	5251
13585	96	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 1	13652	5253
13586	55	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 1	13652	5254
13587	29	42	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 1	13652	5256
13588	56	43	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 1	13652	5257
13589	23	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 1	13652	5260
13590	50	49	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 1	13652	5261
13591	65	32	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 1	13652	5276
13592	66	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 1	13652	5275
13593	46	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 1	13652	5279
13594	28	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 1	13652	5264
13595	55	48	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 1	13652	5265
13596	52	41	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 1	13652	5266
13597	34	31	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 1	13652	5267
13598	78	50	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 1	13652	5268
13599	22	37	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 1	13652	5262
13600	76	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 1	13652	5277
13701	22	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 1	13652	5269
13702	88	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 1	13652	5263
13703	68	42	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 0	13653	5256
13704	48	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 0	13653	5253
13705	67	33	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 0	13653	5280
13706	67	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 0	13653	5251
13707	100	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 0	13653	5254
13708	31	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 0	13653	5269
13709	92	41	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 0	13653	5257
13710	65	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 0	13653	5258
13711	80	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 0	13653	5260
13712	76	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 0	13653	5279
13713	29	49	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 0	13653	5265
13714	85	46	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 0	13653	5267
13715	21	31	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 0	13653	5261
13716	96	46	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 0	13653	5268
13717	86	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 0	13653	5277
13718	40	42	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 0	13653	5262
13719	48	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 0	13653	5275
13720	23	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 0	13653	5263
13721	46	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 0	13653	5264
13722	26	33	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 0	13653	5266
13723	53	34	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 0	13653	5276
13724	47	35	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 1	13654	5280
13725	47	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 1	13654	5251
13726	29	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 1	13654	5253
13727	36	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 1	13654	5254
13728	29	31	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 1	13654	5266
13729	23	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 1	13654	5277
13730	81	49	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 1	13654	5265
13731	27	36	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 1	13654	5267
13732	93	40	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 1	13654	5256
13733	45	46	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 1	13654	5257
13734	88	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 1	13654	5258
13735	90	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 1	13654	5260
13736	54	34	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 1	13654	5261
13737	70	43	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 1	13654	5262
13738	89	33	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 1	13654	5268
13739	80	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 1	13654	5263
13740	48	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 1	13654	5279
13741	31	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 1	13654	5264
13742	71	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 1	13654	5269
13743	45	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 1	13654	5275
13744	35	33	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 1	13654	5276
13745	32	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 0	13655	5253
13746	49	49	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 0	13655	5280
13747	91	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 0	13655	5251
13748	93	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 0	13655	5254
13749	57	31	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 0	13655	5256
13750	24	46	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 0	13655	5257
13751	93	39	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 0	13655	5267
13752	50	34	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 0	13655	5265
13753	20	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 0	13655	5258
13754	85	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 0	13655	5260
13755	75	49	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 0	13655	5268
13756	93	30	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 0	13655	5261
13757	35	34	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 0	13655	5262
13758	60	33	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 0	13655	5276
13759	79	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 0	13655	5275
13760	76	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 0	13655	5279
13761	36	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 0	13655	5263
13762	72	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 0	13655	5264
13763	37	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 0	13655	5277
13764	86	41	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 0	13655	5266
13765	22	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 0	13655	5269
13766	49	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 1	13656	5251
13767	78	43	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 1	13656	5280
13768	81	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 1	13656	5253
13769	93	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 1	13656	5254
13770	63	48	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 1	13656	5256
13771	36	36	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 1	13656	5257
13772	56	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 1	13656	5277
13773	87	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 1	13656	5279
13774	65	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 1	13656	5258
13775	94	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 1	13656	5260
13776	23	31	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 1	13656	5276
13777	48	33	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 1	13656	5265
13778	82	34	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 1	13656	5266
13779	97	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 1	13656	5269
13780	77	43	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 1	13656	5267
13781	20	32	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 1	13656	5261
13782	25	45	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 1	13656	5262
13783	58	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 1	13656	5275
13784	36	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 1	13656	5263
13785	48	33	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 1	13656	5268
13786	35	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 1	13656	5264
13787	55	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 0	13657	5251
13788	63	41	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 0	13657	5280
13789	73	39	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 0	13657	5267
13790	46	41	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 0	13657	5266
13791	47	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 0	13657	5279
13792	20	33	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 0	13657	5276
13793	29	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 0	13657	5253
13794	42	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 0	13657	5275
13795	61	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 0	13657	5269
13796	47	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 0	13657	5254
13797	94	36	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 0	13657	5256
13798	50	41	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 0	13657	5257
13799	61	48	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 0	13657	5268
13800	80	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 0	13657	5277
13801	75	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 0	13657	5258
13802	73	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 0	13657	5260
13803	61	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 0	13657	5264
13804	37	33	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 0	13657	5261
13805	38	33	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 0	13657	5262
13806	79	39	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 0	13657	5265
13807	21	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 0	13657	5263
13808	54	33	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 1	13658	5280
13809	64	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 1	13658	5251
13810	80	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 1	13658	5253
13811	54	37	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 1	13658	5265
13812	71	46	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 1	13658	5276
13813	66	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 1	13658	5254
13814	83	34	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 1	13658	5256
13815	55	34	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 1	13658	5268
13816	93	30	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 1	13658	5266
13817	37	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 1	13658	5279
13818	33	46	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 1	13658	5257
13819	44	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 1	13658	5258
13820	89	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 1	13658	5260
13821	26	32	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 1	13658	5261
13822	78	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 1	13658	5264
13823	60	43	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 1	13658	5262
13824	65	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 1	13658	5277
13825	42	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 1	13658	5275
13826	71	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 1	13658	5263
13827	85	33	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 1	13658	5267
13828	95	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 1	13658	5269
13829	35	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 0	13659	5254
13830	40	46	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 0	13659	5280
13831	54	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 0	13659	5279
13832	80	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 0	13659	5251
13833	39	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 0	13659	5253
13834	69	40	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 0	13659	5266
13835	45	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 0	13659	5275
13836	55	36	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 0	13659	5256
13837	48	49	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 0	13659	5257
13838	70	48	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 0	13659	5268
13839	72	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 0	13659	5277
13840	25	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 0	13659	5258
13841	31	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 0	13659	5260
13842	65	46	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 0	13659	5261
13843	39	49	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 0	13659	5267
13844	34	45	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 0	13659	5262
13845	29	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 0	13659	5269
13846	23	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 0	13659	5264
13847	64	47	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 0	13659	5276
13848	78	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 0	13659	5263
13849	93	45	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 0	13659	5265
13850	91	42	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 1	13660	5257
13851	81	30	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 1	13660	5280
13852	40	30	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 1	13660	5265
13853	76	39	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 1	13660	5276
13854	21	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 1	13660	5277
13855	51	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 1	13660	5251
13856	70	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 1	13660	5253
13857	79	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 1	13660	5254
13858	79	39	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 1	13660	5256
13859	58	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 1	13660	5258
13860	45	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 1	13660	5264
13861	51	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 1	13660	5279
13862	21	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 1	13660	5260
13863	98	31	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 1	13660	5267
13864	91	37	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 1	13660	5268
13865	69	43	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 1	13660	5261
13866	56	43	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 1	13660	5262
13867	91	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 1	13660	5263
13868	20	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 1	13660	5269
13869	35	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 1	13660	5275
13870	98	35	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 1	13660	5266
13871	79	42	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 0	13661	5257
13872	49	41	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 0	13661	5280
13873	80	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 0	13661	5251
13874	22	47	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 0	13661	5276
13875	84	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 0	13661	5279
13876	87	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 0	13661	5269
13877	74	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 0	13661	5253
13878	50	36	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 0	13661	5265
13879	55	38	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 0	13661	5266
13880	94	39	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 0	13661	5268
13881	97	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 0	13661	5254
13882	31	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 0	13661	5264
13883	45	50	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 0	13661	5256
13884	67	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 0	13661	5258
13885	95	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 0	13661	5277
13886	81	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 0	13661	5260
13887	32	37	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 0	13661	5261
13888	57	34	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 0	13661	5262
13889	40	31	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 0	13661	5267
13890	23	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 0	13661	5275
13891	47	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 0	13661	5263
13892	38	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 1	13662	5253
13893	68	46	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 1	13662	5280
13894	84	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 1	13662	5251
13895	64	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 1	13662	5275
13896	76	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 1	13662	5254
13897	68	43	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 1	13662	5256
13898	39	38	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 1	13662	5257
13899	42	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 1	13662	5264
13900	39	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 1	13662	5258
13901	61	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 1	13662	5260
13902	23	38	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 1	13662	5276
13903	87	45	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 1	13662	5261
13904	85	44	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 1	13662	5262
13905	60	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 1	13662	5263
13906	89	34	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 1	13662	5266
13907	92	34	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 1	13662	5268
13908	74	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 1	13662	5279
13909	26	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 1	13662	5277
13910	100	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 1	13662	5269
13911	35	30	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 1	13662	5267
13912	48	33	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 1	13662	5265
13913	87	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 0	13663	5253
13914	63	43	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 0	13663	5280
13915	82	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 0	13663	5251
13916	100	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 0	13663	5254
13917	69	43	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 0	13663	5276
13918	50	30	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 0	13663	5266
13919	84	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 0	13663	5275
13920	25	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 0	13663	5277
13921	78	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 0	13663	5279
13922	40	46	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 0	13663	5268
13923	64	36	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 0	13663	5256
13924	98	32	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 0	13663	5257
13925	48	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 0	13663	5258
13926	20	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 0	13663	5260
13927	95	38	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 0	13663	5261
13928	41	44	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 0	13663	5262
13929	57	33	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 0	13663	5267
13930	68	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 0	13663	5263
13931	90	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 0	13663	5264
13932	52	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 0	13663	5269
13933	100	49	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 0	13663	5265
13934	94	43	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 1	13664	5261
13935	24	41	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 1	13664	5280
13936	24	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 1	13664	5251
13937	23	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 1	13664	5253
13938	89	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 1	13664	5264
13939	71	33	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 1	13664	5267
13940	23	34	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 1	13664	5268
13941	33	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 1	13664	5277
13942	56	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 1	13664	5254
13943	93	45	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 1	13664	5265
13944	40	49	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 1	13664	5266
13945	47	36	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 1	13664	5256
13946	99	30	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 1	13664	5257
13947	29	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 1	13664	5275
13948	66	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 1	13664	5279
13949	43	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 1	13664	5269
13950	58	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 1	13664	5258
13951	45	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 1	13664	5260
13952	82	32	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 1	13664	5262
13953	83	35	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 1	13664	5276
13954	34	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 1	13664	5263
13955	22	48	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 0	13665	5257
13956	81	39	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 0	13665	5280
13957	82	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 0	13665	5251
13958	93	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 0	13665	5253
13959	85	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 0	13665	5254
13960	83	44	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 0	13665	5256
13961	91	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 0	13665	5279
13962	83	39	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 0	13665	5276
13963	91	41	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 0	13665	5266
13964	44	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 0	13665	5269
13965	86	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 0	13665	5277
13966	48	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 0	13665	5258
13967	81	34	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 0	13665	5265
13968	81	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 0	13665	5260
13969	30	36	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 0	13665	5261
13970	30	31	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 0	13665	5262
13971	93	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 0	13665	5264
13972	99	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 0	13665	5263
13973	66	39	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 0	13665	5267
13974	52	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 0	13665	5275
13975	21	34	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 0	13665	5268
13976	40	50	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 1	13666	5256
13977	97	30	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 1	13666	5280
13978	92	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 1	13666	5251
13979	57	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 1	13666	5275
13980	77	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 1	13666	5253
13981	73	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 1	13666	5277
13982	91	42	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 1	13666	5276
13983	33	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 1	13666	5279
13984	88	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 1	13666	5254
13985	99	36	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 1	13666	5257
13986	76	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 1	13666	5258
13987	77	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 1	13666	5260
13988	46	41	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 1	13666	5261
13989	30	50	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 1	13666	5268
13990	81	30	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 1	13666	5262
13991	34	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 1	13666	5263
13992	80	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 1	13666	5264
13993	26	49	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 1	13666	5267
13994	47	40	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 1	13666	5265
13995	65	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 1	13666	5269
13996	77	40	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 1	13666	5266
13997	58	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 0	13667	5251
13998	65	47	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 0	13667	5280
13999	100	48	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 0	13667	5268
14000	93	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 0	13667	5279
14001	95	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 0	13667	5253
14002	76	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 0	13667	5254
14003	86	50	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 0	13667	5276
14004	81	37	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 0	13667	5256
14005	24	41	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 0	13667	5257
14006	51	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 0	13667	5258
14007	65	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 0	13667	5260
14008	68	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 0	13667	5264
14009	100	32	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 0	13667	5261
14010	54	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 0	13667	5277
14011	78	45	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 0	13667	5262
14012	82	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 0	13667	5269
14013	89	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 0	13667	5263
14014	73	33	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 0	13667	5267
14015	81	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 0	13667	5275
14016	33	40	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 0	13667	5266
14017	20	50	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 0	13667	5265
14018	73	44	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 1	13668	5280
14019	84	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 1	13668	5251
14020	91	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 1	13668	5253
14021	28	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 1	13668	5254
14022	96	49	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 1	13668	5256
14023	54	48	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 1	13668	5257
14024	44	41	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 1	13668	5265
14025	76	40	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 1	13668	5276
14026	100	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 1	13668	5258
14027	50	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 1	13668	5279
14028	47	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 1	13668	5260
14029	99	32	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 1	13668	5261
14030	45	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 1	13668	5277
14031	73	33	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 1	13668	5266
14032	67	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 1	13668	5269
14033	68	30	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 1	13668	5268
14034	67	41	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 1	13668	5262
14035	42	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 1	13668	5264
14036	25	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 1	13668	5275
14037	71	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 1	13668	5263
14038	84	47	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 1	13668	5267
14039	82	48	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 0	13669	5257
14040	22	41	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 0	13669	5280
14041	58	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 0	13669	5251
14042	82	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 0	13669	5253
14043	33	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 0	13669	5277
14044	79	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 0	13669	5254
14045	59	35	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 0	13669	5276
14046	82	46	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 0	13669	5265
14047	90	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 0	13669	5279
14048	90	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 0	13669	5275
14049	37	40	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 0	13669	5267
14050	63	44	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 0	13669	5256
14051	100	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 0	13669	5258
14052	46	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 0	13669	5264
14053	77	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 0	13669	5260
14054	49	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 0	13669	5269
14055	72	36	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 0	13669	5261
14056	89	35	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 0	13669	5266
14057	63	36	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 0	13669	5262
14058	90	38	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 0	13669	5268
14059	68	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 0	13669	5263
14060	77	38	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 1	13670	5280
14061	35	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 1	13670	5251
14062	39	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 1	13670	5253
14063	40	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 1	13670	5254
14064	50	49	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 1	13670	5256
14065	55	46	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 1	13670	5267
14066	63	34	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 1	13670	5257
14067	45	34	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 1	13670	5276
14068	52	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 1	13670	5277
14069	76	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 1	13670	5279
14070	64	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 1	13670	5258
14071	28	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 1	13670	5260
14072	61	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 1	13670	5275
14073	22	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 1	13670	5264
14074	71	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 1	13670	5269
14075	46	39	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 1	13670	5261
14076	72	42	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 1	13670	5266
14077	71	45	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 1	13670	5268
14078	41	34	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 1	13670	5262
14079	81	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 1	13670	5263
14080	94	38	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 1	13670	5265
14081	24	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 0	13671	5254
14082	69	30	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 0	13671	5280
14083	73	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 0	13671	5251
14084	25	42	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 0	13671	5268
14085	89	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 0	13671	5253
14086	100	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 0	13671	5279
14087	83	50	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 0	13671	5256
14088	100	50	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 0	13671	5257
14089	75	45	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 0	13671	5265
14090	92	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 0	13671	5275
14091	93	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 0	13671	5264
14092	85	45	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 0	13671	5267
14093	34	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 0	13671	5258
14094	59	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 0	13671	5260
14095	48	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 0	13671	5277
14096	84	33	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 0	13671	5261
14097	60	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 0	13671	5269
14098	59	32	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 0	13671	5276
14099	20	37	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 0	13671	5262
14100	62	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 0	13671	5263
14101	46	44	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 0	13671	5266
14102	86	49	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 1	13672	5280
14103	51	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 1	13672	5251
14104	67	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 1	13672	5253
14105	78	43	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 1	13672	5266
14106	96	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 1	13672	5277
14107	22	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 1	13672	5269
14108	63	36	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 1	13672	5276
14109	87	39	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 1	13672	5267
14110	97	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 1	13672	5254
14111	34	31	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 1	13672	5256
14112	88	48	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 1	13672	5257
14113	60	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 1	13672	5275
14114	93	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 1	13672	5258
14115	64	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 1	13672	5260
14116	30	35	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 1	13672	5261
14117	26	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 1	13672	5279
14118	52	30	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 1	13672	5262
14119	76	30	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 1	13672	5265
14120	47	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 1	13672	5263
14121	71	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 1	13672	5264
14122	46	33	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 1	13672	5268
14123	36	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 0	13673	5253
14124	32	34	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 0	13673	5280
14125	93	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 0	13673	5251
14126	24	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 0	13673	5269
14127	47	46	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 0	13673	5267
14128	21	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 0	13673	5264
14129	29	31	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 0	13673	5265
14130	41	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 0	13673	5277
14131	85	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 0	13673	5254
14132	64	30	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 0	13673	5256
14133	27	49	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 0	13673	5268
14134	99	39	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 0	13673	5257
14135	45	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 0	13673	5258
14136	45	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 0	13673	5260
14137	77	41	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 0	13673	5261
14138	47	48	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 0	13673	5262
14139	58	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 0	13673	5275
14140	48	48	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 0	13673	5276
14141	49	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 0	13673	5279
14142	50	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 0	13673	5263
14143	60	46	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 0	13673	5266
14144	54	32	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 1	13674	5257
14145	59	43	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 1	13674	5280
14146	82	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 1	13674	5251
14147	94	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 1	13674	5264
14148	65	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 1	13674	5253
14149	21	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 1	13674	5279
14150	53	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 1	13674	5254
14151	80	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 1	13674	5275
14152	39	48	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 1	13674	5276
14153	50	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 1	13674	5269
14154	95	34	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 1	13674	5256
14155	45	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 1	13674	5258
14156	29	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 1	13674	5260
14157	39	38	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 1	13674	5267
14158	43	45	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 1	13674	5265
14159	96	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 1	13674	5277
14160	99	44	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 1	13674	5261
14161	59	45	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 1	13674	5262
14162	73	49	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 1	13674	5266
14163	20	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 1	13674	5263
14164	96	49	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 1	13674	5268
14165	76	39	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 0	13675	5280
14166	81	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 0	13675	5253
14167	20	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 0	13675	5251
14168	85	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 0	13675	5279
14169	91	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 0	13675	5254
14170	82	47	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 0	13675	5276
14171	70	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 0	13675	5277
14172	26	42	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 0	13675	5256
14173	61	49	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 0	13675	5257
14174	72	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 0	13675	5258
14175	37	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 0	13675	5260
14176	80	50	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 0	13675	5266
14177	87	34	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 0	13675	5267
14178	85	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 0	13675	5269
14179	39	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 0	13675	5264
14180	25	41	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 0	13675	5268
14181	43	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 0	13675	5275
14182	21	42	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 0	13675	5265
14183	38	40	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 0	13675	5261
14184	71	31	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 0	13675	5262
14185	79	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 0	13675	5263
14186	57	34	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 1	13676	5256
14187	33	47	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 1	13676	5280
14188	43	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 1	13676	5251
14189	22	37	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 1	13676	5267
14190	22	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 1	13676	5253
14191	71	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 1	13676	5277
14192	43	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 1	13676	5269
14193	51	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 1	13676	5275
14194	52	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 1	13676	5254
14195	42	41	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 1	13676	5257
14196	77	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 1	13676	5258
14197	53	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 1	13676	5260
14198	64	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 1	13676	5264
14199	61	31	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 1	13676	5266
14200	94	40	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 1	13676	5261
14201	41	44	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 1	13676	5262
14202	61	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 1	13676	5263
14203	62	35	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 1	13676	5276
14204	31	40	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 1	13676	5265
14205	76	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 1	13676	5279
14206	57	30	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 1	13676	5268
14207	35	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 0	13677	5253
14208	51	35	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 0	13677	5280
14209	74	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 0	13677	5251
14210	95	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 0	13677	5254
14211	86	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 0	13677	5264
14212	32	31	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 0	13677	5268
14213	96	50	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 0	13677	5267
14214	98	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 0	13677	5269
14215	78	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 0	13677	5277
14216	74	31	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 0	13677	5256
14217	46	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 0	13677	5279
14218	42	38	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 0	13677	5265
14219	39	43	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 0	13677	5257
14220	29	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 0	13677	5258
14221	60	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 0	13677	5275
14222	85	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 0	13677	5260
14223	66	33	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 0	13677	5261
14224	36	49	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 0	13677	5262
14225	89	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 0	13677	5263
14226	92	46	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 0	13677	5266
14227	41	30	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 0	13677	5276
14228	73	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 1	13678	5251
14229	66	43	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 1	13678	5280
14230	91	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 1	13678	5253
14231	30	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 1	13678	5269
14232	59	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 1	13678	5275
14233	77	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 1	13678	5254
14234	82	39	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 1	13678	5256
14235	36	42	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 1	13678	5257
14236	97	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 1	13678	5258
14237	80	44	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 1	13678	5266
14238	23	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 1	13678	5279
14239	66	46	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 1	13678	5265
14240	76	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 1	13678	5260
14241	88	31	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 1	13678	5261
14242	44	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 1	13678	5277
14243	60	47	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 1	13678	5262
14244	73	38	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 1	13678	5267
14245	39	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 1	13678	5263
14246	56	40	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 1	13678	5276
14247	84	38	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 1	13678	5268
14248	26	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 1	13678	5264
14249	95	36	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 0	13679	5256
14250	71	38	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 0	13679	5280
14251	54	50	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 0	13679	5265
14252	58	30	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 0	13679	5276
14253	45	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 0	13679	5251
14254	60	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 0	13679	5253
14255	92	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 0	13679	5254
14256	75	49	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 0	13679	5257
14257	34	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 0	13679	5258
14258	55	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 0	13679	5260
14259	31	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 0	13679	5264
14260	81	39	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 0	13679	5261
14261	71	37	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 0	13679	5262
14262	23	50	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 0	13679	5268
14263	90	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 0	13679	5263
14264	53	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 0	13679	5275
14265	97	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 0	13679	5279
14266	34	32	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 0	13679	5267
14267	93	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 0	13679	5269
14268	26	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 0	13679	5277
14269	68	46	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 0	13679	5266
14270	39	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 1	13680	5251
14271	61	43	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 1	13680	5280
14272	46	33	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 1	13680	5268
14273	87	37	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 1	13680	5276
14274	21	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 1	13680	5253
14275	23	44	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 1	13680	5267
14276	87	44	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 1	13680	5266
14277	50	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 1	13680	5279
14278	91	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 1	13680	5254
14279	97	49	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 1	13680	5256
14280	21	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 1	13680	5277
14281	86	34	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 1	13680	5265
14282	43	33	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 1	13680	5257
14283	25	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 1	13680	5258
14284	90	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 1	13680	5264
14285	47	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 1	13680	5260
14286	67	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 1	13680	5269
14287	49	50	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 1	13680	5261
14288	100	32	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 1	13680	5262
14289	82	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 1	13680	5263
14290	44	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 1	13680	5275
14291	30	39	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 0	13681	5256
14292	91	40	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 0	13681	5280
14293	44	42	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 0	13681	5266
14294	75	50	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 0	13681	5276
14295	46	35	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 0	13681	5265
14296	25	31	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 0	13681	5267
14297	72	36	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 0	13681	5268
14298	69	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 0	13681	5251
14299	92	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 0	13681	5253
14300	89	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 0	13681	5254
14301	75	49	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 0	13681	5257
14302	40	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 0	13681	5279
14303	46	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 0	13681	5258
14304	76	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 0	13681	5260
14305	82	32	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 0	13681	5261
14306	38	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 0	13681	5264
14307	29	42	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 0	13681	5262
14308	91	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 0	13681	5275
14309	31	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 0	13681	5277
14310	97	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 0	13681	5269
14311	49	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 0	13681	5263
14312	72	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 1	13682	5251
14313	76	36	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 1	13682	5280
14314	73	36	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 1	13682	5266
14315	94	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 1	13682	5253
14316	87	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 1	13682	5254
14317	34	40	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 1	13682	5256
14318	24	35	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 1	13682	5257
14319	75	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 1	13682	5258
14320	90	48	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 1	13682	5276
14321	56	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 1	13682	5260
14322	99	32	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 1	13682	5267
14323	63	44	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 1	13682	5261
14324	47	48	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 1	13682	5262
14325	34	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 1	13682	5264
14326	49	43	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 1	13682	5265
14327	83	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 1	13682	5275
14328	44	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 1	13682	5277
14329	44	35	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 1	13682	5268
14330	65	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 1	13682	5263
14331	39	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 1	13682	5269
14332	46	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 1	13682	5279
14333	92	46	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 0	13683	5256
14334	58	38	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 0	13683	5280
14335	83	49	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 0	13683	5267
14336	80	37	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 0	13683	5276
14337	90	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 0	13683	5251
14338	80	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 0	13683	5253
14339	42	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 0	13683	5254
14340	61	48	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 0	13683	5257
14341	40	47	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 0	13683	5268
14342	86	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 0	13683	5258
14343	82	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 0	13683	5260
14344	72	42	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 0	13683	5261
14345	98	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 0	13683	5275
14346	100	44	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 0	13683	5265
14347	40	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 0	13683	5279
14348	45	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 0	13683	5264
14349	40	48	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 0	13683	5262
14350	23	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 0	13683	5269
14351	45	48	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 0	13683	5266
14352	88	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 0	13683	5277
14353	38	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 0	13683	5263
14354	34	32	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 1	13684	5256
14355	27	41	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 1	13684	5280
14356	64	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 1	13684	5251
14357	85	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 1	13684	5269
14358	54	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 1	13684	5253
14359	83	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 1	13684	5254
14360	97	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 1	13684	5279
14361	47	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 1	13684	5277
14362	54	35	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 1	13684	5257
14363	68	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 1	13684	5258
14364	95	49	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 1	13684	5267
14365	58	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 1	13684	5260
14366	36	37	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 1	13684	5261
14367	35	45	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 1	13684	5265
14368	38	45	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 1	13684	5266
14369	97	48	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 1	13684	5268
14370	64	42	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 1	13684	5276
14371	68	31	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 1	13684	5262
14372	43	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 1	13684	5275
14373	34	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 1	13684	5263
14374	63	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 1	13684	5264
14375	20	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 0	13685	5258
14376	65	46	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 0	13685	5280
14377	80	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 0	13685	5251
14378	33	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 0	13685	5253
14379	55	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 0	13685	5254
14380	51	48	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 0	13685	5256
14381	92	36	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 0	13685	5267
14382	28	36	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 0	13685	5276
14383	27	39	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 0	13685	5257
14384	40	34	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 0	13685	5265
14385	51	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 0	13685	5277
14386	45	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 0	13685	5260
14387	29	45	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 0	13685	5261
14388	44	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 0	13685	5275
14389	63	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 0	13685	5279
14390	98	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 0	13685	5264
14391	91	35	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 0	13685	5266
14392	27	43	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 0	13685	5268
14393	48	40	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 0	13685	5262
14394	62	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 0	13685	5269
14395	31	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 0	13685	5263
14396	43	38	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 1	13686	5280
14397	28	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 1	13686	5251
14398	88	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 1	13686	5253
14399	40	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 1	13686	5254
14400	99	37	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 1	13686	5268
14401	92	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 1	13686	5264
14402	65	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 1	13686	5275
14403	33	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 1	13686	5277
14404	61	42	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 1	13686	5256
14405	68	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 1	13686	5269
14406	20	46	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 1	13686	5257
14407	24	35	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 1	13686	5267
14408	79	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 1	13686	5258
14409	63	37	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 1	13686	5276
14410	20	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 1	13686	5260
14411	42	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 1	13686	5279
14412	43	43	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 1	13686	5261
14413	53	33	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 1	13686	5266
14414	84	50	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 1	13686	5262
14415	92	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 1	13686	5263
14416	34	48	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 1	13686	5265
14417	52	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 0	13687	5251
14418	27	31	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 0	13687	5280
14419	70	46	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 0	13687	5266
14420	97	45	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 0	13687	5268
14421	62	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 0	13687	5253
14422	28	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 0	13687	5254
14423	36	37	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 0	13687	5267
14424	22	47	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 0	13687	5256
14425	83	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 0	13687	5269
14426	84	30	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 0	13687	5276
14427	81	40	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 0	13687	5257
14428	35	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 0	13687	5258
14429	90	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 0	13687	5264
14430	89	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 0	13687	5279
14431	55	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 0	13687	5260
14432	26	43	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 0	13687	5261
14433	29	44	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 0	13687	5262
14434	23	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 0	13687	5277
14435	22	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 0	13687	5275
14436	36	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 0	13687	5263
14437	65	48	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 0	13687	5265
14438	45	50	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 1	13688	5257
14439	44	31	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 1	13688	5280
14440	26	43	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 1	13688	5276
14441	59	34	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 1	13688	5268
14442	44	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 1	13688	5251
14443	51	36	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 1	13688	5267
14444	48	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 1	13688	5253
14445	35	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 1	13688	5254
14446	43	30	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 1	13688	5256
14447	38	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 1	13688	5258
14448	90	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 1	13688	5277
14449	24	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 1	13688	5275
14450	35	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 1	13688	5279
14451	23	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 1	13688	5260
14452	79	40	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 1	13688	5261
14453	63	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 1	13688	5264
14454	77	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 1	13688	5269
14455	61	35	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 1	13688	5266
14456	35	34	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 1	13688	5262
14457	36	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 1	13688	5263
14458	38	39	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 1	13688	5265
14459	61	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 0	13689	5254
14460	53	31	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 0	13689	5280
14461	39	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 0	13689	5264
14462	93	33	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 0	13689	5266
14463	60	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 0	13689	5251
14464	56	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 0	13689	5253
14465	21	36	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 0	13689	5256
14466	54	39	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 0	13689	5257
14467	97	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 0	13689	5275
14468	22	44	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 0	13689	5267
14469	71	47	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 0	13689	5276
14470	90	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 0	13689	5277
14471	68	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 0	13689	5258
14472	48	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 0	13689	5260
14473	27	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 0	13689	5279
14474	100	50	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 0	13689	5261
14475	21	37	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 0	13689	5262
14476	23	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 0	13689	5263
14477	76	39	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 0	13689	5268
14478	35	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 0	13689	5269
14479	98	38	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 0	13689	5265
14480	41	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 1	13690	5253
14481	86	36	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 1	13690	5280
14482	36	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 1	13690	5251
14483	79	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 1	13690	5254
14484	96	42	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 1	13690	5256
14485	86	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 1	13690	5264
14486	50	46	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 1	13690	5257
14487	95	34	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 1	13690	5276
14488	53	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 1	13690	5269
14489	84	32	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 1	13690	5266
14490	64	36	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 1	13690	5267
14491	30	45	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 1	13690	5268
14492	53	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 1	13690	5279
14493	99	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 1	13690	5258
14494	29	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 1	13690	5260
14495	72	46	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 1	13690	5261
14496	28	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 1	13690	5277
14497	58	33	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 1	13690	5262
14498	24	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 1	13690	5263
14499	42	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 1	13690	5275
14500	57	50	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 1	13690	5265
14501	27	40	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 0	13691	5257
14502	60	37	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 0	13691	5280
14503	73	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 0	13691	5251
14504	79	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 0	13691	5253
14505	55	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 0	13691	5275
14506	40	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 0	13691	5254
14507	27	48	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 0	13691	5256
14508	69	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 0	13691	5277
14509	34	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 0	13691	5258
14510	70	41	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 0	13691	5268
14511	90	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 0	13691	5260
14512	30	34	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 0	13691	5267
14513	64	46	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 0	13691	5261
14514	67	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 0	13691	5264
14515	62	32	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 0	13691	5265
14516	84	50	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 0	13691	5266
14517	99	32	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 0	13691	5262
14518	71	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 0	13691	5279
14519	53	46	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 0	13691	5276
14520	46	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 0	13691	5263
14521	97	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 0	13691	5269
14522	50	45	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 1	13692	5261
14523	29	47	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 1	13692	5280
14524	53	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 1	13692	5251
14525	83	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 1	13692	5264
14526	53	50	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 1	13692	5276
14527	89	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 1	13692	5253
14528	50	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 1	13692	5275
14529	73	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 1	13692	5254
14530	91	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 1	13692	5269
14531	95	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 1	13692	5277
14532	88	37	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 1	13692	5256
14533	62	42	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 1	13692	5257
14534	76	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 1	13692	5258
14535	32	42	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 1	13692	5266
14536	93	33	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 1	13692	5265
14537	70	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 1	13692	5279
14538	87	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 1	13692	5260
14539	24	38	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 1	13692	5262
14540	25	36	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 1	13692	5268
14541	50	35	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 1	13692	5267
14542	22	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 1	13692	5263
14543	53	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 0	13693	5254
14544	54	47	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 0	13693	5280
14545	79	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 0	13693	5251
14546	27	30	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 0	13693	5268
14547	44	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 0	13693	5279
14548	47	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 0	13693	5264
14549	44	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 0	13693	5269
14550	54	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 0	13693	5275
14551	41	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 0	13693	5253
14552	38	50	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 0	13693	5256
14553	85	42	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 0	13693	5257
14554	100	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 0	13693	5258
14555	41	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 0	13693	5260
14556	83	41	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 0	13693	5261
14557	63	39	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 0	13693	5267
14558	82	35	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 0	13693	5265
14559	60	45	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 0	13693	5266
14560	42	42	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 0	13693	5262
14561	90	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 0	13693	5277
14562	84	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 0	13693	5263
14563	67	38	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 0	13693	5276
14564	93	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 1	13694	5251
14565	69	38	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 1	13694	5280
14566	27	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 1	13694	5253
14567	76	31	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 1	13694	5267
14568	32	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 1	13694	5254
14569	50	36	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 1	13694	5265
14570	70	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 1	13694	5279
14571	20	39	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 1	13694	5256
14572	38	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 1	13694	5269
14573	33	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 1	13694	5277
14574	23	34	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 1	13694	5268
14575	56	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 1	13694	5275
14576	74	35	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 1	13694	5257
14577	94	32	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 1	13694	5276
14578	80	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 1	13694	5258
14579	26	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 1	13694	5260
14580	82	34	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 1	13694	5261
14581	95	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 1	13694	5264
14582	45	34	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 1	13694	5262
14583	49	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 1	13694	5263
14584	84	49	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 1	13694	5266
14585	49	45	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 0	13695	5280
14586	56	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 0	13695	5251
14587	36	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 0	13695	5279
14588	87	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 0	13695	5269
14589	45	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 0	13695	5253
14590	79	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 0	13695	5254
14591	98	45	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 0	13695	5267
14592	28	39	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 0	13695	5276
14593	100	49	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 0	13695	5265
14594	37	34	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 0	13695	5256
14595	70	31	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 0	13695	5257
14596	58	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 0	13695	5258
14597	73	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 0	13695	5260
14598	80	41	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 0	13695	5268
14599	22	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 0	13695	5275
14600	57	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 0	13695	5264
14601	80	34	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 0	13695	5266
14602	98	31	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 0	13695	5261
14603	89	46	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 0	13695	5262
14604	34	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 0	13695	5263
14605	34	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 0	13695	5277
14606	41	31	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 1	13696	5280
14607	61	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 1	13696	5251
14608	25	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 1	13696	5253
14609	32	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 1	13696	5264
14610	71	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 1	13696	5254
14611	71	35	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 1	13696	5256
14612	52	34	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 1	13696	5257
14613	61	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 1	13696	5277
14614	89	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 1	13696	5279
14615	52	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 1	13696	5258
14616	48	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 1	13696	5260
14617	71	45	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 1	13696	5261
14618	42	45	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 1	13696	5265
14619	33	48	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 1	13696	5268
14620	65	36	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 1	13696	5262
14621	65	30	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 1	13696	5276
14622	37	33	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 1	13696	5266
14623	24	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 1	13696	5269
14624	87	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 1	13696	5275
14625	53	47	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 1	13696	5267
14626	42	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 1	13696	5263
14627	91	35	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 0	13697	5261
14628	78	36	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 0	13697	5280
14629	55	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 0	13697	5269
14630	56	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 0	13697	5251
14631	54	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 0	13697	5253
14632	38	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 0	13697	5264
14633	91	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 0	13697	5277
14634	20	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 0	13697	5254
14635	20	33	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 0	13697	5256
14636	35	48	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 0	13697	5257
14637	72	42	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 0	13697	5267
14638	90	45	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 0	13697	5276
14639	54	38	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 0	13697	5266
14640	66	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 0	13697	5258
14641	67	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 0	13697	5260
14642	96	41	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 0	13697	5262
14643	35	30	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 0	13697	5265
14644	64	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 0	13697	5263
14645	37	33	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 0	13697	5268
14646	87	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 0	13697	5275
14647	58	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 0	13697	5279
14648	47	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 1	13698	5253
14649	24	30	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 1	13698	5280
14650	30	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 1	13698	5269
14651	79	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 1	13698	5251
14652	58	37	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 1	13698	5266
14653	97	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 1	13698	5254
14654	30	49	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 1	13698	5256
14655	88	36	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 1	13698	5268
14656	46	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 1	13698	5279
14657	51	46	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 1	13698	5257
14658	77	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 1	13698	5258
14659	81	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 1	13698	5275
14660	30	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 1	13698	5260
14661	96	38	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 1	13698	5265
14662	84	45	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 1	13698	5276
14663	79	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 1	13698	5277
14664	21	34	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 1	13698	5261
14665	56	35	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 1	13698	5267
14666	95	46	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 1	13698	5262
14667	63	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 1	13698	5264
14668	23	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 1	13698	5263
14669	75	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 0	13699	5254
14670	23	31	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 0	13699	5280
14671	50	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 0	13699	5251
14672	20	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 0	13699	5253
14673	49	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 0	13699	5277
14674	96	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 0	13699	5269
14675	43	46	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 0	13699	5256
14676	87	37	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 0	13699	5257
14677	33	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 0	13699	5264
14678	28	32	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 0	13699	5267
14679	88	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 0	13699	5258
14680	54	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 0	13699	5260
14681	42	31	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 0	13699	5276
14682	80	40	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 0	13699	5265
14683	79	46	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 0	13699	5261
14684	45	30	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 0	13699	5262
14685	67	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 0	13699	5275
14686	31	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 0	13699	5279
14687	37	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 0	13699	5263
14688	74	46	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 0	13699	5266
14689	59	48	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 0	13699	5268
14690	41	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 1	13700	5251
14691	23	30	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 1	13700	5280
14692	86	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 1	13700	5253
14693	95	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 1	13700	5254
14694	83	33	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 1	13700	5276
14695	26	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 1	13700	5277
14696	40	38	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 1	13700	5265
14697	75	45	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 1	13700	5268
14698	37	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 1	13700	5269
14699	76	35	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 1	13700	5256
14700	52	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 1	13700	5275
14701	78	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 1	13700	5279
14702	100	44	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 1	13700	5257
14703	20	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 1	13700	5258
14704	99	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 1	13700	5260
14705	47	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 1	13700	5264
14706	84	39	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 1	13700	5266
14707	71	35	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 1	13700	5267
14708	46	35	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 1	13700	5261
14709	95	44	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 1	13700	5262
14710	51	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 1	13700	5263
14711	48	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 0	14801	5251
14712	55	45	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 0	14801	5280
14713	62	48	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 0	14801	5268
14714	84	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 0	14801	5275
14715	67	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 0	14801	5253
14716	75	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 0	14801	5254
14717	62	34	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 0	14801	5256
14718	31	44	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 0	14801	5257
14719	29	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 0	14801	5258
14720	26	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 0	14801	5260
14721	34	37	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 0	14801	5261
14722	50	32	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 0	14801	5267
14723	23	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 0	14801	5277
14724	60	50	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 0	14801	5266
14725	74	36	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 0	14801	5262
14726	47	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 0	14801	5264
14727	58	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 0	14801	5269
14728	20	36	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 0	14801	5276
14729	100	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 0	14801	5279
14730	59	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 0	14801	5263
14731	81	36	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 0	14801	5265
14732	90	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 1	14802	5253
14733	81	45	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 1	14802	5280
14734	78	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 1	14802	5251
14735	54	50	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 1	14802	5266
14736	90	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 1	14802	5279
14737	66	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 1	14802	5254
14738	81	31	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 1	14802	5256
14739	50	36	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 1	14802	5257
14740	59	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 1	14802	5264
14741	51	39	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 1	14802	5267
14742	97	37	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 1	14802	5268
14743	51	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 1	14802	5275
14744	100	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 1	14802	5258
14745	98	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 1	14802	5260
14746	28	48	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 1	14802	5261
14747	31	34	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 1	14802	5262
14748	64	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 1	14802	5263
14749	42	35	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 1	14802	5276
14912	71	36	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 0	14805	5262
14750	26	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 1	14802	5277
14851	28	35	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 1	14802	5265
14852	56	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 1	14802	5269
14853	91	32	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 0	14803	5261
14854	40	32	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 0	14803	5257
14855	100	32	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 0	14803	5280
14856	72	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 0	14803	5251
14857	100	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 0	14803	5253
14858	35	42	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 0	14803	5266
14859	89	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 0	14803	5254
14860	77	42	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 0	14803	5256
14861	91	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 0	14803	5258
14862	50	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 0	14803	5264
14863	32	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 0	14803	5260
14864	85	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 0	14803	5275
14865	64	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 0	14803	5269
14866	33	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 0	14803	5279
14867	29	36	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 0	14803	5276
14868	62	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 0	14803	5277
14869	80	40	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 0	14803	5265
14870	23	41	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 0	14803	5267
14871	61	38	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 0	14803	5262
14872	67	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 0	14803	5263
14873	25	36	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 0	14803	5268
14874	29	45	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 1	14804	5256
14875	45	33	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 1	14804	5280
14876	37	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 1	14804	5251
14877	87	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 1	14804	5253
14878	22	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 1	14804	5254
14879	79	39	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 1	14804	5257
14880	60	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 1	14804	5279
14881	48	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 1	14804	5275
14882	84	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 1	14804	5258
14883	37	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 1	14804	5277
14884	41	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 1	14804	5264
14885	91	31	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 1	14804	5266
14886	33	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 1	14804	5269
14887	21	43	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 1	14804	5276
14888	49	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 1	14804	5260
14889	29	49	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 1	14804	5268
14890	59	33	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 1	14804	5261
14891	83	34	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 1	14804	5265
14892	75	39	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 1	14804	5262
14893	64	37	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 1	14804	5263
14894	29	34	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 1	14804	5267
14895	94	33	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 0	14805	5280
14896	33	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 0	14805	5251
14897	49	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 0	14805	5275
14898	53	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 0	14805	5279
14899	75	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 0	14805	5253
14900	81	34	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 0	14805	5266
14901	84	32	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 0	14805	5268
14902	84	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 0	14805	5254
14903	36	44	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 0	14805	5256
14904	52	43	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 0	14805	5257
14905	95	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 0	14805	5258
14906	50	31	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 0	14805	5267
14907	75	38	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 0	14805	5265
14908	72	43	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 0	14805	5276
14909	61	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 0	14805	5277
14910	82	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 0	14805	5260
14911	90	40	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 0	14805	5261
14913	89	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 0	14805	5264
14914	74	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 0	14805	5263
14915	23	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 0	14805	5269
14916	70	31	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 1	14806	5280
14917	81	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 1	14806	5251
14918	29	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 1	14806	5253
14919	43	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 1	14806	5254
14920	35	49	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 1	14806	5256
14921	23	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 1	14806	5264
14922	100	42	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 1	14806	5266
14923	80	50	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 1	14806	5257
14924	46	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 1	14806	5279
14925	76	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 1	14806	5258
14926	57	33	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 1	14806	5276
14927	64	50	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 1	14806	5267
14928	44	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 1	14806	5260
14929	78	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 1	14806	5277
14930	53	38	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 1	14806	5261
14931	61	40	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 1	14806	5262
14932	71	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 1	14806	5263
14933	46	40	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 1	14806	5268
14934	77	40	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 1	14806	5265
14935	20	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 1	14806	5269
14936	29	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 1	14806	5275
14937	89	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 0	14807	5251
14938	35	38	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 0	14807	5280
14939	36	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 0	14807	5253
14940	36	36	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 0	14807	5276
14941	82	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 0	14807	5275
14942	50	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 0	14807	5254
14943	84	42	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 0	14807	5267
14944	40	47	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 0	14807	5256
14945	93	48	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 0	14807	5265
14946	76	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 0	14807	5269
14947	59	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 0	14807	5277
14948	35	33	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 0	14807	5257
14949	97	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 0	14807	5264
14950	25	35	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 0	14807	5268
14951	62	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 0	14807	5279
14952	60	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 0	14807	5258
14953	29	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 0	14807	5260
14954	71	49	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 0	14807	5261
14955	24	41	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 0	14807	5262
14956	68	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 0	14807	5263
14957	91	36	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 0	14807	5266
14958	99	31	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 1	14808	5251
14959	22	42	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 1	14808	5280
14960	98	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 1	14808	5264
14961	81	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 1	14808	5277
14962	54	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 1	14808	5253
14963	61	43	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 1	14808	5268
14964	81	40	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 1	14808	5265
14965	51	46	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 1	14808	5266
14966	52	38	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 1	14808	5267
14967	39	43	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 1	14808	5276
14968	63	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 1	14808	5254
14969	37	45	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 1	14808	5256
14970	58	43	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 1	14808	5257
14971	74	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 1	14808	5258
14972	33	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 1	14808	5260
14973	85	48	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 1	14808	5261
14974	85	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 1	14808	5279
14975	64	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 1	14808	5269
14976	82	47	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 1	14808	5262
14977	72	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 1	14808	5275
14978	24	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 1	14808	5263
14979	65	34	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 0	14809	5256
14980	29	49	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 0	14809	5280
14981	81	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 0	14809	5251
14982	35	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 0	14809	5253
14983	20	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 0	14809	5275
14984	24	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 0	14809	5264
14985	31	48	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 0	14809	5266
14986	29	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 0	14809	5277
14987	96	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 0	14809	5254
14988	73	46	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 0	14809	5257
14989	47	34	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 0	14809	5276
14990	32	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 0	14809	5258
14991	31	40	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 0	14809	5268
14992	30	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 0	14809	5260
14993	68	41	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 0	14809	5267
14994	41	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 0	14809	5269
14995	38	31	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 0	14809	5261
14996	76	41	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 0	14809	5262
14997	40	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 0	14809	5263
14998	41	35	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 0	14809	5265
14999	43	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 0	14809	5279
15000	81	33	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 1	14810	5280
15001	86	48	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 1	14810	5251
15002	21	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 1	14810	5277
15003	56	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 1	14810	5253
15004	34	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 1	14810	5254
15005	93	45	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 1	14810	5267
15006	28	42	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 1	14810	5256
15007	98	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 1	14810	5275
15008	20	32	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 1	14810	5257
15009	47	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 1	14810	5258
15010	72	35	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 1	14810	5266
15011	80	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 1	14810	5260
15012	38	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 1	14810	5264
15013	31	35	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 1	14810	5265
15014	55	44	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 1	14810	5261
15015	24	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 1	14810	5279
15016	81	34	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 1	14810	5262
15017	77	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 1	14810	5263
15018	25	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 1	14810	5269
15019	38	45	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 1	14810	5276
15020	87	42	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 1	14810	5268
15021	63	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 0	14811	5251
15022	26	39	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 0	14811	5280
15023	73	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 0	14811	5275
15024	85	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 0	14811	5279
15025	73	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 0	14811	5253
15026	60	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 0	14811	5254
15027	34	34	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 0	14811	5256
15028	38	31	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 0	14811	5257
15029	72	44	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 0	14811	5268
15030	69	35	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 0	14811	5266
15031	22	42	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 0	14811	5276
15032	89	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 0	14811	5277
15033	57	35	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 0	14811	5267
15034	32	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 0	14811	5264
15035	87	33	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 0	14811	5265
15036	62	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 0	14811	5258
15037	38	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 0	14811	5269
15038	82	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 0	14811	5260
15039	23	33	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 0	14811	5261
15040	34	40	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 0	14811	5262
15041	28	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 0	14811	5263
15042	94	48	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 1	14812	5256
15043	40	40	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 1	14812	5280
15044	44	44	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 1	14812	5265
15045	32	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 1	14812	5251
15046	65	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 1	14812	5253
15047	38	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 1	14812	5254
15048	73	31	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 1	14812	5257
15049	50	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 1	14812	5258
15050	58	47	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 1	14812	5267
15051	45	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 1	14812	5260
15052	73	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 1	14812	5269
15053	44	30	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 1	14812	5261
15054	47	31	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 1	14812	5262
15055	61	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 1	14812	5264
15056	79	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 1	14812	5279
15057	85	45	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 1	14812	5266
15058	82	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 1	14812	5275
15059	66	49	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 1	14812	5268
15060	72	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 1	14812	5263
15061	77	45	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 1	14812	5276
15062	63	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 1	14812	5277
15063	60	32	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 0	14813	5280
15064	98	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 0	14813	5251
15065	52	37	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 0	14813	5266
15066	74	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 0	14813	5279
15067	38	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 0	14813	5264
15068	41	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 0	14813	5253
15069	81	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 0	14813	5254
15070	39	38	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 0	14813	5256
15071	80	44	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 0	14813	5257
15072	23	44	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 0	14813	5265
15073	54	48	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 0	14813	5268
15074	54	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 0	14813	5275
15075	94	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 0	14813	5258
15076	80	35	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 0	14813	5267
15077	88	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 0	14813	5269
15078	70	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 0	14813	5277
15079	26	36	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 0	14813	5276
15080	81	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 0	14813	5260
15081	25	47	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 0	14813	5261
15082	48	47	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 0	14813	5262
15083	43	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 0	14813	5263
15084	95	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 1	14814	5260
15085	95	49	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 1	14814	5280
15086	59	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 1	14814	5251
15087	65	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 1	14814	5253
15088	40	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 1	14814	5264
15089	62	36	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 1	14814	5267
15090	58	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 1	14814	5275
15091	56	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 1	14814	5254
15092	96	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 1	14814	5269
15093	87	30	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 1	14814	5256
15094	29	50	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 1	14814	5257
15095	44	45	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 1	14814	5276
15096	70	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 1	14814	5279
15097	77	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 1	14814	5258
15098	26	39	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 1	14814	5265
15099	95	40	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 1	14814	5261
15100	35	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 1	14814	5277
15101	62	47	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 1	14814	5266
15102	81	32	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 1	14814	5262
15103	53	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 1	14814	5263
15104	45	44	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 1	14814	5268
15105	44	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 0	14815	5253
15106	56	41	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 0	14815	5280
15107	80	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 0	14815	5251
15108	32	36	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 0	14815	5268
15109	70	36	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 0	14815	5266
15110	33	49	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 0	14815	5267
15111	85	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 0	14815	5254
15112	85	44	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 0	14815	5256
15113	56	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 0	14815	5275
15114	59	41	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 0	14815	5257
15115	47	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 0	14815	5258
15116	85	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 0	14815	5260
15117	59	37	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 0	14815	5261
15118	55	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 0	14815	5269
15119	54	34	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 0	14815	5262
15120	30	40	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 0	14815	5276
15121	37	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 0	14815	5279
15122	43	35	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 0	14815	5265
15123	21	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 0	14815	5263
15124	88	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 0	14815	5264
15125	75	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 0	14815	5277
15126	80	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 1	14816	5251
15127	78	42	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 1	14816	5280
15128	68	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 1	14816	5253
15129	40	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 1	14816	5254
15130	90	44	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 1	14816	5256
15131	82	35	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 1	14816	5268
15132	55	48	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 1	14816	5267
15133	28	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 1	14816	5275
15134	97	47	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 1	14816	5257
15135	27	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 1	14816	5277
15136	35	32	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 1	14816	5266
15137	98	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 1	14816	5279
15138	58	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 1	14816	5258
15139	74	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 1	14816	5260
15140	95	35	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 1	14816	5265
15141	65	50	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 1	14816	5261
15142	99	39	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 1	14816	5276
15143	60	37	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 1	14816	5262
15144	49	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 1	14816	5263
15145	72	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 1	14816	5264
15146	29	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 1	14816	5269
15147	69	37	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 0	14817	5280
15148	88	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 0	14817	5251
15149	72	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 0	14817	5253
15150	37	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 0	14817	5275
15151	28	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 0	14817	5254
15152	73	35	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 0	14817	5266
15153	52	44	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 0	14817	5256
15154	95	44	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 0	14817	5257
15155	94	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 0	14817	5258
15156	21	48	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 0	14817	5265
15157	27	31	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 0	14817	5276
15158	23	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 0	14817	5260
15159	86	41	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 0	14817	5268
15160	49	49	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 0	14817	5261
15161	66	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 0	14817	5264
15162	77	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 0	14817	5277
15163	92	38	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 0	14817	5262
15164	74	47	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 0	14817	5267
15165	29	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 0	14817	5279
15166	24	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 0	14817	5263
15167	100	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 0	14817	5269
15168	55	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 1	14818	5263
15169	94	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 1	14818	5251
15170	32	44	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 1	14818	5280
15171	67	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 1	14818	5253
15172	25	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 1	14818	5254
15173	72	45	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 1	14818	5266
15174	100	30	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 1	14818	5276
15175	46	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 1	14818	5275
15176	75	38	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 1	14818	5267
15177	53	50	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 1	14818	5256
15178	92	43	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 1	14818	5257
15179	51	39	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 1	14818	5265
15180	24	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 1	14818	5279
15181	25	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 1	14818	5258
15182	94	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 1	14818	5269
15183	87	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 1	14818	5277
15184	82	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 1	14818	5264
15185	99	46	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 1	14818	5268
15186	39	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 1	14818	5260
15187	26	47	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 1	14818	5261
15188	51	46	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 1	14818	5262
15189	65	45	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 0	14819	5257
15190	71	40	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 0	14819	5280
15191	95	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 0	14819	5251
15192	82	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 0	14819	5253
15193	86	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 0	14819	5275
15194	83	34	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 0	14819	5266
15195	99	34	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 0	14819	5267
15196	100	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 0	14819	5264
15197	40	45	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 0	14819	5265
15198	50	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 0	14819	5254
15199	73	40	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 0	14819	5268
15200	73	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 0	14819	5277
15201	86	49	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 0	14819	5256
15202	38	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 0	14819	5258
15203	69	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 0	14819	5260
15204	60	50	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 0	14819	5261
15205	95	47	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 0	14819	5262
15206	53	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 0	14819	5263
15207	23	30	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 0	14819	5276
15208	89	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 0	14819	5279
15209	36	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 0	14819	5269
15210	98	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 1	14820	5251
15211	54	38	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 1	14820	5280
15212	74	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 1	14820	5253
15213	43	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 1	14820	5254
15214	64	44	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 1	14820	5276
15215	98	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 1	14820	5277
15216	98	45	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 1	14820	5256
15217	81	42	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 1	14820	5265
15218	60	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 1	14820	5275
15219	63	44	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 1	14820	5267
15220	75	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 1	14820	5279
15221	96	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 1	14820	5269
15222	33	50	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 1	14820	5257
15223	54	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 1	14820	5258
15224	57	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 1	14820	5260
15225	58	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 1	14820	5264
15226	85	40	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 1	14820	5261
15227	87	33	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 1	14820	5262
15228	34	34	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 1	14820	5268
15229	68	34	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 1	14820	5266
15230	80	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 1	14820	5263
15231	42	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: Jan Selinger	14821	5254
15232	66	39	Poznámka k aktivitě Výskok s míčem. Osooba: Jan Selinger	14821	5280
15233	33	36	Poznámka k aktivitě Kliky. Osooba: Jan Selinger	14821	5266
15234	57	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Jan Selinger	14821	5251
15235	45	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: Jan Selinger	14821	5253
15236	25	36	Poznámka k aktivitě Letmý start. Osooba: Jan Selinger	14821	5256
15237	40	39	Poznámka k aktivitě Slalom s míčem. Osooba: Jan Selinger	14821	5276
15238	37	32	Poznámka k aktivitě Překážková dráha. Osooba: Jan Selinger	14821	5257
15239	79	30	Poznámka k aktivitě běh 50 metrů. Osooba: Jan Selinger	14821	5268
15240	71	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: Jan Selinger	14821	5264
15241	48	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	14821	5258
15242	62	41	Poznámka k aktivitě Skok vysoký. Osooba: Jan Selinger	14821	5267
15243	85	36	Poznámka k aktivitě Žebřík s míčem. Osooba: Jan Selinger	14821	5279
15244	21	41	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	14821	5265
15245	83	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Jan Selinger	14821	5260
15246	83	32	Poznámka k aktivitě Lowa brace test. Osooba: Jan Selinger	14821	5261
15247	87	48	Poznámka k aktivitě Žebřík. Osooba: Jan Selinger	14821	5262
15248	54	\N	Poznámka k aktivitě slalom. Osooba: Jan Selinger	14821	5269
15249	79	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Jan Selinger	14821	5277
15250	32	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Jan Selinger	14821	5263
15251	27	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	14821	5275
15252	95	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: Luděk Rous	14822	5253
15253	40	40	Poznámka k aktivitě Výskok s míčem. Osooba: Luděk Rous	14822	5280
15254	31	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: Luděk Rous	14822	5251
15255	92	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: Luděk Rous	14822	5254
15256	60	34	Poznámka k aktivitě Letmý start. Osooba: Luděk Rous	14822	5256
15257	29	46	Poznámka k aktivitě Překážková dráha. Osooba: Luděk Rous	14822	5257
15258	53	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rous	14822	5258
15259	94	45	Poznámka k aktivitě Kliky. Osooba: Luděk Rous	14822	5266
15260	20	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Luděk Rous	14822	5260
15261	92	\N	Poznámka k aktivitě slalom. Osooba: Luděk Rous	14822	5269
15262	61	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Luděk Rous	14822	5277
15263	23	46	Poznámka k aktivitě Lowa brace test. Osooba: Luděk Rous	14822	5261
15264	98	39	Poznámka k aktivitě Slalom s míčem. Osooba: Luděk Rous	14822	5276
15265	48	44	Poznámka k aktivitě Žebřík. Osooba: Luděk Rous	14822	5262
15266	31	38	Poznámka k aktivitě běh 50 metrů. Osooba: Luděk Rous	14822	5268
15267	53	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rous	14822	5275
15268	77	45	Poznámka k aktivitě Žebřík s míčem. Osooba: Luděk Rous	14822	5279
15269	36	42	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rous	14822	5265
15270	20	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: Luděk Rous	14822	5264
15271	25	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: Luděk Rous	14822	5263
15272	26	31	Poznámka k aktivitě Skok vysoký. Osooba: Luděk Rous	14822	5267
15273	43	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 0	14823	5254
15274	83	30	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 0	14823	5280
15275	59	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 0	14823	5251
15276	42	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 0	14823	5253
15277	44	47	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 0	14823	5268
15278	43	35	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 0	14823	5256
15279	37	40	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	14823	5265
15280	52	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 0	14823	5277
15281	53	46	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 0	14823	5257
15282	72	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	14823	5258
15283	79	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 0	14823	5260
15284	22	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	14823	5275
15285	23	46	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 0	14823	5261
15286	32	34	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 0	14823	5266
15287	78	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 0	14823	5279
15288	46	48	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 0	14823	5262
15289	46	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 0	14823	5263
15290	66	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 0	14823	5264
15291	31	49	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 0	14823	5267
15292	41	41	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 0	14823	5276
15293	61	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 0	14823	5269
15294	96	33	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 1	14824	5261
15295	57	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 6 let úroveň 1	14824	5251
15296	55	50	Poznámka k aktivitě Výskok s míčem. Osooba: 6 let úroveň 1	14824	5280
15297	52	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 1	14824	5269
15298	99	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 1	14824	5275
15299	99	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 1	14824	5253
15300	58	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 1	14824	5254
15301	74	32	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 1	14824	5256
15302	22	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 6 let úroveň 1	14824	5264
15303	21	37	Poznámka k aktivitě běh 50 metrů. Osooba: 6 let úroveň 1	14824	5268
15304	22	47	Poznámka k aktivitě Skok vysoký. Osooba: 6 let úroveň 1	14824	5267
15305	28	49	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 1	14824	5257
15306	82	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 1	14824	5277
15307	22	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 1	14824	5258
15308	20	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 1	14824	5260
15309	47	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 6 let úroveň 1	14824	5279
15310	69	40	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 1	14824	5262
15311	65	50	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 1	14824	5276
15312	23	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 6 let úroveň 1	14824	5263
15313	81	47	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 1	14824	5265
15314	48	42	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 1	14824	5266
15315	87	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	14825	5258
15316	49	48	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 0	14825	5280
15317	34	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 0	14825	5251
15318	27	36	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	14825	5265
15319	75	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 0	14825	5264
15320	78	46	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 0	14825	5266
15321	53	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 0	14825	5253
15322	95	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 0	14825	5254
15323	41	47	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 0	14825	5256
15324	28	34	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 0	14825	5257
15325	69	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 0	14825	5269
15326	65	46	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 0	14825	5276
15327	77	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 0	14825	5260
15328	72	33	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 0	14825	5267
15329	80	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 0	14825	5279
15330	24	32	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 0	14825	5261
15331	85	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	14825	5275
15332	69	42	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 0	14825	5262
15333	80	31	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 0	14825	5268
15334	89	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 0	14825	5263
15335	97	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 0	14825	5277
15336	92	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 7 let úroveň 1	14826	5251
15337	64	36	Poznámka k aktivitě Výskok s míčem. Osooba: 7 let úroveň 1	14826	5280
15338	81	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 1	14826	5253
15339	86	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 1	14826	5254
15340	51	31	Poznámka k aktivitě běh 50 metrů. Osooba: 7 let úroveň 1	14826	5268
15341	55	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 1	14826	5275
15342	43	48	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 1	14826	5266
15343	93	42	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 1	14826	5256
15344	57	46	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 1	14826	5257
15345	28	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 1	14826	5258
15346	61	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 1	14826	5260
15347	34	41	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 1	14826	5276
15348	32	48	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 1	14826	5261
15349	46	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 7 let úroveň 1	14826	5279
15350	65	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 1	14826	5277
15351	45	41	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 1	14826	5265
15352	22	49	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 1	14826	5262
15353	72	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 1	14826	5269
15354	84	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 7 let úroveň 1	14826	5264
15355	51	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 7 let úroveň 1	14826	5263
15356	93	30	Poznámka k aktivitě Skok vysoký. Osooba: 7 let úroveň 1	14826	5267
15357	59	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 0	14827	5253
15358	98	49	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 0	14827	5280
15359	27	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 0	14827	5251
15360	61	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 0	14827	5254
15361	51	47	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 0	14827	5256
15362	34	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 0	14827	5264
15363	63	50	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 0	14827	5268
15364	80	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 0	14827	5277
15365	40	35	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 0	14827	5267
15366	62	36	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 0	14827	5257
15367	58	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 0	14827	5269
15368	68	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	14827	5258
15369	84	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	14827	5275
15370	91	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 0	14827	5260
15371	27	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 0	14827	5279
15372	73	33	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 0	14827	5266
15373	31	39	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 0	14827	5276
15374	67	48	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 0	14827	5261
15375	55	30	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	14827	5265
15376	90	35	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 0	14827	5262
15377	89	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 0	14827	5263
15378	49	44	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 1	14828	5256
15379	59	36	Poznámka k aktivitě Výskok s míčem. Osooba: 8 let úroveň 1	14828	5280
15380	35	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 8 let úroveň 1	14828	5251
15381	48	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 1	14828	5269
15382	65	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 1	14828	5253
15383	88	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 1	14828	5254
15384	35	36	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 1	14828	5257
15385	40	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 1	14828	5258
15386	82	49	Poznámka k aktivitě Žebřík s míčem. Osooba: 8 let úroveň 1	14828	5279
15387	60	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 1	14828	5260
15388	67	31	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 1	14828	5261
15389	28	42	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 1	14828	5262
15390	74	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 1	14828	5275
15391	88	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 8 let úroveň 1	14828	5264
15392	95	30	Poznámka k aktivitě běh 50 metrů. Osooba: 8 let úroveň 1	14828	5268
15393	94	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 8 let úroveň 1	14828	5263
15394	54	43	Poznámka k aktivitě Skok vysoký. Osooba: 8 let úroveň 1	14828	5267
15395	92	38	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 1	14828	5276
15396	30	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 1	14828	5277
15397	30	50	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 1	14828	5266
15398	44	50	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 1	14828	5265
15399	37	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 0	14829	5254
15400	30	49	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 0	14829	5280
15401	31	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 0	14829	5279
15402	29	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 0	14829	5264
15403	30	50	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 0	14829	5265
15404	81	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 0	14829	5251
15405	24	45	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 0	14829	5266
15406	87	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 0	14829	5253
15407	22	30	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 0	14829	5256
15408	50	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 0	14829	5277
15409	83	40	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 0	14829	5257
15410	33	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 0	14829	5258
15411	28	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 0	14829	5260
15412	65	42	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 0	14829	5267
15413	65	44	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 0	14829	5268
15414	85	39	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 0	14829	5261
15415	100	48	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 0	14829	5262
15416	43	42	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 0	14829	5276
15417	36	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 0	14829	5269
15418	69	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 0	14829	5263
15419	29	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 0	14829	5275
15420	77	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 9 let úroveň 1	14830	5251
15421	99	40	Poznámka k aktivitě Výskok s míčem. Osooba: 9 let úroveň 1	14830	5280
15422	60	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 1	14830	5253
15423	33	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 1	14830	5254
15424	91	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 1	14830	5275
15425	76	49	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 1	14830	5256
15426	71	40	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 1	14830	5257
15427	21	38	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 1	14830	5266
15428	50	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 1	14830	5258
15429	87	33	Poznámka k aktivitě Skok vysoký. Osooba: 9 let úroveň 1	14830	5267
15430	45	42	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 1	14830	5276
15431	47	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 1	14830	5260
15432	32	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 9 let úroveň 1	14830	5279
15433	51	36	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 1	14830	5261
15434	50	49	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 1	14830	5265
15435	53	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 9 let úroveň 1	14830	5264
15436	31	37	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 1	14830	5262
15437	39	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 1	14830	5269
15438	36	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 9 let úroveň 1	14830	5263
15439	53	50	Poznámka k aktivitě běh 50 metrů. Osooba: 9 let úroveň 1	14830	5268
15440	78	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 1	14830	5277
15441	79	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 0	14831	5253
15442	58	44	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 0	14831	5280
15443	86	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 0	14831	5251
15444	30	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 0	14831	5275
15445	38	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 0	14831	5254
15446	52	30	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 0	14831	5256
15447	86	44	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 0	14831	5257
15448	23	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 0	14831	5277
15449	42	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 0	14831	5258
15450	64	50	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 0	14831	5265
15451	73	31	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 0	14831	5276
15452	80	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 0	14831	5264
15453	23	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 0	14831	5260
15454	20	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 0	14831	5269
15455	58	36	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 0	14831	5268
15456	45	37	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 0	14831	5261
15457	90	47	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 0	14831	5262
15458	44	46	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 0	14831	5267
15459	75	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 0	14831	5279
15460	52	34	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 0	14831	5266
15461	87	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 0	14831	5263
15462	40	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 1	14832	5258
15463	83	39	Poznámka k aktivitě Výskok s míčem. Osooba: 10 let úroveň 1	14832	5280
15464	45	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 10 let úroveň 1	14832	5279
15465	53	50	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 1	14832	5266
15466	61	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 1	14832	5277
15467	46	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 10 let úroveň 1	14832	5251
15468	71	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 1	14832	5269
15469	28	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 1	14832	5253
15470	53	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 1	14832	5254
15471	93	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 1	14832	5275
15472	25	44	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 1	14832	5256
15473	31	43	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 1	14832	5257
15474	76	45	Poznámka k aktivitě Skok vysoký. Osooba: 10 let úroveň 1	14832	5267
15475	43	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 10 let úroveň 1	14832	5264
15476	37	42	Poznámka k aktivitě běh 50 metrů. Osooba: 10 let úroveň 1	14832	5268
15477	89	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 1	14832	5260
15478	85	45	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 1	14832	5276
15479	97	41	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 1	14832	5265
15480	65	46	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 1	14832	5261
15481	40	42	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 1	14832	5262
15482	59	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 10 let úroveň 1	14832	5263
15483	58	48	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 0	14833	5256
15484	57	30	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 0	14833	5280
15485	65	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 0	14833	5275
15486	20	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 0	14833	5277
15487	65	48	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 0	14833	5276
15488	37	37	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 0	14833	5266
15489	42	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 0	14833	5251
15490	99	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 0	14833	5253
15491	78	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 0	14833	5254
15492	58	34	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 0	14833	5267
15493	93	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 0	14833	5269
15494	46	31	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 0	14833	5257
15495	32	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 0	14833	5258
15496	70	43	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 0	14833	5268
15497	96	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 0	14833	5260
15498	43	30	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 0	14833	5261
15499	56	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 0	14833	5264
15500	85	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 0	14833	5279
15501	93	49	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 0	14833	5262
15502	95	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 0	14833	5263
15503	46	38	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 0	14833	5265
15504	73	31	Poznámka k aktivitě Výskok s míčem. Osooba: 11 let úroveň 1	14834	5280
15505	66	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 11 let úroveň 1	14834	5251
15506	68	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 1	14834	5253
15507	87	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 1	14834	5275
15508	70	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 1	14834	5277
15509	38	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 11 let úroveň 1	14834	5264
15510	90	48	Poznámka k aktivitě Skok vysoký. Osooba: 11 let úroveň 1	14834	5267
15511	60	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 1	14834	5254
15512	85	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 11 let úroveň 1	14834	5279
15513	53	34	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 1	14834	5256
15514	57	30	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 1	14834	5257
15515	49	50	Poznámka k aktivitě běh 50 metrů. Osooba: 11 let úroveň 1	14834	5268
15516	73	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 1	14834	5269
15517	74	37	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 1	14834	5276
15518	25	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 1	14834	5258
15519	38	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 1	14834	5260
15520	96	42	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 1	14834	5261
15521	63	42	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 1	14834	5262
15522	41	50	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 1	14834	5266
15523	61	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 11 let úroveň 1	14834	5263
15524	89	38	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 1	14834	5265
15525	63	31	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 0	14835	5256
15526	83	36	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 0	14835	5280
15527	69	41	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 0	14835	5267
15528	93	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 0	14835	5279
15529	30	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 0	14835	5275
15530	83	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 0	14835	5251
15531	86	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 0	14835	5253
15532	91	37	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 0	14835	5266
15533	60	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 0	14835	5254
15534	53	42	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 0	14835	5257
15535	93	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 0	14835	5258
15536	87	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 0	14835	5260
15537	23	32	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 0	14835	5265
15538	84	35	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 0	14835	5276
15539	47	36	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 0	14835	5261
15540	43	32	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 0	14835	5268
15541	25	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 0	14835	5269
15542	68	41	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 0	14835	5262
15543	59	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 0	14835	5277
15544	52	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 0	14835	5264
15545	63	49	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 0	14835	5263
15546	43	32	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 1	14836	5257
15547	94	36	Poznámka k aktivitě Výskok s míčem. Osooba: 12 let úroveň 1	14836	5280
15548	39	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 12 let úroveň 1	14836	5251
15549	26	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 1	14836	5253
15550	65	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 12 let úroveň 1	14836	5279
15551	53	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 1	14836	5254
15552	61	32	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 1	14836	5266
15553	47	40	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 1	14836	5256
15554	90	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 1	14836	5275
15555	41	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 1	14836	5258
15556	51	40	Poznámka k aktivitě běh 50 metrů. Osooba: 12 let úroveň 1	14836	5268
15557	83	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 1	14836	5277
15558	41	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 1	14836	5260
15559	49	39	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 1	14836	5261
15560	52	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 1	14836	5269
15561	30	30	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 1	14836	5276
15562	31	45	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 1	14836	5265
15563	77	32	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 1	14836	5262
15564	76	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 12 let úroveň 1	14836	5264
15565	87	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 12 let úroveň 1	14836	5263
15566	85	36	Poznámka k aktivitě Skok vysoký. Osooba: 12 let úroveň 1	14836	5267
15567	99	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 0	14837	5258
15568	46	37	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 0	14837	5280
15569	38	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 0	14837	5251
15570	87	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 0	14837	5253
15571	72	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 0	14837	5254
15572	45	36	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 0	14837	5256
15573	92	30	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 0	14837	5268
15574	80	49	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 0	14837	5276
15575	37	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 0	14837	5275
15576	58	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 0	14837	5277
15577	25	33	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 0	14837	5266
15578	47	44	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 0	14837	5257
15579	57	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 0	14837	5260
15580	92	47	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 0	14837	5265
15581	66	41	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 0	14837	5267
15582	100	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 0	14837	5269
15583	26	46	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 0	14837	5261
15584	42	33	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 0	14837	5262
15585	76	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 0	14837	5263
15586	91	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 0	14837	5279
15587	89	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 0	14837	5264
15588	52	49	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 1	14838	5256
15589	76	31	Poznámka k aktivitě Výskok s míčem. Osooba: 13 let úroveň 1	14838	5280
15590	22	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 13 let úroveň 1	14838	5251
15591	71	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 13 let úroveň 1	14838	5279
15592	72	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 1	14838	5253
15593	68	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 1	14838	5277
15594	89	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 1	14838	5254
15595	46	50	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 1	14838	5265
15596	82	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 13 let úroveň 1	14838	5264
15597	91	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 1	14838	5275
15598	21	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 1	14838	5269
15599	63	42	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 1	14838	5257
15600	68	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 1	14838	5258
15601	94	49	Poznámka k aktivitě běh 50 metrů. Osooba: 13 let úroveň 1	14838	5268
15602	20	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 1	14838	5260
15603	25	30	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 1	14838	5261
15604	35	49	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 1	14838	5276
15605	23	49	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 1	14838	5262
15606	95	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 13 let úroveň 1	14838	5263
15607	74	41	Poznámka k aktivitě Skok vysoký. Osooba: 13 let úroveň 1	14838	5267
15608	59	42	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 1	14838	5266
15609	25	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 0	14839	5251
15610	60	50	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 0	14839	5280
15611	79	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 0	14839	5253
15612	74	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 0	14839	5254
15613	68	31	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 0	14839	5265
15614	40	44	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 0	14839	5256
15615	65	46	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 0	14839	5257
15616	63	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 0	14839	5258
15617	68	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 0	14839	5260
15618	98	41	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 0	14839	5267
15619	48	41	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 0	14839	5276
15620	83	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 0	14839	5269
15621	90	40	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 0	14839	5261
15622	56	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 0	14839	5277
15623	69	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 0	14839	5275
15624	95	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 0	14839	5264
15625	47	35	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 0	14839	5268
15626	95	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 0	14839	5279
15627	25	35	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 0	14839	5262
15628	62	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 0	14839	5263
15629	94	47	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 0	14839	5266
15630	65	37	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 1	14840	5261
15631	49	41	Poznámka k aktivitě Výskok s míčem. Osooba: 14 let úroveň 1	14840	5280
15632	21	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 1	14840	5275
15633	48	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 1	14840	5277
15634	82	35	Poznámka k aktivitě Skok vysoký. Osooba: 14 let úroveň 1	14840	5267
15635	27	41	Poznámka k aktivitě běh 50 metrů. Osooba: 14 let úroveň 1	14840	5268
15636	87	30	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 1	14840	5276
15637	49	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 1	14840	5269
15638	42	32	Poznámka k aktivitě Žebřík s míčem. Osooba: 14 let úroveň 1	14840	5279
15639	87	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 14 let úroveň 1	14840	5251
15640	86	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 1	14840	5253
15641	60	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 1	14840	5254
15642	72	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 14 let úroveň 1	14840	5264
15643	71	46	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 1	14840	5256
15644	99	48	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 1	14840	5257
15645	40	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 1	14840	5258
15646	70	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 1	14840	5260
15647	64	38	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 1	14840	5262
15648	23	34	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 1	14840	5265
15649	91	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 14 let úroveň 1	14840	5263
15650	53	40	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 1	14840	5266
15651	58	46	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 0	14841	5280
15652	38	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 0	14841	5251
15653	65	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 0	14841	5264
15654	62	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 0	14841	5277
15655	89	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 0	14841	5275
15656	86	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 0	14841	5253
15657	34	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 0	14841	5254
15658	27	34	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 0	14841	5256
15659	46	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 0	14841	5269
15660	33	40	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 0	14841	5267
15661	27	37	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 0	14841	5257
15662	47	43	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 0	14841	5266
15663	47	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 0	14841	5258
15664	21	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 0	14841	5260
15665	83	42	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 0	14841	5268
15666	93	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 0	14841	5279
15667	82	37	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 0	14841	5261
15668	68	31	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 0	14841	5262
15669	22	30	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 0	14841	5276
15670	57	46	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 0	14841	5265
15671	22	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 0	14841	5263
15672	48	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 1	14842	5253
15673	95	32	Poznámka k aktivitě Výskok s míčem. Osooba: 15 let úroveň 1	14842	5280
15674	36	48	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 1	14842	5266
15675	25	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 15 let úroveň 1	14842	5279
15676	45	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 15 let úroveň 1	14842	5251
15677	59	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 1	14842	5254
15678	32	38	Poznámka k aktivitě Skok vysoký. Osooba: 15 let úroveň 1	14842	5267
15679	39	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 1	14842	5269
15680	84	48	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 1	14842	5265
15681	69	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 1	14842	5277
15682	65	36	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 1	14842	5256
15683	64	41	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 1	14842	5257
15684	84	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 1	14842	5275
15685	96	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 1	14842	5258
15686	84	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 1	14842	5260
15687	34	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 15 let úroveň 1	14842	5264
15688	20	50	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 1	14842	5276
15689	23	49	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 1	14842	5261
15690	24	44	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 1	14842	5262
15691	35	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 15 let úroveň 1	14842	5263
15692	28	36	Poznámka k aktivitě běh 50 metrů. Osooba: 15 let úroveň 1	14842	5268
15693	99	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 0	14843	5254
15694	22	30	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 0	14843	5280
15695	91	48	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 0	14843	5276
15696	97	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 0	14843	5251
15697	46	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 0	14843	5253
15698	81	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 0	14843	5275
15699	82	45	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 0	14843	5256
15700	58	35	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 0	14843	5257
15701	44	46	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 0	14843	5266
15702	94	38	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 0	14843	5268
15703	26	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 0	14843	5258
15704	66	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 0	14843	5260
15705	68	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 0	14843	5264
15706	23	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 0	14843	5269
15707	53	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 0	14843	5279
15708	73	39	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 0	14843	5267
15709	94	42	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 0	14843	5261
15710	31	33	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 0	14843	5262
15711	62	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 0	14843	5277
15712	55	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 0	14843	5263
15713	92	40	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 0	14843	5265
15714	84	39	Poznámka k aktivitě Výskok s míčem. Osooba: 16 let úroveň 1	14844	5280
15715	74	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 16 let úroveň 1	14844	5251
15716	63	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 1	14844	5253
15717	30	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 1	14844	5277
15718	89	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 1	14844	5254
15719	24	32	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 1	14844	5256
15720	49	46	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 1	14844	5276
15721	32	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 16 let úroveň 1	14844	5264
15722	89	30	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 1	14844	5266
15723	40	40	Poznámka k aktivitě Skok vysoký. Osooba: 16 let úroveň 1	14844	5267
15724	43	31	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 1	14844	5257
15725	63	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 1	14844	5258
15726	35	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 1	14844	5269
15727	93	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 1	14844	5260
15728	80	32	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 1	14844	5261
15729	25	45	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 1	14844	5262
15730	30	39	Poznámka k aktivitě běh 50 metrů. Osooba: 16 let úroveň 1	14844	5268
15731	43	37	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 1	14844	5265
15732	54	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 16 let úroveň 1	14844	5279
15733	54	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 1	14844	5275
15734	33	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 16 let úroveň 1	14844	5263
15735	91	40	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 0	14845	5256
15736	53	41	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 0	14845	5280
15737	81	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 0	14845	5251
15738	26	46	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 0	14845	5267
15739	57	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 0	14845	5253
15740	58	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 0	14845	5275
15741	86	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 0	14845	5254
15742	87	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 0	14845	5269
15743	34	31	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 0	14845	5257
15744	43	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 0	14845	5258
15745	81	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 0	14845	5277
15746	42	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 0	14845	5260
15747	92	38	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 0	14845	5265
15748	25	36	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 0	14845	5261
15749	47	43	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 0	14845	5262
15750	25	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 0	14845	5264
15751	73	45	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 0	14845	5276
15752	76	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 0	14845	5263
15753	32	45	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 0	14845	5266
15754	63	47	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 0	14845	5268
15755	59	42	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 0	14845	5279
15756	32	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 1	14846	5253
15757	34	35	Poznámka k aktivitě Výskok s míčem. Osooba: 17 let úroveň 1	14846	5280
15758	100	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 17 let úroveň 1	14846	5251
15759	70	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 1	14846	5254
15760	90	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 17 let úroveň 1	14846	5264
15761	60	33	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 1	14846	5256
15762	97	41	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 1	14846	5257
15763	34	44	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 1	14846	5265
15764	63	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 1	14846	5269
15765	51	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 17 let úroveň 1	14846	5279
15766	38	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 1	14846	5275
15767	77	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 1	14846	5258
15768	69	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 1	14846	5260
15769	100	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 1	14846	5277
15770	46	39	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 1	14846	5261
15771	41	40	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 1	14846	5262
15772	56	31	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 1	14846	5266
15773	85	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 17 let úroveň 1	14846	5263
15774	95	36	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 1	14846	5276
15775	49	39	Poznámka k aktivitě Skok vysoký. Osooba: 17 let úroveň 1	14846	5267
15776	84	46	Poznámka k aktivitě běh 50 metrů. Osooba: 17 let úroveň 1	14846	5268
15777	31	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 0	14847	5254
15778	67	34	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 0	14847	5280
15779	35	30	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 0	14847	5267
15780	91	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 0	14847	5264
15781	44	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 0	14847	5269
15782	91	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 0	14847	5251
15783	90	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 0	14847	5253
15784	90	41	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 0	14847	5268
15785	62	30	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 0	14847	5256
15786	44	40	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 0	14847	5257
15787	75	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 0	14847	5258
15788	20	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 0	14847	5279
15789	43	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 0	14847	5260
15790	96	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 0	14847	5275
15791	48	35	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 0	14847	5261
15792	92	40	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 0	14847	5262
15793	33	32	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 0	14847	5263
15794	65	42	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 0	14847	5266
15795	37	47	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 0	14847	5276
15796	53	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 0	14847	5277
15797	25	49	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 0	14847	5265
15798	39	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 1	14848	5258
15799	87	36	Poznámka k aktivitě Výskok s míčem. Osooba: 18 let úroveň 1	14848	5280
15800	83	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 18 let úroveň 1	14848	5251
15801	88	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 1	14848	5253
15802	81	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 1	14848	5254
15803	29	45	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 1	14848	5265
15804	54	39	Poznámka k aktivitě běh 50 metrů. Osooba: 18 let úroveň 1	14848	5268
15805	46	41	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 1	14848	5256
15806	21	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 18 let úroveň 1	14848	5279
15807	50	40	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 1	14848	5257
15808	67	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 18 let úroveň 1	14848	5264
15809	77	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 1	14848	5275
15810	79	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 1	14848	5277
15811	87	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 1	14848	5269
15812	96	44	Poznámka k aktivitě Skok vysoký. Osooba: 18 let úroveň 1	14848	5267
15813	28	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 1	14848	5260
15814	83	30	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 1	14848	5261
15815	94	42	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 1	14848	5262
15816	47	45	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 1	14848	5266
15817	64	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 18 let úroveň 1	14848	5263
15818	40	30	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 1	14848	5276
15819	53	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 0	14849	5253
15820	94	49	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 0	14849	5280
15821	34	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 0	14849	5251
15822	88	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 0	14849	5254
15823	87	46	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 0	14849	5256
15824	48	42	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 0	14849	5257
15825	72	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 0	14849	5258
15826	28	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 0	14849	5260
15827	87	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 0	14849	5264
15828	91	49	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 0	14849	5261
15829	63	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 0	14849	5279
15830	75	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 0	14849	5275
15831	75	43	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 0	14849	5262
15832	32	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 0	14849	5263
15833	25	47	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 0	14849	5267
15834	54	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 0	14849	5269
15835	39	38	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 0	14849	5276
15836	30	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 0	14849	5277
15837	67	41	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 0	14849	5265
15838	71	34	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 0	14849	5266
15839	87	40	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 0	14849	5268
15840	20	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 19 let úroveň 1	14850	5251
15841	76	33	Poznámka k aktivitě Výskok s míčem. Osooba: 19 let úroveň 1	14850	5280
15842	86	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 1	14850	5253
15843	85	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 1	14850	5254
15844	20	45	Poznámka k aktivitě Skok vysoký. Osooba: 19 let úroveň 1	14850	5267
15845	50	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 1	14850	5277
15846	43	33	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 1	14850	5256
15847	23	45	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 1	14850	5257
15848	89	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 1	14850	5258
15849	100	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 19 let úroveň 1	14850	5264
15850	60	44	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 1	14850	5266
15851	83	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 19 let úroveň 1	14850	5279
15852	93	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 1	14850	5260
15853	91	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 1	14850	5275
15854	27	37	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 1	14850	5276
15855	77	43	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 1	14850	5265
15856	55	40	Poznámka k aktivitě běh 50 metrů. Osooba: 19 let úroveň 1	14850	5268
15857	59	40	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 1	14850	5261
15858	54	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 1	14850	5269
15859	87	46	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 1	14850	5262
15860	55	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 19 let úroveň 1	14850	5263
15861	60	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 0	15951	5260
15862	73	45	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 0	15951	5280
15863	38	30	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 0	15951	5251
15864	24	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 0	15951	5264
15865	26	46	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 0	15951	5276
15866	46	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 0	15951	5253
15867	25	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 0	15951	5254
15868	45	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 0	15951	5279
15869	80	48	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 0	15951	5266
15870	67	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 0	15951	5277
15871	22	35	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 0	15951	5256
15872	85	49	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 0	15951	5267
15873	82	47	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 0	15951	5268
15874	37	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 0	15951	5269
15875	96	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 0	15951	5275
15876	60	36	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 0	15951	5257
15877	79	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 0	15951	5258
15878	36	37	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 0	15951	5261
15879	72	33	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 0	15951	5262
15880	34	45	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 0	15951	5263
15881	92	40	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 0	15951	5265
15882	27	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 20 let úroveň 1	15952	5251
15883	95	45	Poznámka k aktivitě Výskok s míčem. Osooba: 20 let úroveň 1	15952	5280
15884	64	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 1	15952	5253
15885	48	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 1	15952	5269
15886	81	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 20 let úroveň 1	15952	5279
15887	48	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 1	15952	5254
15888	62	45	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 1	15952	5256
15889	57	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 1	15952	5277
15890	45	41	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 1	15952	5257
15891	85	35	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 1	15952	5265
15892	94	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 20 let úroveň 1	15952	5264
15893	71	39	Poznámka k aktivitě Skok vysoký. Osooba: 20 let úroveň 1	15952	5267
15894	72	50	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 1	15952	5266
15895	24	36	Poznámka k aktivitě běh 50 metrů. Osooba: 20 let úroveň 1	15952	5268
15896	98	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 1	15952	5258
15897	91	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 1	15952	5260
15898	25	37	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 1	15952	5276
15899	59	40	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 1	15952	5261
15900	67	50	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 1	15952	5262
16001	76	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 20 let úroveň 1	15952	5263
16002	63	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 1	15952	5275
16003	59	46	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 0	15953	5262
16004	70	41	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 0	15953	5280
16005	78	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 0	15953	5251
16006	31	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 0	15953	5253
16007	86	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 0	15953	5254
16008	29	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 0	15953	5264
16009	61	41	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 0	15953	5266
16010	41	44	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 0	15953	5267
16011	92	40	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 0	15953	5268
16012	87	33	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 0	15953	5256
16013	45	30	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 0	15953	5257
16014	69	35	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 0	15953	5276
16015	35	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 0	15953	5279
16016	30	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 0	15953	5258
16017	59	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 0	15953	5260
16018	35	41	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 0	15953	5265
16019	62	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 0	15953	5269
16020	75	38	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 0	15953	5261
16021	67	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 0	15953	5277
16022	94	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 0	15953	5263
16023	40	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 0	15953	5275
16024	45	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 21 let úroveň 1	15954	5251
16025	40	48	Poznámka k aktivitě Výskok s míčem. Osooba: 21 let úroveň 1	15954	5280
16026	87	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 1	15954	5253
16027	59	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 1	15954	5275
16028	93	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 1	15954	5277
16029	61	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 21 let úroveň 1	15954	5264
16030	84	42	Poznámka k aktivitě Skok vysoký. Osooba: 21 let úroveň 1	15954	5267
16031	21	46	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 1	15954	5276
16032	54	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 1	15954	5254
16033	79	37	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 1	15954	5256
16034	34	37	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 1	15954	5265
16035	52	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 1	15954	5269
16036	77	31	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 1	15954	5257
16037	53	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 21 let úroveň 1	15954	5279
16038	74	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 1	15954	5258
16039	41	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 1	15954	5260
16040	65	45	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 1	15954	5261
16041	87	40	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 1	15954	5262
16042	47	50	Poznámka k aktivitě běh 50 metrů. Osooba: 21 let úroveň 1	15954	5268
16043	56	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 21 let úroveň 1	15954	5263
16044	78	33	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 1	15954	5266
16045	77	34	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 0	15955	5256
16046	41	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 0	15955	5251
16047	22	44	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 0	15955	5280
16048	94	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 0	15955	5269
16049	100	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 0	15955	5253
16050	80	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 0	15955	5277
16051	87	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 0	15955	5254
16052	77	39	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 0	15955	5257
16053	47	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 0	15955	5279
16054	65	48	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 0	15955	5266
16055	56	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 0	15955	5258
16056	92	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 0	15955	5260
16057	21	47	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 0	15955	5261
16058	88	49	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 0	15955	5262
16059	99	38	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 0	15955	5267
16060	65	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 0	15955	5264
16061	98	42	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 0	15955	5268
16062	56	50	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 0	15955	5276
16063	98	44	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 0	15955	5265
16064	99	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 0	15955	5263
16065	91	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 0	15955	5275
16066	80	37	Poznámka k aktivitě Výskok s míčem. Osooba: 22 let úroveň 1	15956	5280
16067	56	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 22 let úroveň 1	15956	5251
16068	73	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 1	15956	5253
16069	32	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 1	15956	5254
16070	43	49	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 1	15956	5256
16071	99	43	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 1	15956	5257
16072	55	43	Poznámka k aktivitě Skok vysoký. Osooba: 22 let úroveň 1	15956	5267
16073	68	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 22 let úroveň 1	15956	5264
16074	50	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 1	15956	5258
16075	50	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 1	15956	5260
16076	21	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 22 let úroveň 1	15956	5279
16077	57	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 1	15956	5275
16078	21	50	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 1	15956	5276
16079	23	37	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 1	15956	5261
16080	62	47	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 1	15956	5262
16081	24	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 1	15956	5269
16082	74	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 1	15956	5277
16083	47	49	Poznámka k aktivitě běh 50 metrů. Osooba: 22 let úroveň 1	15956	5268
16084	30	48	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 1	15956	5265
16085	98	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 22 let úroveň 1	15956	5263
16086	53	38	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 1	15956	5266
16087	99	30	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 0	15957	5257
16088	38	36	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 0	15957	5280
16089	87	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 0	15957	5251
16090	42	38	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 0	15957	5265
16091	23	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 0	15957	5253
16092	58	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 0	15957	5254
16093	95	32	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 0	15957	5256
16094	34	30	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 0	15957	5276
16095	94	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 0	15957	5258
16096	59	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 0	15957	5275
16097	49	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 0	15957	5260
16098	82	44	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 0	15957	5266
16099	77	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 0	15957	5277
16100	56	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 0	15957	5279
16101	96	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 0	15957	5269
16102	27	42	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 0	15957	5261
16103	34	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 0	15957	5264
16104	41	46	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 0	15957	5268
16105	68	38	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 0	15957	5262
16106	35	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 0	15957	5263
16107	35	31	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 0	15957	5267
16108	98	34	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 1	15958	5256
16109	23	49	Poznámka k aktivitě Výskok s míčem. Osooba: 23 let úroveň 1	15958	5280
16110	38	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 23 let úroveň 1	15958	5251
16111	50	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 1	15958	5253
16112	27	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 1	15958	5254
16113	88	40	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 1	15958	5276
16114	40	30	Poznámka k aktivitě běh 50 metrů. Osooba: 23 let úroveň 1	15958	5268
16115	43	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 23 let úroveň 1	15958	5279
16116	32	38	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 1	15958	5257
16117	26	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 1	15958	5277
16118	94	49	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 1	15958	5265
16119	73	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 1	15958	5258
16120	61	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 1	15958	5260
16121	96	31	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 1	15958	5261
16122	25	44	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 1	15958	5266
16123	78	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 23 let úroveň 1	15958	5264
16124	34	39	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 1	15958	5262
16125	72	42	Poznámka k aktivitě Skok vysoký. Osooba: 23 let úroveň 1	15958	5267
16126	87	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 1	15958	5269
16127	95	44	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 23 let úroveň 1	15958	5263
16128	22	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 1	15958	5275
16129	97	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 0	15959	5251
16130	39	36	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 0	15959	5280
16131	95	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 0	15959	5253
16132	84	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 0	15959	5264
16133	54	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 0	15959	5254
16134	20	35	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 0	15959	5256
16135	35	34	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 0	15959	5257
16136	42	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 0	15959	5258
16137	92	45	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 0	15959	5276
16138	89	38	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 0	15959	5265
16139	30	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 0	15959	5275
16140	84	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 0	15959	5279
16141	20	39	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 0	15959	5267
16142	32	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 0	15959	5260
16143	79	43	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 0	15959	5261
16144	78	45	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 0	15959	5262
16145	68	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 0	15959	5269
16146	88	44	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 0	15959	5268
16147	78	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 0	15959	5277
16148	73	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 0	15959	5263
16149	89	40	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 0	15959	5266
16150	96	45	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 1	15960	5256
16151	23	41	Poznámka k aktivitě Výskok s míčem. Osooba: 24 let úroveň 1	15960	5280
16152	29	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 24 let úroveň 1	15960	5251
16153	21	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 1	15960	5253
16154	99	47	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 1	15960	5266
16155	92	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 24 let úroveň 1	15960	5264
16156	32	40	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 1	15960	5276
16157	88	44	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 1	15960	5265
16158	37	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 1	15960	5254
16159	57	47	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 1	15960	5257
16160	63	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 1	15960	5275
16161	73	42	Poznámka k aktivitě Skok vysoký. Osooba: 24 let úroveň 1	15960	5267
16162	94	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 1	15960	5258
16163	79	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 1	15960	5260
16164	65	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 24 let úroveň 1	15960	5279
16165	89	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 1	15960	5269
16166	74	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 1	15960	5277
16167	66	31	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 1	15960	5261
16168	32	43	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 1	15960	5262
16169	58	41	Poznámka k aktivitě běh 50 metrů. Osooba: 24 let úroveň 1	15960	5268
16170	36	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 24 let úroveň 1	15960	5263
16171	21	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 0	15961	5258
16172	91	41	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 0	15961	5280
16173	74	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 0	15961	5251
16174	92	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 0	15961	5279
16175	81	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 0	15961	5253
16176	32	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 0	15961	5254
16177	76	48	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 0	15961	5256
16178	71	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 0	15961	5277
16179	49	31	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 0	15961	5257
16180	63	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 0	15961	5269
16181	72	44	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 0	15961	5266
16182	50	40	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 0	15961	5267
16183	80	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 0	15961	5275
16184	58	47	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 0	15961	5268
16185	46	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 0	15961	5260
16186	82	48	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 0	15961	5265
16187	30	30	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 0	15961	5276
16188	82	40	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 0	15961	5261
16189	41	32	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 0	15961	5264
16190	99	32	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 0	15961	5262
16191	69	33	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 0	15961	5263
16192	87	48	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 1	15962	5256
16193	69	32	Poznámka k aktivitě Výskok s míčem. Osooba: 25 let úroveň 1	15962	5280
16194	33	38	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 1	15962	5276
16195	85	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 1	15962	5275
16196	96	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 25 let úroveň 1	15962	5251
16197	88	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 1	15962	5253
16198	67	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 1	15962	5254
16199	39	39	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 1	15962	5265
16200	67	49	Poznámka k aktivitě Hod míčem 2ks. Osooba: 25 let úroveň 1	15962	5264
16201	67	48	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 1	15962	5266
16202	76	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 1	15962	5269
16203	53	45	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 1	15962	5257
16204	96	44	Poznámka k aktivitě běh 50 metrů. Osooba: 25 let úroveň 1	15962	5268
16205	40	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 1	15962	5277
16206	48	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 25 let úroveň 1	15962	5279
16207	38	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 1	15962	5258
16208	58	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 1	15962	5260
16209	52	37	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 1	15962	5261
16210	92	46	Poznámka k aktivitě Skok vysoký. Osooba: 25 let úroveň 1	15962	5267
16211	34	35	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 1	15962	5262
16212	39	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 25 let úroveň 1	15962	5263
16213	78	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 0	15963	5254
16214	71	33	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 0	15963	5280
16215	67	36	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 0	15963	5267
16216	52	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 0	15963	5251
16217	97	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 0	15963	5279
16218	70	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 0	15963	5264
16219	30	30	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 0	15963	5266
16220	22	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 0	15963	5253
16221	99	34	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 0	15963	5256
16222	83	34	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 0	15963	5257
16223	42	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 0	15963	5275
16224	48	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 0	15963	5258
16225	73	44	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 0	15963	5276
16226	96	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 0	15963	5277
16227	78	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 0	15963	5260
16228	84	38	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 0	15963	5261
16229	83	33	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 0	15963	5262
16230	21	50	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 0	15963	5268
16231	23	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 0	15963	5269
16232	22	50	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 0	15963	5265
16233	31	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 0	15963	5263
16234	43	43	Poznámka k aktivitě Výskok s míčem. Osooba: 26 let úroveň 1	15964	5280
16235	48	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 26 let úroveň 1	15964	5251
16236	77	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 1	15964	5253
16237	66	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 1	15964	5254
16238	70	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 1	15964	5277
16239	87	39	Poznámka k aktivitě Skok vysoký. Osooba: 26 let úroveň 1	15964	5267
16240	44	32	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 1	15964	5256
16241	40	44	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 1	15964	5257
16242	65	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 1	15964	5258
16243	43	31	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 1	15964	5276
16244	50	30	Poznámka k aktivitě Žebřík s míčem. Osooba: 26 let úroveň 1	15964	5279
16245	95	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 1	15964	5260
16246	29	36	Poznámka k aktivitě běh 50 metrů. Osooba: 26 let úroveň 1	15964	5268
16247	59	30	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 1	15964	5261
16248	58	47	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 1	15964	5265
16249	62	42	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 1	15964	5262
16250	28	43	Poznámka k aktivitě Hod míčem 2ks. Osooba: 26 let úroveň 1	15964	5264
16251	34	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 1	15964	5269
16252	38	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 1	15964	5275
16253	52	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 26 let úroveň 1	15964	5263
16254	57	43	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 1	15964	5266
16255	33	35	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 0	15965	5280
16256	76	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 0	15965	5251
16257	22	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 0	15965	5253
16258	65	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 0	15965	5254
16259	30	38	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 0	15965	5256
16260	59	46	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 0	15965	5257
16261	41	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 0	15965	5258
16262	90	45	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 0	15965	5266
16263	53	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 0	15965	5269
16264	95	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 0	15965	5264
16265	70	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 0	15965	5260
16266	75	39	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 0	15965	5261
16267	24	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 0	15965	5279
16268	40	31	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 0	15965	5262
16269	96	42	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 0	15965	5267
16270	72	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 0	15965	5277
16271	58	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 0	15965	5275
16272	78	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 0	15965	5263
16273	47	33	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 0	15965	5265
16274	28	38	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 0	15965	5268
16275	31	46	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 0	15965	5276
16276	83	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 1	15966	5254
16277	85	40	Poznámka k aktivitě Výskok s míčem. Osooba: 27 let úroveň 1	15966	5280
16278	74	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 27 let úroveň 1	15966	5251
16279	88	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 1	15966	5253
16280	49	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 1	15966	5277
16281	39	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 27 let úroveň 1	15966	5279
16282	29	48	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 1	15966	5256
16283	36	41	Poznámka k aktivitě Skok vysoký. Osooba: 27 let úroveň 1	15966	5267
16284	77	43	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 1	15966	5276
16285	83	46	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 1	15966	5266
16286	81	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 1	15966	5269
16287	37	42	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 1	15966	5257
16288	39	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 1	15966	5258
16289	41	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 1	15966	5260
16290	78	39	Poznámka k aktivitě běh 50 metrů. Osooba: 27 let úroveň 1	15966	5268
16291	43	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 27 let úroveň 1	15966	5264
16292	90	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 1	15966	5275
16293	45	39	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 1	15966	5261
16294	76	36	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 1	15966	5262
16295	69	37	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 1	15966	5265
16296	53	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 27 let úroveň 1	15966	5263
16297	90	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 0	15967	5251
16298	91	38	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 0	15967	5280
16299	46	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 0	15967	5253
16300	37	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 0	15967	5269
16301	49	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 0	15967	5254
16302	78	37	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 0	15967	5256
16303	27	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 0	15967	5279
16304	66	36	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 0	15967	5268
16305	57	31	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 0	15967	5257
16306	73	31	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 0	15967	5267
16307	21	31	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 0	15967	5276
16308	50	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 0	15967	5258
16309	24	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 0	15967	5277
16310	81	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 0	15967	5260
16311	58	46	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 0	15967	5265
16312	74	38	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 0	15967	5261
16313	55	30	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 0	15967	5266
16314	67	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 0	15967	5275
16315	37	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 0	15967	5264
16316	65	41	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 0	15967	5262
16317	54	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 0	15967	5263
16318	37	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 1	15968	5254
16319	40	30	Poznámka k aktivitě Výskok s míčem. Osooba: 28 let úroveň 1	15968	5280
16320	30	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 28 let úroveň 1	15968	5251
16321	85	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 1	15968	5275
16322	34	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 1	15968	5277
16323	52	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 28 let úroveň 1	15968	5264
16324	58	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 1	15968	5253
16325	91	46	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 1	15968	5276
16326	83	32	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 1	15968	5256
16327	80	38	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 1	15968	5257
16328	52	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 1	15968	5269
16329	70	39	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 1	15968	5266
16330	82	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 1	15968	5258
16331	54	31	Poznámka k aktivitě Skok vysoký. Osooba: 28 let úroveň 1	15968	5267
16332	78	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 28 let úroveň 1	15968	5279
16333	32	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 1	15968	5260
16334	97	38	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 1	15968	5265
16335	40	30	Poznámka k aktivitě běh 50 metrů. Osooba: 28 let úroveň 1	15968	5268
16336	27	32	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 1	15968	5261
16337	22	39	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 1	15968	5262
16338	73	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 28 let úroveň 1	15968	5263
16339	99	50	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 0	15969	5257
16340	68	42	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 0	15969	5280
16341	75	37	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 0	15969	5266
16342	38	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 0	15969	5251
16343	23	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 0	15969	5253
16344	78	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 0	15969	5254
16345	76	35	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 0	15969	5256
16346	57	39	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 0	15969	5268
16347	96	45	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 0	15969	5265
16348	47	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 0	15969	5277
16349	98	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 0	15969	5269
16350	36	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 0	15969	5258
16351	94	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 0	15969	5279
16352	50	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 0	15969	5275
16353	73	31	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 0	15969	5276
16354	24	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 0	15969	5260
16355	32	40	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 0	15969	5261
16356	60	41	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 0	15969	5267
16357	68	47	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 0	15969	5262
16358	43	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 0	15969	5263
16359	81	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 0	15969	5264
16360	38	43	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 1	15970	5257
16361	71	30	Poznámka k aktivitě Výskok s míčem. Osooba: 29 let úroveň 1	15970	5280
16362	21	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 29 let úroveň 1	15970	5251
16363	94	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 1	15970	5253
16364	55	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 1	15970	5254
16365	85	30	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 1	15970	5256
16366	22	49	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 1	15970	5265
16367	77	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 1	15970	5277
16368	85	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 1	15970	5258
16369	56	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 1	15970	5260
16370	77	48	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 1	15970	5266
16371	27	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 1	15970	5269
16372	68	34	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 1	15970	5261
16373	70	35	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 1	15970	5276
16374	23	38	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 1	15970	5262
16375	89	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 29 let úroveň 1	15970	5264
16376	81	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 1	15970	5275
16377	89	40	Poznámka k aktivitě Skok vysoký. Osooba: 29 let úroveň 1	15970	5267
16378	67	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 29 let úroveň 1	15970	5263
16379	99	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 29 let úroveň 1	15970	5279
16380	34	33	Poznámka k aktivitě běh 50 metrů. Osooba: 29 let úroveň 1	15970	5268
16381	37	44	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 0	15971	5257
16382	90	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 0	15971	5253
16383	50	32	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 0	15971	5280
16384	99	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 0	15971	5251
16385	64	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 0	15971	5254
16386	47	43	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 0	15971	5256
16387	89	47	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 0	15971	5276
16388	46	42	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 0	15971	5267
16389	67	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 0	15971	5275
16390	39	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 0	15971	5279
16391	66	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 0	15971	5258
16392	96	34	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 0	15971	5268
16393	55	35	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 0	15971	5266
16394	54	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 0	15971	5260
16395	93	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 0	15971	5277
16396	92	36	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 0	15971	5261
16397	65	45	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 0	15971	5265
16398	29	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 0	15971	5269
16399	20	35	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 0	15971	5262
16400	31	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 0	15971	5264
16401	91	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 0	15971	5263
16402	76	50	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 1	15972	5256
16403	41	44	Poznámka k aktivitě Výskok s míčem. Osooba: 30 let úroveň 1	15972	5280
16404	32	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 30 let úroveň 1	15972	5264
16405	29	30	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 1	15972	5265
16406	88	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 30 let úroveň 1	15972	5251
16407	79	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 1	15972	5253
16408	89	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 1	15972	5254
16409	71	41	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 1	15972	5257
16410	49	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 1	15972	5277
16411	98	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 1	15972	5269
16412	74	47	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 1	15972	5266
16413	26	38	Poznámka k aktivitě Skok vysoký. Osooba: 30 let úroveň 1	15972	5267
16414	78	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 1	15972	5258
16415	31	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 1	15972	5275
16416	68	50	Poznámka k aktivitě Žebřík s míčem. Osooba: 30 let úroveň 1	15972	5279
16417	32	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 1	15972	5260
16418	44	45	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 1	15972	5261
16419	43	41	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 1	15972	5262
16420	75	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 30 let úroveň 1	15972	5263
16421	100	45	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 1	15972	5276
16422	23	43	Poznámka k aktivitě běh 50 metrů. Osooba: 30 let úroveň 1	15972	5268
16423	85	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 0	15973	5254
16424	30	39	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 0	15973	5280
16425	78	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 0	15973	5251
16426	41	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 0	15973	5253
16427	36	42	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 0	15973	5256
16428	82	50	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 0	15973	5268
16429	54	37	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 0	15973	5257
16430	20	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 0	15973	5258
16431	59	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 0	15973	5269
16432	50	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 0	15973	5260
16433	47	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 0	15973	5264
16434	61	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 0	15973	5275
16435	59	46	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 0	15973	5279
16436	93	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 0	15973	5277
16437	27	37	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 0	15973	5266
16438	23	38	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 0	15973	5261
16439	40	47	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 0	15973	5267
16440	91	32	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 0	15973	5265
16441	98	31	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 0	15973	5262
16442	31	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 0	15973	5263
16443	41	36	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 0	15973	5276
16444	99	42	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 1	15974	5257
16445	24	38	Poznámka k aktivitě Výskok s míčem. Osooba: 31 let úroveň 1	15974	5280
16446	29	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 31 let úroveň 1	15974	5251
16447	78	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 1	15974	5275
16448	26	45	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 1	15974	5276
16449	82	44	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 1	15974	5265
16450	84	36	Poznámka k aktivitě běh 50 metrů. Osooba: 31 let úroveň 1	15974	5268
16451	21	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 1	15974	5253
16452	90	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 1	15974	5277
16453	77	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 1	15974	5254
16454	38	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 31 let úroveň 1	15974	5264
16455	35	38	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 1	15974	5266
16456	94	40	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 1	15974	5256
16457	79	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 1	15974	5269
16458	95	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 1	15974	5258
16459	25	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 1	15974	5260
16460	87	32	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 1	15974	5261
16461	67	43	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 1	15974	5262
16462	20	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 31 let úroveň 1	15974	5279
16463	96	35	Poznámka k aktivitě Skok vysoký. Osooba: 31 let úroveň 1	15974	5267
16464	77	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 31 let úroveň 1	15974	5263
16465	71	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 0	15975	5258
16466	75	43	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 0	15975	5280
16467	88	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 0	15975	5251
16468	91	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 0	15975	5253
16469	89	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 0	15975	5254
16470	54	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 0	15975	5277
16471	28	50	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 0	15975	5256
16472	34	31	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 0	15975	5265
16473	57	31	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 0	15975	5257
16474	50	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 0	15975	5260
16475	76	49	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 0	15975	5267
16476	87	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 0	15975	5275
16477	80	43	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 0	15975	5261
16478	58	48	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 0	15975	5268
16479	80	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 0	15975	5269
16480	79	44	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 0	15975	5279
16481	37	36	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 0	15975	5262
16482	71	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 0	15975	5264
16483	99	49	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 0	15975	5266
16484	35	43	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 0	15975	5276
16485	83	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 0	15975	5263
16486	71	47	Poznámka k aktivitě Výskok s míčem. Osooba: 32 let úroveň 1	15976	5280
16487	66	34	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 32 let úroveň 1	15976	5251
16488	59	42	Poznámka k aktivitě běh 50 metrů. Osooba: 32 let úroveň 1	15976	5268
16489	47	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 1	15976	5253
16490	29	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 1	15976	5254
16491	58	35	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 1	15976	5256
16492	74	35	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 1	15976	5257
16493	83	35	Poznámka k aktivitě Skok vysoký. Osooba: 32 let úroveň 1	15976	5267
16494	98	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 1	15976	5258
16495	91	47	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 1	15976	5265
16496	94	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 1	15976	5277
16497	40	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 1	15976	5260
16498	47	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 1	15976	5275
16499	58	47	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 1	15976	5266
16500	93	31	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 1	15976	5276
16501	76	42	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 1	15976	5261
16502	25	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 1	15976	5269
16503	87	36	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 1	15976	5262
16504	97	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 32 let úroveň 1	15976	5263
16505	32	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 32 let úroveň 1	15976	5279
16506	47	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 32 let úroveň 1	15976	5264
16507	93	50	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 0	15977	5257
16508	80	41	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 0	15977	5280
16509	62	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 0	15977	5251
16510	68	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 0	15977	5253
16511	86	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 0	15977	5254
16512	65	41	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 0	15977	5266
16513	59	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 0	15977	5279
16514	20	50	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 0	15977	5256
16515	93	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 0	15977	5258
16516	97	36	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 0	15977	5267
16517	50	42	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 0	15977	5276
16518	95	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 0	15977	5260
16519	69	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 0	15977	5275
16520	97	36	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 0	15977	5261
16521	21	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 0	15977	5277
16522	36	43	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 0	15977	5262
16523	35	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 0	15977	5264
16524	66	32	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 0	15977	5268
16525	50	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 0	15977	5269
16526	95	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 0	15977	5263
16527	40	44	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 0	15977	5265
16528	85	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 1	15978	5253
16529	22	46	Poznámka k aktivitě Výskok s míčem. Osooba: 33 let úroveň 1	15978	5280
16530	49	33	Poznámka k aktivitě Skok vysoký. Osooba: 33 let úroveň 1	15978	5267
16531	49	38	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 1	15978	5276
16532	46	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 33 let úroveň 1	15978	5251
16533	48	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 1	15978	5254
16534	53	48	Poznámka k aktivitě běh 50 metrů. Osooba: 33 let úroveň 1	15978	5268
16535	75	33	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 1	15978	5256
16536	74	43	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 1	15978	5257
16537	70	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 1	15978	5258
16538	44	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 33 let úroveň 1	15978	5264
16539	89	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 1	15978	5260
16540	87	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 33 let úroveň 1	15978	5279
16541	81	49	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 1	15978	5266
16542	54	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 1	15978	5269
16543	41	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 1	15978	5275
16544	57	39	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 1	15978	5261
16545	45	46	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 1	15978	5265
16546	73	48	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 1	15978	5262
16547	69	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 33 let úroveň 1	15978	5263
16548	30	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 1	15978	5277
16549	29	42	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 0	15979	5261
16550	63	45	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 0	15979	5280
16551	84	43	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 0	15979	5265
16552	63	31	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 0	15979	5267
16553	35	46	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 0	15979	5251
16554	70	36	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 0	15979	5266
16555	69	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 0	15979	5279
16556	85	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 0	15979	5253
16557	99	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 0	15979	5254
16558	56	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 0	15979	5275
16559	36	39	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 0	15979	5276
16560	60	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 0	15979	5277
16561	82	32	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 0	15979	5256
16562	92	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 0	15979	5269
16563	28	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 0	15979	5264
16564	73	30	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 0	15979	5268
16565	89	31	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 0	15979	5257
16566	96	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 0	15979	5258
16567	59	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 0	15979	5260
16568	39	39	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 0	15979	5262
16569	77	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 0	15979	5263
16570	68	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 1	15980	5253
16571	29	37	Poznámka k aktivitě Výskok s míčem. Osooba: 34 let úroveň 1	15980	5280
16572	32	31	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 1	15980	5276
16573	39	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 34 let úroveň 1	15980	5279
16574	73	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 1	15980	5275
16575	22	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 1	15980	5277
16576	40	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 34 let úroveň 1	15980	5251
16577	48	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 1	15980	5254
16578	37	48	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 1	15980	5256
16579	21	40	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 1	15980	5265
16580	35	45	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 1	15980	5257
16581	49	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 1	15980	5258
16582	70	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 1	15980	5260
16583	43	36	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 1	15980	5261
16584	93	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 1	15980	5269
16585	78	33	Poznámka k aktivitě Skok vysoký. Osooba: 34 let úroveň 1	15980	5267
16586	41	38	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 1	15980	5262
16587	46	39	Poznámka k aktivitě Hod míčem 2ks. Osooba: 34 let úroveň 1	15980	5264
16588	79	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 34 let úroveň 1	15980	5263
16589	47	47	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 1	15980	5266
16590	89	48	Poznámka k aktivitě běh 50 metrů. Osooba: 34 let úroveň 1	15980	5268
16591	46	37	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 0	15981	5257
16592	53	32	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 0	15981	5280
16593	89	38	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 0	15981	5251
16594	61	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 0	15981	5253
16595	61	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 0	15981	5254
16596	54	50	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 0	15981	5266
16597	59	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 0	15981	5275
16598	56	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 0	15981	5269
16599	74	34	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 0	15981	5256
16600	48	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 0	15981	5258
16601	81	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 0	15981	5260
16602	20	39	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 0	15981	5261
16603	60	38	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 0	15981	5262
16604	38	35	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 0	15981	5276
16605	89	47	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 0	15981	5265
16606	100	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 0	15981	5279
16607	63	47	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 0	15981	5268
16608	73	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 0	15981	5263
16609	36	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 0	15981	5264
16610	39	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 0	15981	5277
16611	65	45	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 0	15981	5267
16612	24	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 35 let úroveň 1	15982	5251
16613	20	44	Poznámka k aktivitě Výskok s míčem. Osooba: 35 let úroveň 1	15982	5280
16614	35	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 1	15982	5253
16615	47	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 1	15982	5254
16616	86	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 1	15982	5275
16617	47	40	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 1	15982	5256
16618	78	30	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 1	15982	5266
16619	79	30	Poznámka k aktivitě Skok vysoký. Osooba: 35 let úroveň 1	15982	5267
16620	58	33	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 1	15982	5257
16621	81	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 1	15982	5277
16622	62	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 1	15982	5258
16623	97	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 1	15982	5260
16624	45	40	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 1	15982	5261
16625	99	30	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 1	15982	5265
16626	78	47	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 1	15982	5262
16627	37	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 35 let úroveň 1	15982	5263
16628	24	42	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 1	15982	5276
16629	81	48	Poznámka k aktivitě Hod míčem 2ks. Osooba: 35 let úroveň 1	15982	5264
16630	21	48	Poznámka k aktivitě běh 50 metrů. Osooba: 35 let úroveň 1	15982	5268
16631	95	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 1	15982	5269
16632	43	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 35 let úroveň 1	15982	5279
16633	24	48	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 0	15983	5280
16634	89	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 0	15983	5251
16635	28	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 0	15983	5253
16636	78	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 0	15983	5275
16637	94	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 0	15983	5254
16638	95	49	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 0	15983	5256
16639	89	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 0	15983	5277
16640	77	37	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 0	15983	5257
16641	98	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 0	15983	5269
16642	38	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 0	15983	5258
16643	88	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 0	15983	5279
16644	60	42	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 0	15983	5266
16645	38	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 0	15983	5260
16646	59	45	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 0	15983	5261
16647	91	35	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 0	15983	5262
16648	77	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 0	15983	5264
16649	72	49	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 0	15983	5265
16650	45	45	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 0	15983	5267
16651	72	38	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 0	15983	5268
16652	57	40	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 0	15983	5276
16653	61	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 0	15983	5263
16654	37	37	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 1	15984	5256
16655	85	50	Poznámka k aktivitě Výskok s míčem. Osooba: 36 let úroveň 1	15984	5280
16656	54	45	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 36 let úroveň 1	15984	5251
16657	51	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 1	15984	5253
16658	66	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 1	15984	5254
16659	85	33	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 1	15984	5266
16660	32	50	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 1	15984	5257
16661	60	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 1	15984	5275
16662	42	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 1	15984	5258
16663	92	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 36 let úroveň 1	15984	5264
16664	100	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 1	15984	5277
16665	84	43	Poznámka k aktivitě Skok vysoký. Osooba: 36 let úroveň 1	15984	5267
16666	32	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 1	15984	5260
16667	25	33	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 1	15984	5261
16668	95	42	Poznámka k aktivitě běh 50 metrů. Osooba: 36 let úroveň 1	15984	5268
16669	65	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 1	15984	5269
16670	82	33	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 1	15984	5262
16671	80	48	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 36 let úroveň 1	15984	5263
16672	97	35	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 1	15984	5265
16673	56	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 36 let úroveň 1	15984	5279
16674	29	30	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 1	15984	5276
16675	72	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 0	15985	5260
16676	35	46	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 0	15985	5280
16677	59	39	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 0	15985	5251
16678	30	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 0	15985	5253
16679	90	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 0	15985	5254
16680	84	45	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 0	15985	5256
16681	50	38	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 0	15985	5257
16682	100	46	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 0	15985	5268
16683	92	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 0	15985	5277
16684	32	44	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 0	15985	5265
16685	88	48	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 0	15985	5266
16686	83	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 0	15985	5258
16687	85	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 0	15985	5275
16688	55	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 0	15985	5264
16689	32	41	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 0	15985	5267
16690	90	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 0	15985	5269
16691	69	31	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 0	15985	5261
16692	70	43	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 0	15985	5262
16693	31	43	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 0	15985	5263
16694	76	45	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 0	15985	5276
16695	63	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 0	15985	5279
16696	54	49	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 1	15986	5256
16697	67	33	Poznámka k aktivitě Výskok s míčem. Osooba: 37 let úroveň 1	15986	5280
16698	42	37	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 1	15986	5276
16699	36	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 37 let úroveň 1	15986	5279
16700	31	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 37 let úroveň 1	15986	5251
16701	30	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 1	15986	5277
16702	39	38	Poznámka k aktivitě Hod míčem 2ks. Osooba: 37 let úroveň 1	15986	5264
16703	25	42	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 1	15986	5266
16704	26	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 1	15986	5253
16705	51	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 1	15986	5254
16706	27	47	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 1	15986	5257
16707	51	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 1	15986	5275
16708	77	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 1	15986	5258
16709	41	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 1	15986	5269
16710	86	40	Poznámka k aktivitě Skok vysoký. Osooba: 37 let úroveň 1	15986	5267
16711	80	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 1	15986	5260
16712	34	30	Poznámka k aktivitě běh 50 metrů. Osooba: 37 let úroveň 1	15986	5268
16713	51	45	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 1	15986	5261
16714	24	47	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 1	15986	5262
16715	100	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 37 let úroveň 1	15986	5263
16716	90	34	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 1	15986	5265
16717	43	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 0	15987	5254
16718	40	44	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 0	15987	5280
16719	86	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 0	15987	5275
16720	35	49	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 0	15987	5267
16721	87	38	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 0	15987	5268
16722	53	34	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 0	15987	5276
16723	37	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 0	15987	5251
16724	20	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 0	15987	5253
16725	38	47	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 0	15987	5279
16726	79	40	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 0	15987	5256
16727	52	31	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 0	15987	5265
16728	29	41	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 0	15987	5266
16729	86	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 0	15987	5264
16730	90	34	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 0	15987	5257
16731	46	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 0	15987	5258
16732	90	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 0	15987	5260
16733	62	39	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 0	15987	5261
16734	58	44	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 0	15987	5262
16735	20	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 0	15987	5269
16736	41	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 0	15987	5277
16737	96	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 0	15987	5263
16738	41	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 38 let úroveň 1	15988	5251
16739	42	44	Poznámka k aktivitě Výskok s míčem. Osooba: 38 let úroveň 1	15988	5280
16740	57	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 1	15988	5253
16741	43	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 1	15988	5254
16742	66	43	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 1	15988	5256
16743	93	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 1	15988	5275
16744	97	39	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 1	15988	5257
16745	98	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 1	15988	5258
16746	89	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 1	15988	5260
16747	78	48	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 1	15988	5261
16748	67	39	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 1	15988	5262
16749	99	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 38 let úroveň 1	15988	5264
16750	88	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 1	15988	5277
16751	37	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 1	15988	5269
16752	63	37	Poznámka k aktivitě Skok vysoký. Osooba: 38 let úroveň 1	15988	5267
16753	34	36	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 38 let úroveň 1	15988	5263
16754	78	50	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 1	15988	5276
16755	45	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 38 let úroveň 1	15988	5279
16756	100	46	Poznámka k aktivitě běh 50 metrů. Osooba: 38 let úroveň 1	15988	5268
16757	30	34	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 1	15988	5265
16758	51	47	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 1	15988	5266
16759	41	41	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 0	15989	5280
16760	39	40	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 0	15989	5251
16761	74	40	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 0	15989	5265
16762	31	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 0	15989	5269
16763	33	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 0	15989	5253
16764	98	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 0	15989	5254
16765	96	30	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 0	15989	5266
16766	48	37	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 0	15989	5256
16767	34	35	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 0	15989	5268
16768	28	49	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 0	15989	5276
16769	30	33	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 0	15989	5279
16770	36	50	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 0	15989	5257
16771	82	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 0	15989	5258
16772	27	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 0	15989	5275
16773	27	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 0	15989	5260
16774	52	41	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 0	15989	5261
16775	94	45	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 0	15989	5264
16776	50	31	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 0	15989	5262
16777	32	32	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 0	15989	5267
16778	39	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 0	15989	5263
16779	47	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 0	15989	5277
16780	25	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 39 let úroveň 1	15990	5251
16781	44	37	Poznámka k aktivitě Výskok s míčem. Osooba: 39 let úroveň 1	15990	5280
16782	61	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 1	15990	5253
16783	43	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 1	15990	5254
16784	63	39	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 1	15990	5256
16785	41	42	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 1	15990	5257
16786	46	31	Poznámka k aktivitě Skok vysoký. Osooba: 39 let úroveň 1	15990	5267
16787	85	39	Poznámka k aktivitě Žebřík s míčem. Osooba: 39 let úroveň 1	15990	5279
16788	21	44	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 1	15990	5265
16789	51	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 1	15990	5258
16790	25	43	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 1	15990	5266
16791	67	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 1	15990	5269
16792	82	30	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 1	15990	5276
16793	45	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 39 let úroveň 1	15990	5264
16794	85	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 1	15990	5275
16795	77	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 1	15990	5277
16796	42	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 1	15990	5260
16797	79	37	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 1	15990	5261
16798	97	37	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 1	15990	5262
16799	82	45	Poznámka k aktivitě běh 50 metrů. Osooba: 39 let úroveň 1	15990	5268
16800	41	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 39 let úroveň 1	15990	5263
16801	22	31	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 0	15991	5256
16802	84	50	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 0	15991	5280
16803	64	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 0	15991	5251
16804	94	43	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 0	15991	5253
16805	57	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 0	15991	5254
16806	84	41	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 0	15991	5257
16807	87	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 0	15991	5275
16808	25	32	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 0	15991	5265
16809	44	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 0	15991	5258
16810	64	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 0	15991	5260
16811	44	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 0	15991	5269
16812	87	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 0	15991	5279
16813	32	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 0	15991	5277
16814	69	35	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 0	15991	5268
16815	62	35	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 0	15991	5261
16816	68	38	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 0	15991	5266
16817	49	39	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 0	15991	5262
16818	91	50	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 0	15991	5276
16819	100	46	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 0	15991	5263
16820	96	33	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 0	15991	5264
16821	39	46	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 0	15991	5267
16822	42	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 1	15992	5253
16823	49	41	Poznámka k aktivitě Výskok s míčem. Osooba: 40 let úroveň 1	15992	5280
16824	84	50	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 1	15992	5276
16825	34	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 40 let úroveň 1	15992	5251
16826	93	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 1	15992	5269
16827	99	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 1	15992	5254
16828	53	33	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 1	15992	5256
16829	95	36	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 1	15992	5257
16830	100	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 1	15992	5258
16831	58	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 1	15992	5260
16832	77	39	Poznámka k aktivitě Skok vysoký. Osooba: 40 let úroveň 1	15992	5267
16833	78	49	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 1	15992	5266
16834	50	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 40 let úroveň 1	15992	5264
16835	61	41	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 1	15992	5265
16836	59	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 1	15992	5275
16837	32	40	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 1	15992	5261
16838	23	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 1	15992	5277
16839	33	34	Poznámka k aktivitě běh 50 metrů. Osooba: 40 let úroveň 1	15992	5268
16840	81	50	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 1	15992	5262
16841	24	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 40 let úroveň 1	15992	5279
16842	76	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 40 let úroveň 1	15992	5263
16843	92	42	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 0	15993	5257
16844	82	43	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 0	15993	5280
16845	65	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 0	15993	5251
16846	36	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 0	15993	5253
16847	61	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 0	15993	5269
16848	65	42	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 0	15993	5265
16849	36	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 0	15993	5254
16850	97	46	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 0	15993	5268
16851	39	37	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 0	15993	5256
16852	67	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 0	15993	5258
16853	94	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 0	15993	5260
16854	62	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 0	15993	5275
16855	22	37	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 0	15993	5267
16856	60	43	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 0	15993	5276
16857	68	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 0	15993	5277
16858	68	34	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 0	15993	5261
16859	83	32	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 0	15993	5262
16860	66	40	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 0	15993	5264
16861	97	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 0	15993	5263
16862	66	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 0	15993	5279
16863	71	39	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 0	15993	5266
16864	62	44	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 1	15994	5256
16865	93	39	Poznámka k aktivitě Výskok s míčem. Osooba: 41 let úroveň 1	15994	5280
16866	25	49	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 41 let úroveň 1	15994	5251
16867	49	32	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 1	15994	5265
16868	49	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 1	15994	5269
16869	32	40	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 1	15994	5266
16870	91	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 1	15994	5277
16871	52	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 1	15994	5253
16872	64	34	Poznámka k aktivitě Skok vysoký. Osooba: 41 let úroveň 1	15994	5267
16873	35	45	Poznámka k aktivitě běh 50 metrů. Osooba: 41 let úroveň 1	15994	5268
16874	48	40	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 1	15994	5276
16875	75	35	Poznámka k aktivitě Hod míčem 2ks. Osooba: 41 let úroveň 1	15994	5264
16876	26	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 1	15994	5254
16877	37	32	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 1	15994	5257
16878	50	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 1	15994	5258
16879	54	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 41 let úroveň 1	15994	5279
16880	41	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 1	15994	5260
16881	27	34	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 1	15994	5261
16882	78	44	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 1	15994	5262
16883	85	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 1	15994	5275
16884	43	38	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 41 let úroveň 1	15994	5263
16885	81	36	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 0	15995	5261
16886	34	49	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 0	15995	5280
16887	70	35	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 0	15995	5251
16888	68	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 0	15995	5253
16889	78	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 0	15995	5254
16890	81	42	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 0	15995	5276
16891	34	39	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 0	15995	5256
16892	57	45	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 0	15995	5266
16893	34	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 0	15995	5275
16894	78	39	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 0	15995	5257
16895	74	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 0	15995	5258
16896	20	33	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 0	15995	5265
16897	90	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 0	15995	5260
16898	75	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 0	15995	5277
16899	77	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 0	15995	5279
16900	73	40	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 0	15995	5267
16901	78	41	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 0	15995	5262
16902	45	46	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 0	15995	5268
16903	43	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 0	15995	5269
16904	77	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 0	15995	5264
16905	60	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 0	15995	5263
16906	41	43	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 1	15996	5257
16907	59	35	Poznámka k aktivitě Výskok s míčem. Osooba: 42 let úroveň 1	15996	5280
16908	41	39	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 1	15996	5265
16909	37	43	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 42 let úroveň 1	15996	5251
16910	92	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 1	15996	5253
16911	98	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 1	15996	5254
16912	77	34	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 1	15996	5276
16913	52	31	Poznámka k aktivitě Žebřík s míčem. Osooba: 42 let úroveň 1	15996	5279
16914	62	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 42 let úroveň 1	15996	5264
16915	28	39	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 1	15996	5256
16916	55	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 1	15996	5258
16917	52	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 1	15996	5260
16918	32	30	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 1	15996	5261
16919	95	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 1	15996	5269
16920	43	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 1	15996	5275
16921	21	31	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 1	15996	5262
16922	95	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 42 let úroveň 1	15996	5263
16923	82	32	Poznámka k aktivitě běh 50 metrů. Osooba: 42 let úroveň 1	15996	5268
16924	61	46	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 1	15996	5266
16925	64	36	Poznámka k aktivitě Skok vysoký. Osooba: 42 let úroveň 1	15996	5267
16926	76	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 1	15996	5277
16927	69	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 0	15997	5253
16928	86	31	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 0	15997	5280
16929	50	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 0	15997	5279
16930	39	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 0	15997	5251
16931	80	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 0	15997	5269
16932	100	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 0	15997	5254
16933	21	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 0	15997	5275
16934	57	31	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 0	15997	5256
16935	96	40	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 0	15997	5257
16936	39	30	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 0	15997	5276
16937	86	36	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 0	15997	5264
16938	42	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 0	15997	5258
16939	64	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 0	15997	5260
16940	73	45	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 0	15997	5261
16941	97	38	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 0	15997	5265
16942	61	30	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 0	15997	5268
16943	35	42	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 0	15997	5262
16944	99	34	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 0	15997	5266
16945	55	40	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 0	15997	5263
16946	52	31	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 0	15997	5267
16947	27	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 0	15997	5277
16948	62	31	Poznámka k aktivitě Výskok s míčem. Osooba: 43 let úroveň 1	15998	5280
16949	53	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 43 let úroveň 1	15998	5251
16950	40	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 1	15998	5253
16951	32	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 1	15998	5254
16952	26	40	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 1	15998	5256
16953	64	49	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 1	15998	5266
16954	64	34	Poznámka k aktivitě Žebřík s míčem. Osooba: 43 let úroveň 1	15998	5279
16955	34	34	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 1	15998	5265
16956	26	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 1	15998	5269
16957	41	40	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 1	15998	5257
16958	64	32	Poznámka k aktivitě běh 50 metrů. Osooba: 43 let úroveň 1	15998	5268
16959	51	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 1	15998	5258
16960	26	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 1	15998	5260
16961	92	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 1	15998	5275
16962	88	30	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 1	15998	5261
16963	34	34	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 1	15998	5262
16964	28	43	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 1	15998	5276
16965	80	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 1	15998	5277
16966	52	43	Poznámka k aktivitě Skok vysoký. Osooba: 43 let úroveň 1	15998	5267
16967	74	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 43 let úroveň 1	15998	5263
16968	76	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 43 let úroveň 1	15998	5264
16969	95	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 0	15999	5254
16970	53	32	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 0	15999	5280
16971	76	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 0	15999	5277
16972	20	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 0	15999	5251
16973	79	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 0	15999	5253
16974	95	42	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 0	15999	5256
16975	47	36	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 0	15999	5265
16976	27	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 0	15999	5269
16977	99	50	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 0	15999	5257
16978	57	46	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 0	15999	5264
16979	55	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 0	15999	5275
16980	66	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 0	15999	5258
16981	53	47	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 0	15999	5268
16982	86	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 0	15999	5260
16983	34	50	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 0	15999	5267
16984	48	32	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 0	15999	5276
16985	20	36	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 0	15999	5279
16986	89	45	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 0	15999	5261
16987	60	45	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 0	15999	5262
16988	38	42	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 0	15999	5266
16989	87	42	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 0	15999	5263
16990	37	50	Poznámka k aktivitě Výskok s míčem. Osooba: 44 let úroveň 1	16000	5280
16991	44	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 44 let úroveň 1	16000	5251
16992	20	38	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 1	16000	5265
16993	20	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 1	16000	5277
16994	34	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 44 let úroveň 1	16000	5264
16995	98	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 44 let úroveň 1	16000	5279
16996	62	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 1	16000	5253
16997	80	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 1	16000	5254
16998	98	40	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 1	16000	5256
16999	67	47	Poznámka k aktivitě běh 50 metrů. Osooba: 44 let úroveň 1	16000	5268
17000	76	32	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 1	16000	5276
17001	62	33	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 1	16000	5257
17002	78	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 1	16000	5258
17003	28	48	Poznámka k aktivitě Skok vysoký. Osooba: 44 let úroveň 1	16000	5267
17004	73	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 1	16000	5260
17005	70	45	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 1	16000	5266
17006	77	34	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 1	16000	5261
17007	66	39	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 1	16000	5262
17008	52	39	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 44 let úroveň 1	16000	5263
17009	41	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 1	16000	5269
17010	25	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 1	16000	5275
17011	78	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 0	17101	5253
17012	77	38	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 0	17101	5280
17013	90	32	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 0	17101	5251
17014	30	47	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 0	17101	5276
17015	65	42	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 0	17101	5265
17016	87	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 0	17101	5254
17017	86	48	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 0	17101	5267
17018	45	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 0	17101	5269
17019	82	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 0	17101	5277
17020	92	35	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 0	17101	5268
17021	52	43	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 0	17101	5279
17022	47	31	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 0	17101	5256
17023	79	32	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 0	17101	5257
17024	43	47	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 0	17101	5266
17025	72	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 0	17101	5258
17026	91	42	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 0	17101	5264
17027	98	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 0	17101	5260
17028	72	30	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 0	17101	5261
17029	85	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 0	17101	5275
17030	35	46	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 0	17101	5262
17031	89	30	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 0	17101	5263
17032	74	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 1	17102	5253
17033	25	46	Poznámka k aktivitě Výskok s míčem. Osooba: 45 let úroveň 1	17102	5280
17034	58	49	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 1	17102	5266
17035	43	49	Poznámka k aktivitě běh 50 metrů. Osooba: 45 let úroveň 1	17102	5268
17036	42	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 1	17102	5277
17037	60	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 45 let úroveň 1	17102	5251
17038	95	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 1	17102	5254
17039	78	36	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 1	17102	5256
17040	26	31	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 1	17102	5257
17041	100	31	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 1	17102	5265
17042	20	38	Poznámka k aktivitě Skok vysoký. Osooba: 45 let úroveň 1	17102	5267
17043	45	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 1	17102	5269
17044	31	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 1	17102	5258
17045	57	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 1	17102	5275
17046	91	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 1	17102	5260
17047	58	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 45 let úroveň 1	17102	5279
17048	76	40	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 1	17102	5261
17049	47	39	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 1	17102	5262
17050	95	40	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 1	17102	5276
17151	77	34	Poznámka k aktivitě Hod míčem 2ks. Osooba: 45 let úroveň 1	17102	5264
17152	80	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 45 let úroveň 1	17102	5263
17153	89	42	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 0	17103	5251
17154	21	48	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 0	17103	5280
17155	68	44	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 0	17103	5276
17156	26	37	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 0	17103	5279
17157	28	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 0	17103	5253
17158	20	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 0	17103	5254
17159	80	35	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 0	17103	5265
17160	78	47	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 0	17103	5256
17161	71	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 0	17103	5275
17162	100	48	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 0	17103	5257
17163	36	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 0	17103	5258
17164	44	45	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 0	17103	5266
17165	26	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 0	17103	5260
17166	41	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 0	17103	5277
17167	45	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 0	17103	5269
17168	24	35	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 0	17103	5261
17169	68	31	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 0	17103	5268
17170	72	42	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 0	17103	5262
17171	42	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 0	17103	5264
17172	20	38	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 0	17103	5267
17173	89	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 0	17103	5263
17174	28	33	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 46 let úroveň 1	17104	5251
17175	91	37	Poznámka k aktivitě Výskok s míčem. Osooba: 46 let úroveň 1	17104	5280
17176	59	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 1	17104	5253
17177	42	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 1	17104	5254
17178	79	50	Poznámka k aktivitě Hod míčem 2ks. Osooba: 46 let úroveň 1	17104	5264
17179	49	33	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 1	17104	5256
17180	42	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 1	17104	5277
17181	96	49	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 1	17104	5265
17182	59	36	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 1	17104	5257
17183	30	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 1	17104	5258
17184	45	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 1	17104	5260
17185	99	48	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 1	17104	5261
17186	52	42	Poznámka k aktivitě Skok vysoký. Osooba: 46 let úroveň 1	17104	5267
17187	97	40	Poznámka k aktivitě Žebřík s míčem. Osooba: 46 let úroveň 1	17104	5279
17188	92	48	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 1	17104	5262
17189	50	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 1	17104	5275
17190	25	50	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 46 let úroveň 1	17104	5263
17191	62	45	Poznámka k aktivitě běh 50 metrů. Osooba: 46 let úroveň 1	17104	5268
17192	70	33	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 1	17104	5276
17193	97	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 1	17104	5269
17194	48	32	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 1	17104	5266
17195	32	37	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 0	17105	5251
17196	97	45	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 0	17105	5280
17197	46	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 0	17105	5253
17198	69	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 0	17105	5254
17199	20	41	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 0	17105	5264
17200	69	31	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 0	17105	5256
17201	87	39	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 0	17105	5257
17202	89	36	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 0	17105	5266
17203	60	48	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 0	17105	5279
17204	57	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 0	17105	5258
17205	71	46	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 0	17105	5268
17206	25	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 0	17105	5269
17207	97	48	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 0	17105	5265
17208	67	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 0	17105	5275
17209	29	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 0	17105	5260
17210	86	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 0	17105	5277
17211	77	36	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 0	17105	5261
17212	64	30	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 0	17105	5262
17213	27	30	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 0	17105	5276
17214	87	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 0	17105	5263
17215	35	33	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 0	17105	5267
17216	62	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 1	17106	5258
17217	62	32	Poznámka k aktivitě Výskok s míčem. Osooba: 47 let úroveň 1	17106	5280
17218	35	34	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 1	17106	5266
17219	57	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 1	17106	5277
17220	97	47	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 47 let úroveň 1	17106	5251
17221	78	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 1	17106	5253
17222	54	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 1	17106	5254
17223	58	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 1	17106	5269
17224	27	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 47 let úroveň 1	17106	5279
17225	55	33	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 1	17106	5256
17226	97	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 1	17106	5275
17227	34	47	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 1	17106	5257
17228	32	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 1	17106	5260
17229	96	38	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 1	17106	5265
17230	29	37	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 1	17106	5261
17231	78	50	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 1	17106	5262
17232	45	32	Poznámka k aktivitě Skok vysoký. Osooba: 47 let úroveň 1	17106	5267
17233	75	41	Poznámka k aktivitě běh 50 metrů. Osooba: 47 let úroveň 1	17106	5268
17234	25	47	Poznámka k aktivitě Hod míčem 2ks. Osooba: 47 let úroveň 1	17106	5264
17235	37	35	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 47 let úroveň 1	17106	5263
17236	90	31	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 1	17106	5276
17237	74	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 0	17107	5254
17238	93	50	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 0	17107	5280
17239	20	44	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 0	17107	5251
17240	53	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 0	17107	5275
17241	72	35	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 0	17107	5279
17242	66	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 0	17107	5253
17243	84	38	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 0	17107	5256
17244	71	31	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 0	17107	5264
17245	68	44	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 0	17107	5257
17246	80	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 0	17107	5258
17247	29	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 0	17107	5269
17248	87	45	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 0	17107	5265
17249	51	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 0	17107	5277
17250	28	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 0	17107	5260
17251	34	40	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 0	17107	5276
17252	44	33	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 0	17107	5267
17253	36	37	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 0	17107	5261
17254	64	38	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 0	17107	5262
17255	100	41	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 0	17107	5263
17256	52	38	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 0	17107	5266
17257	94	44	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 0	17107	5268
17258	95	46	Poznámka k aktivitě Výskok s míčem. Osooba: 48 let úroveň 1	17108	5280
17259	21	36	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 48 let úroveň 1	17108	5251
17260	49	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 1	17108	5253
17261	69	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 1	17108	5254
17262	97	37	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 1	17108	5256
17263	100	44	Poznámka k aktivitě Hod míčem 2ks. Osooba: 48 let úroveň 1	17108	5264
17264	24	38	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 1	17108	5257
17265	32	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 1	17108	5258
17266	79	33	Poznámka k aktivitě běh 50 metrů. Osooba: 48 let úroveň 1	17108	5268
17267	95	37	Poznámka k aktivitě Skok vysoký. Osooba: 48 let úroveň 1	17108	5267
17268	21	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 1	17108	5260
17269	77	46	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 1	17108	5276
17270	27	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 1	17108	5269
17271	64	45	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 1	17108	5261
17272	68	40	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 1	17108	5266
17273	95	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 1	17108	5275
17274	40	46	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 1	17108	5262
17275	41	38	Poznámka k aktivitě Žebřík s míčem. Osooba: 48 let úroveň 1	17108	5279
17276	34	47	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 48 let úroveň 1	17108	5263
17277	86	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 1	17108	5277
17278	37	49	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 1	17108	5265
17279	22	41	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 0	17109	5251
17280	63	41	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 0	17109	5280
17281	37	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 0	17109	5253
17282	85	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 0	17109	5254
17283	66	49	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 0	17109	5256
17284	53	37	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 0	17109	5264
17285	58	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 0	17109	5275
17286	51	46	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 0	17109	5265
17287	82	37	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 0	17109	5257
17288	55	37	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 0	17109	5266
17289	60	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 0	17109	5258
17290	29	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 0	17109	5260
17291	98	39	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 0	17109	5276
17292	41	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 0	17109	5277
17293	31	38	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 0	17109	5261
17294	24	39	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 0	17109	5262
17295	85	50	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 0	17109	5267
17296	74	31	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 0	17109	5263
17297	41	50	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 0	17109	5268
17298	55	41	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 0	17109	5279
17299	42	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 0	17109	5269
17300	94	50	Poznámka k aktivitě Jít na povel a pak zpět. Osooba: 49 let úroveň 1	17110	5251
17301	80	30	Poznámka k aktivitě Výskok s míčem. Osooba: 49 let úroveň 1	17110	5280
17302	56	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 1	17110	5253
17303	32	30	Poznámka k aktivitě Hod míčem 2ks. Osooba: 49 let úroveň 1	17110	5264
17304	20	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 1	17110	5269
17305	100	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 1	17110	5275
17306	48	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 1	17110	5254
17307	80	33	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 1	17110	5256
17308	24	32	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 1	17110	5257
17309	98	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 1	17110	5258
17310	82	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 1	17110	5277
17311	48	35	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 1	17110	5266
17312	55	35	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 1	17110	5276
17313	23	45	Poznámka k aktivitě Žebřík s míčem. Osooba: 49 let úroveň 1	17110	5279
17314	79	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 1	17110	5260
17315	97	37	Poznámka k aktivitě běh 50 metrů. Osooba: 49 let úroveň 1	17110	5268
17316	70	33	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 1	17110	5261
17317	32	49	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 1	17110	5262
17318	49	35	Poznámka k aktivitě Skok vysoký. Osooba: 49 let úroveň 1	17110	5267
17319	47	34	Poznámka k aktivitě Švihadlo - levá, pravá, obě. Osooba: 49 let úroveň 1	17110	5263
17320	49	47	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 1	17110	5265
\.


--
-- TOC entry 3004 (class 0 OID 60503)
-- Dependencies: 219
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY address (id, country, city, street, zip_code) FROM stdin;
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
\.


--
-- TOC entry 2982 (class 0 OID 60351)
-- Dependencies: 197
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
00000000000000	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:39.981088	1	EXECUTED	7:a6235f40597a13436aa36c6d61db2269	createSequence sequenceName=hibernate_sequence		\N	3.5.4	\N	\N	2093459943
00000000000001	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:40.044389	2	EXECUTED	7:ebc2000ab4a469430e5c638c4cf79aa2	createTable tableName=jhi_user; createTable tableName=jhi_authority; createTable tableName=jhi_user_authority; addPrimaryKey tableName=jhi_user_authority; addForeignKeyConstraint baseTableName=jhi_user_authority, constraintName=fk_authority_name, ...		\N	3.5.4	\N	\N	2093459943
20180919081352-1	jhipster	config/liquibase/changelog/20180919081352_added_entity_TestCategory.xml	2018-11-13 08:17:40.097382	6	EXECUTED	7:209442ef19c7c22da10246fe370b38b0	createTable tableName=test_category		\N	3.5.4	\N	\N	2093459943
20180919081349-1	jhipster	config/liquibase/changelog/20180919081349_added_entity_Event.xml	2018-11-13 08:17:40.055519	3	EXECUTED	7:e5038305fbd38914b161642650e71433	createTable tableName=event; dropDefaultValue columnName=jhi_date, tableName=event; createTable tableName=event_tests; addPrimaryKey tableName=event_tests		\N	3.5.4	\N	\N	2093459943
20180919081350-1	jhipster	config/liquibase/changelog/20180919081350_added_entity_JTTest.xml	2018-11-13 08:17:40.077001	4	EXECUTED	7:0648dc6f98e54c36da78f88f88d4179e	createTable tableName=jt_test; createTable tableName=jttest_activities; addPrimaryKey tableName=jttest_activities; createTable tableName=jttest_categories; addPrimaryKey tableName=jttest_categories; createTable tableName=jttest_sports; addPrimaryK...		\N	3.5.4	\N	\N	2093459943
20180919081356-2	jhipster	config/liquibase/changelog/20180919081356_added_entity_constraints_ActivityResult.xml	2018-11-13 08:17:40.336735	20	EXECUTED	7:b93d0e2b25de3af146ee96785ec72b02	addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_test_result_id, referencedTableName=test_result; addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_activity_id, referen...		\N	3.5.4	\N	\N	2093459943
20180919081357-2	jhipster	config/liquibase/changelog/20180919081357_added_entity_constraints_Person.xml	2018-11-13 08:17:40.340958	21	EXECUTED	7:6f22c18d852385929e915b70ccd0c175	addForeignKeyConstraint baseTableName=person, constraintName=fk_person_personal_data_id, referencedTableName=personal_data; addForeignKeyConstraint baseTableName=person, constraintName=fk_person_address_id, referencedTableName=address		\N	3.5.4	\N	\N	2093459943
1542094230696-1	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.044386	22	EXECUTED	7:8d217e9e99a9ac7683f596d22b7cff2b	addColumn tableName=person		\N	3.5.4	\N	\N	2094321018
1542094230696-2	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.053252	23	EXECUTED	7:5e841b60b47ff0aefc49a0b7da95ffb1	addUniqueConstraint constraintName=UC_PERSONUSER_ID_COL, tableName=person		\N	3.5.4	\N	\N	2094321018
1542203539812-1	RLU (generated)	config/liquibase/changelog/20181114135212_added_email_to_Person.xml	2018-11-14 14:57:36.771271	25	EXECUTED	7:938df0e4a12d451975ee6f637de0d637	addColumn tableName=person		\N	3.5.4	\N	\N	2203856737
1542293651906-1	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.275511	26	EXECUTED	7:6823dba0e68a6c865ef7afaa5967798e	createTable tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1542293651906-2	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.287102	27	EXECUTED	7:d0d9029f499101cf4d2906448bb5e5ff	addPrimaryKey tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1542293651906-3	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.2943	28	EXECUTED	7:701420cea947cf455ef06550bcfa0af5	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKcc1cq3mo95k6xp5duh287cfsv, referencedTableName=person		\N	3.5.4	\N	\N	2293767209
1542293651906-4	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.297943	29	EXECUTED	7:8734b0163166dd0e7edfc06c3acd980f	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKtlu2ktd0nahrhonnjrbjjrkwe, referencedTableName=event		\N	3.5.4	\N	\N	2293767209
1543234912593-3	RLU (generated)	config/liquibase/changelog/20181126122145_added_minAge_maxAge_to_JTTest.xml	2018-11-26 13:37:51.908749	32	EXECUTED	\N	addNotNullConstraint columnName=primary_result_value, tableName=activity_result		\N	3.5.4	\N	\N	3235871887
20180919081351-1	jhipster	config/liquibase/changelog/20180919081351_added_entity_Activity.xml	2018-11-13 08:17:40.089369	5	EXECUTED	7:51a20693e822fc99843bc42875ebd530	createTable tableName=activity; createTable tableName=activity_categories; addPrimaryKey tableName=activity_categories		\N	3.5.4	\N	\N	2093459943
20180919081353-1	jhipster	config/liquibase/changelog/20180919081353_added_entity_ActivityCategory.xml	2018-11-13 08:17:40.108058	7	EXECUTED	7:f314cfb26cb50c7061bef53b28dc64ed	createTable tableName=activity_category		\N	3.5.4	\N	\N	2093459943
20180919081354-1	jhipster	config/liquibase/changelog/20180919081354_added_entity_EventResult.xml	2018-11-13 08:17:40.113721	8	EXECUTED	7:ebe4b30a347285f3c27e6149a38ebe37	createTable tableName=event_result		\N	3.5.4	\N	\N	2093459943
20180919081355-1	jhipster	config/liquibase/changelog/20180919081355_added_entity_TestResult.xml	2018-11-13 08:17:40.119662	9	EXECUTED	7:77a15fb38c878daf3cebd815691c8c88	createTable tableName=test_result		\N	3.5.4	\N	\N	2093459943
20180919081356-1	jhipster	config/liquibase/changelog/20180919081356_added_entity_ActivityResult.xml	2018-11-13 08:17:40.125061	10	EXECUTED	7:57a1f3bf36c71dee72b6fa931bbfc574	createTable tableName=activity_result		\N	3.5.4	\N	\N	2093459943
20180919081357-1	jhipster	config/liquibase/changelog/20180919081357_added_entity_Person.xml	2018-11-13 08:17:40.13429	11	EXECUTED	7:e93b4d142509c4cc65e53f2143f9486d	createTable tableName=person		\N	3.5.4	\N	\N	2093459943
20180919081358-1	jhipster	config/liquibase/changelog/20180919081358_added_entity_PersonalData.xml	2018-11-13 08:17:40.142888	12	EXECUTED	7:7fa972ec1a3cb9d040b869b8404820c9	createTable tableName=personal_data; dropDefaultValue columnName=birth_date, tableName=personal_data		\N	3.5.4	\N	\N	2093459943
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
\.


--
-- TOC entry 2981 (class 0 OID 60346)
-- Dependencies: 196
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 2989 (class 0 OID 60409)
-- Dependencies: 204
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event (id, name, jhi_date, address_id, max_age, min_age) FROM stdin;
5501	Test obecný 6 - 12	1985-11-01 02:25:00	\N	10	6
9153	Test obecný 15+	2018-12-19 14:30:00	\N	\N	15
9152	Test obecný 13-15	2018-12-05 14:18:46.902	\N	15	13
9451	2. událost 13-15	2018-12-19 14:30:00	\N	15	13
\.


--
-- TOC entry 3006 (class 0 OID 60620)
-- Dependencies: 221
-- Data for Name: event_attached_persons; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_attached_persons (events_id, attached_persons_id) FROM stdin;
9153	6528
9153	6529
5501	2901
5501	2201
5501	6401
5501	6402
5501	6403
5501	6404
5501	6405
5501	6406
5501	6407
5501	6408
9153	6530
9153	6531
9153	6532
9153	6533
9153	6534
9153	6535
9153	6536
9153	6537
9153	6538
9153	6420
9153	6421
9153	6422
9153	6423
9153	6424
9153	2201
9153	6425
9153	6426
9153	6427
9153	6428
9153	6429
9153	6430
9153	6431
9153	6432
9153	6433
9153	6434
9153	6435
9153	6436
9153	6437
9153	6438
9153	6439
9153	6440
9153	6441
9153	6442
9153	6443
9153	6444
9153	6445
9153	6446
9153	6447
9153	6448
9153	6449
9153	6450
9153	2901
9153	6501
9153	6502
9153	6503
9153	6504
9153	6505
9153	6506
9153	6507
9153	6508
9153	6509
9153	6510
9153	6511
9153	6512
9153	6513
9153	6514
9153	6515
9153	6516
9153	6517
9153	6518
9153	6519
9153	6520
9153	6521
9153	6522
9153	6523
9153	6524
9153	6525
9153	6526
9153	6527
9152	6416
9152	6417
9152	6418
9152	6419
9152	6420
9152	6415
9451	6416
9451	6417
9451	6418
9451	6419
9451	6420
9451	2901
9451	2201
9451	6415
\.


--
-- TOC entry 2999 (class 0 OID 60471)
-- Dependencies: 214
-- Data for Name: event_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_result (id, note, actual_height_in_cm, actual_weight_in_kg, event_id, person_id) FROM stdin;
9501	\N	174	89	5501	2901
9502	\N	169	83	5501	2201
9503	\N	174	90	5501	6401
9504	\N	174	78	5501	6402
9505	\N	186	90	5501	6403
9506	\N	188	76	5501	6404
9507	\N	186	79	5501	6405
9508	\N	177	78	5501	6406
9509	\N	172	80	5501	6407
9510	\N	181	79	5501	6408
9511	\N	168	81	5501	6409
9512	\N	188	82	5501	6410
9513	\N	174	75	5501	6411
9514	\N	186	87	5501	6412
9515	\N	176	84	5501	6413
9516	\N	180	81	5501	6414
9517	\N	188	78	5501	6415
9518	\N	171	84	5501	6416
9519	\N	166	83	5501	6417
9520	\N	181	83	5501	6418
9521	\N	173	76	5501	6419
9522	\N	175	76	5501	6420
9523	\N	168	83	5501	6421
9524	\N	186	77	5501	6422
9525	\N	179	88	5501	6423
9526	\N	160	77	5501	6424
9527	\N	183	87	5501	6425
9528	\N	168	79	5501	6426
9529	\N	180	83	5501	6427
9530	\N	167	80	5501	6428
9531	\N	162	87	5501	6429
9532	\N	185	89	5501	6430
9533	\N	169	75	5501	6431
9534	\N	162	76	5501	6432
9535	\N	162	84	5501	6433
9536	\N	164	84	5501	6434
9537	\N	163	80	5501	6435
9538	\N	186	89	5501	6436
9539	\N	186	87	5501	6437
9540	\N	183	86	5501	6438
9541	\N	168	79	5501	6439
9542	\N	174	82	5501	6440
9543	\N	165	77	5501	6441
9544	\N	186	86	5501	6442
9545	\N	190	87	5501	6443
9546	\N	160	75	5501	6444
9547	\N	177	83	5501	6445
9548	\N	175	90	5501	6446
9549	\N	175	80	5501	6447
9550	\N	179	85	5501	6448
10301	\N	162	82	5501	6449
10302	\N	180	76	5501	6450
10303	\N	166	83	5501	6501
10304	\N	175	87	5501	6502
10305	\N	163	86	5501	6503
10306	\N	176	77	5501	6504
10307	\N	179	75	5501	6505
10308	\N	175	87	5501	6506
10309	\N	161	90	5501	6507
10310	\N	165	75	5501	6508
10311	\N	187	79	5501	6509
10312	\N	170	87	5501	6510
10313	\N	177	87	5501	6511
10314	\N	187	76	5501	6512
10315	\N	170	85	5501	6513
10316	\N	172	77	5501	6514
10317	\N	187	85	5501	6515
10318	\N	160	89	5501	6516
10319	\N	171	83	5501	6517
10320	\N	180	80	5501	6518
10321	\N	171	86	5501	6519
10322	\N	181	89	5501	6520
10323	\N	186	75	5501	6521
10324	\N	189	75	5501	6522
10325	\N	187	88	5501	6523
10326	\N	190	82	5501	6524
10327	\N	178	87	5501	6525
10328	\N	172	85	5501	6526
10329	\N	176	78	5501	6527
10330	\N	166	89	5501	6528
10331	\N	179	81	5501	6529
10332	\N	174	79	5501	6530
10333	\N	180	82	5501	6531
10334	\N	190	87	5501	6532
10335	\N	161	80	5501	6533
10336	\N	163	88	5501	6534
10337	\N	175	76	5501	6535
10338	\N	190	85	5501	6536
10339	\N	188	84	5501	6537
10340	\N	182	81	5501	6538
10341	\N	179	79	9153	2901
10342	\N	184	90	9153	2201
10343	\N	178	83	9153	6401
10344	\N	180	79	9153	6402
10345	\N	168	78	9153	6403
10346	\N	165	81	9153	6404
10347	\N	187	83	9153	6405
10348	\N	179	83	9153	6406
10349	\N	177	88	9153	6407
10350	\N	170	78	9153	6408
11201	\N	161	81	9153	6409
11202	\N	166	79	9153	6410
11203	\N	177	79	9153	6411
11204	\N	176	88	9153	6412
11205	\N	178	83	9153	6413
11206	\N	165	75	9153	6414
11207	\N	166	76	9153	6415
11208	\N	168	82	9153	6416
11209	\N	163	78	9153	6417
11210	\N	179	78	9153	6418
11211	\N	177	86	9153	6419
11212	\N	186	84	9153	6420
11213	\N	168	76	9153	6421
11214	\N	160	83	9153	6422
11215	\N	188	79	9153	6423
11216	\N	176	87	9153	6424
11217	\N	187	87	9153	6425
11218	\N	169	89	9153	6426
11219	\N	166	84	9153	6427
11220	\N	189	88	9153	6428
11221	\N	169	80	9153	6429
11222	\N	168	86	9153	6430
11223	\N	172	84	9153	6431
11224	\N	182	81	9153	6432
11225	\N	169	82	9153	6433
11226	\N	176	88	9153	6434
11227	\N	177	82	9153	6435
11228	\N	181	78	9153	6436
11229	\N	181	77	9153	6437
11230	\N	167	81	9153	6438
11231	\N	161	84	9153	6439
11232	\N	166	90	9153	6440
11233	\N	185	89	9153	6441
11234	\N	174	86	9153	6442
11235	\N	177	86	9153	6443
11236	\N	170	83	9153	6444
11237	\N	165	79	9153	6445
11238	\N	165	90	9153	6446
11239	\N	173	80	9153	6447
11240	\N	176	79	9153	6448
11241	\N	185	87	9153	6449
11242	\N	186	88	9153	6450
11243	\N	162	85	9153	6501
11244	\N	189	77	9153	6502
11245	\N	160	88	9153	6503
11246	\N	162	87	9153	6504
11247	\N	175	75	9153	6505
11248	\N	169	81	9153	6506
11249	\N	183	75	9153	6507
11250	\N	181	76	9153	6508
12401	\N	167	75	9153	6509
12402	\N	171	84	9153	6510
12403	\N	169	80	9153	6511
12404	\N	172	88	9153	6512
12405	\N	166	87	9153	6513
12406	\N	174	90	9153	6514
12407	\N	172	81	9153	6515
12408	\N	180	78	9153	6516
12409	\N	184	79	9153	6517
12410	\N	182	82	9153	6518
12411	\N	182	81	9153	6519
12412	\N	177	76	9153	6520
12413	\N	182	79	9153	6521
12414	\N	189	84	9153	6522
12415	\N	177	84	9153	6523
12416	\N	168	81	9153	6524
12417	\N	184	78	9153	6525
12418	\N	171	90	9153	6526
12419	\N	186	87	9153	6527
12420	\N	177	78	9153	6528
12421	\N	170	76	9153	6529
12422	\N	180	89	9153	6530
12423	\N	164	85	9153	6531
12424	\N	167	79	9153	6532
12425	\N	179	83	9153	6533
12426	\N	186	84	9153	6534
12427	\N	188	86	9153	6535
12428	\N	172	82	9153	6536
12429	\N	169	79	9153	6537
12430	\N	164	77	9153	6538
12431	\N	175	79	9152	2901
12432	\N	169	84	9152	2201
12433	\N	162	89	9152	6401
12434	\N	180	81	9152	6402
12435	\N	189	77	9152	6403
12436	\N	166	87	9152	6404
12437	\N	190	75	9152	6405
12438	\N	171	80	9152	6406
12439	\N	167	89	9152	6407
12440	\N	167	90	9152	6408
12441	\N	172	81	9152	6409
12442	\N	178	79	9152	6410
12443	\N	177	84	9152	6411
12444	\N	189	75	9152	6412
12445	\N	186	90	9152	6413
12446	\N	190	82	9152	6414
12447	\N	185	81	9152	6415
12448	\N	172	76	9152	6416
12449	\N	183	83	9152	6417
12450	\N	170	88	9152	6418
13601	\N	190	80	9152	6419
13602	\N	187	83	9152	6420
13603	\N	170	83	9152	6421
13604	\N	172	89	9152	6422
13605	\N	161	84	9152	6423
13606	\N	187	88	9152	6424
13607	\N	182	75	9152	6425
13608	\N	190	83	9152	6426
13609	\N	181	90	9152	6427
13610	\N	161	80	9152	6428
13611	\N	183	90	9152	6429
13612	\N	172	76	9152	6430
13613	\N	172	83	9152	6431
13614	\N	172	87	9152	6432
13615	\N	188	82	9152	6433
13616	\N	184	83	9152	6434
13617	\N	162	84	9152	6435
13618	\N	176	87	9152	6436
13619	\N	176	86	9152	6437
13620	\N	166	82	9152	6438
13621	\N	166	80	9152	6439
13622	\N	187	83	9152	6440
13623	\N	164	86	9152	6441
13624	\N	190	85	9152	6442
13625	\N	186	76	9152	6443
13626	\N	172	75	9152	6444
13627	\N	183	85	9152	6445
13628	\N	185	80	9152	6446
13629	\N	179	88	9152	6447
13630	\N	165	90	9152	6448
13631	\N	172	85	9152	6449
13632	\N	180	76	9152	6450
13633	\N	182	86	9152	6501
13634	\N	183	76	9152	6502
13635	\N	182	77	9152	6503
13636	\N	176	78	9152	6504
13637	\N	178	86	9152	6505
13638	\N	170	88	9152	6506
13639	\N	173	89	9152	6507
13640	\N	189	86	9152	6508
13641	\N	187	79	9152	6509
13642	\N	173	90	9152	6510
13643	\N	172	76	9152	6511
13644	\N	179	78	9152	6512
13645	\N	167	84	9152	6513
13646	\N	175	75	9152	6514
13647	\N	169	75	9152	6515
13648	\N	182	90	9152	6516
13649	\N	182	79	9152	6517
13650	\N	176	87	9152	6518
14751	\N	190	89	9152	6519
14752	\N	186	87	9152	6520
14753	\N	178	89	9152	6521
14754	\N	178	85	9152	6522
14755	\N	186	80	9152	6523
14756	\N	179	89	9152	6524
14757	\N	181	80	9152	6525
14758	\N	173	80	9152	6526
14759	\N	188	85	9152	6527
14760	\N	169	87	9152	6528
14761	\N	173	81	9152	6529
14762	\N	171	79	9152	6530
14763	\N	184	85	9152	6531
14764	\N	167	90	9152	6532
14765	\N	171	78	9152	6533
14766	\N	165	88	9152	6534
14767	\N	163	84	9152	6535
14768	\N	188	89	9152	6536
14769	\N	170	79	9152	6537
14770	\N	165	78	9152	6538
14771	\N	160	82	9451	2901
14772	\N	178	75	9451	2201
14773	\N	188	76	9451	6401
14774	\N	188	81	9451	6402
14775	\N	167	79	9451	6403
14776	\N	179	76	9451	6404
14777	\N	160	75	9451	6405
14778	\N	165	75	9451	6406
14779	\N	164	85	9451	6407
14780	\N	164	79	9451	6408
14781	\N	190	86	9451	6409
14782	\N	186	83	9451	6410
14783	\N	187	81	9451	6411
14784	\N	161	78	9451	6412
14785	\N	174	84	9451	6413
14786	\N	184	88	9451	6414
14787	\N	162	77	9451	6415
14788	\N	175	90	9451	6416
14789	\N	181	75	9451	6417
14790	\N	189	90	9451	6418
14791	\N	176	79	9451	6419
14792	\N	171	82	9451	6420
14793	\N	182	89	9451	6421
14794	\N	167	88	9451	6422
14795	\N	181	83	9451	6423
14796	\N	179	85	9451	6424
14797	\N	190	87	9451	6425
14798	\N	175	77	9451	6426
14799	\N	173	83	9451	6427
14800	\N	164	80	9451	6428
15901	\N	161	90	9451	6429
15902	\N	160	80	9451	6430
15903	\N	173	83	9451	6431
15904	\N	178	76	9451	6432
15905	\N	185	89	9451	6433
15906	\N	172	80	9451	6434
15907	\N	189	78	9451	6435
15908	\N	175	87	9451	6436
15909	\N	189	85	9451	6437
15910	\N	188	76	9451	6438
15911	\N	180	85	9451	6439
15912	\N	180	82	9451	6440
15913	\N	189	82	9451	6441
15914	\N	183	78	9451	6442
15915	\N	174	77	9451	6443
15916	\N	170	80	9451	6444
15917	\N	188	90	9451	6445
15918	\N	186	86	9451	6446
15919	\N	168	86	9451	6447
15920	\N	165	78	9451	6448
15921	\N	174	78	9451	6449
15922	\N	188	75	9451	6450
15923	\N	185	77	9451	6501
15924	\N	182	87	9451	6502
15925	\N	180	80	9451	6503
15926	\N	166	86	9451	6504
15927	\N	164	82	9451	6505
15928	\N	172	87	9451	6506
15929	\N	184	89	9451	6507
15930	\N	178	77	9451	6508
15931	\N	186	83	9451	6509
15932	\N	160	80	9451	6510
15933	\N	185	78	9451	6511
15934	\N	167	79	9451	6512
15935	\N	171	81	9451	6513
15936	\N	164	79	9451	6514
15937	\N	173	88	9451	6515
15938	\N	185	75	9451	6516
15939	\N	184	75	9451	6517
15940	\N	185	82	9451	6518
15941	\N	169	76	9451	6519
15942	\N	177	88	9451	6520
15943	\N	166	88	9451	6521
15944	\N	168	88	9451	6522
15945	\N	166	76	9451	6523
15946	\N	188	84	9451	6524
15947	\N	166	83	9451	6525
15948	\N	185	78	9451	6526
15949	\N	177	88	9451	6527
15950	\N	187	85	9451	6528
17051	\N	174	87	9451	6529
17052	\N	163	81	9451	6530
17053	\N	164	77	9451	6531
17054	\N	187	88	9451	6532
17055	\N	176	88	9451	6533
17056	\N	187	84	9451	6534
17057	\N	178	79	9451	6535
17058	\N	160	78	9451	6536
17059	\N	165	83	9451	6537
17060	\N	170	89	9451	6538
\.


--
-- TOC entry 2990 (class 0 OID 60414)
-- Dependencies: 205
-- Data for Name: event_tests; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_tests (tests_id, events_id) FROM stdin;
5451	5501
5452	9152
5453	9153
5452	9451
\.


--
-- TOC entry 2985 (class 0 OID 60372)
-- Dependencies: 200
-- Data for Name: jhi_authority; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_authority (name) FROM stdin;
ROLE_ADMIN
ROLE_USER
\.


--
-- TOC entry 2987 (class 0 OID 60392)
-- Dependencies: 202
-- Data for Name: jhi_persistent_audit_event; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_persistent_audit_event (event_id, principal, event_date, event_type) FROM stdin;
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
\.


--
-- TOC entry 2988 (class 0 OID 60397)
-- Dependencies: 203
-- Data for Name: jhi_persistent_audit_evt_data; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_persistent_audit_evt_data (event_id, name, value) FROM stdin;
5053	type	org.springframework.security.authentication.BadCredentialsException
5053	message	Bad credentials
5054	type	org.springframework.security.authentication.BadCredentialsException
5054	message	Bad credentials
5055	type	org.springframework.security.authentication.BadCredentialsException
5055	message	Bad credentials
\.


--
-- TOC entry 2984 (class 0 OID 60359)
-- Dependencies: 199
-- Data for Name: jhi_user; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_user (id, login, password_hash, first_name, last_name, email, image_url, activated, lang_key, activation_key, reset_key, created_by, created_date, reset_date, last_modified_by, last_modified_date) FROM stdin;
1	system	$2a$10$mE.qmcV0mFU5NcKh73TZx.z4ueI/.bDWbj0T1BYyqP481kGGarKLG	System	System	system@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
2	anonymoususer	$2a$10$j8S5d7Sr7.8VTOYNviDPOeWX8KcYILUVJBsYV83Y5NtECayypx9lO	Anonymous	User	anonymous@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
3	admin	$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC	Administrator	Administrator	admin@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
4	user	$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K	User	User	user@localhost		t	cs	\N	\N	system	2018-11-13 08:17:39.985435	\N	system	\N
2351	rousludek	$2a$10$eYevlObiepRF6quFm6dSLO5AwGtGd5lCO3YqxSFeTAiNx/kjzuLwK	\N	\N	rousludek@gmail.com	\N	t	cs	\N	\N	anonymousUser	2018-11-14 17:03:22.225	\N	anonymousUser	2018-11-14 17:05:21.651
\.


--
-- TOC entry 2986 (class 0 OID 60377)
-- Dependencies: 201
-- Data for Name: jhi_user_authority; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_user_authority (user_id, authority_name) FROM stdin;
1	ROLE_ADMIN
1	ROLE_USER
3	ROLE_ADMIN
3	ROLE_USER
4	ROLE_USER
2351	ROLE_USER
\.


--
-- TOC entry 2991 (class 0 OID 60419)
-- Dependencies: 206
-- Data for Name: jt_test; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jt_test (id, name, description, max_age, min_age) FROM stdin;
5451	Test obecný 1 6-12	\N	12	6
5452	Test obecný 1 13-15	\N	15	13
5453	Test obecný 1 15+	\N	\N	15
5455	Test basketbal 11 - 15	\N	15	11
5454	Test basketbal 6 - 10	\N	10	6
5456	Test basketbal 15 +	\N	\N	15
6751	Test dřepy a kliky	\N	\N	\N
\.


--
-- TOC entry 2992 (class 0 OID 60427)
-- Dependencies: 207
-- Data for Name: jttest_activities; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jttest_activities (activities_id, jttests_id) FROM stdin;
5265	5451
5253	5451
5269	5451
5254	5451
5256	5451
5257	5451
5258	5451
5260	5451
5261	5451
5262	5451
5274	5451
5275	5451
5276	5451
5277	5451
5280	5452
5251	5452
5253	5452
5254	5452
5256	5452
5257	5452
5258	5452
5260	5452
5261	5452
5262	5452
5263	5452
5264	5452
5265	5452
5266	5452
5267	5452
5268	5452
5269	5452
5275	5452
5276	5452
5277	5452
5279	5452
5280	5453
5251	5453
5253	5453
5254	5453
5256	5453
5257	5453
5258	5453
5261	5453
5262	5453
5263	5453
5264	5453
5265	5453
5266	5453
5267	5453
5268	5453
5269	5453
5275	5453
5276	5453
5277	5453
5279	5453
5271	5453
5274	5453
5281	5454
5282	5454
5352	5454
5353	5454
5354	5454
5358	5454
5359	5454
5360	5454
5361	5454
5362	5454
5363	5454
5364	5454
5281	5455
5282	5455
5352	5455
5353	5455
5354	5455
5358	5455
5359	5455
5360	5455
5361	5455
5362	5455
5363	5455
5364	5455
5366	5455
5281	5456
5282	5456
5352	5456
5353	5456
5354	5456
5358	5456
5359	5456
5360	5456
5361	5456
5362	5456
5363	5456
5364	5456
5366	5456
5266	6751
6701	6751
\.


--
-- TOC entry 2993 (class 0 OID 60432)
-- Dependencies: 208
-- Data for Name: jttest_categories; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jttest_categories (categories_id, jttests_id) FROM stdin;
5401	5451
5402	5452
5402	5453
5404	5454
5405	5455
5403	5456
\.


--
-- TOC entry 2994 (class 0 OID 60437)
-- Dependencies: 209
-- Data for Name: jttest_sports; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jttest_sports (sports_id, jttests_id) FROM stdin;
\.


--
-- TOC entry 3002 (class 0 OID 60486)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY person (id, personal_data_id, address_id, user_id, email, virtual) FROM stdin;
2901	2851	2801	\N	seli@vocas.cz	f
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
\.


--
-- TOC entry 3003 (class 0 OID 60495)
-- Dependencies: 218
-- Data for Name: personal_data; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY personal_data (id, first_name, last_name, birth_date, nationality) FROM stdin;
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
\.


--
-- TOC entry 3005 (class 0 OID 60511)
-- Dependencies: 220
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY sport (id, name) FROM stdin;
\.


--
-- TOC entry 2997 (class 0 OID 60455)
-- Dependencies: 212
-- Data for Name: test_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY test_category (id, name, jhi_key, description) FROM stdin;
5401	6 let - 12 let	\N	Test pro kategorii 6 - 12 let
5402	13 let - 15 let	\N	Test pro kategorii 13 - 15 let
5403	15 let +	\N	Test pro kategorii 15 let a více
5404	6 let - 10 let	\N	Test pro kategorii 6 - 10 let
5405	11 let - 15 let	\N	Test pro kategorii 11 - 15 let
\.


--
-- TOC entry 3000 (class 0 OID 60476)
-- Dependencies: 215
-- Data for Name: test_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY test_result (id, note, event_result_id, test_id) FROM stdin;
9551	Poznámka k testu Test obecný 1 6-12. Osooba: Jan Selinger	9501	5451
9552	Poznámka k testu Test obecný 1 6-12. Osooba: Luděk Rous	9502	5451
9553	Poznámka k testu Test obecný 1 6-12. Osooba: 6 let úroveň 0	9503	5451
9554	Poznámka k testu Test obecný 1 6-12. Osooba: 6 let úroveň 1	9504	5451
9555	Poznámka k testu Test obecný 1 6-12. Osooba: 7 let úroveň 0	9505	5451
9556	Poznámka k testu Test obecný 1 6-12. Osooba: 7 let úroveň 1	9506	5451
9557	Poznámka k testu Test obecný 1 6-12. Osooba: 8 let úroveň 0	9507	5451
9558	Poznámka k testu Test obecný 1 6-12. Osooba: 8 let úroveň 1	9508	5451
9559	Poznámka k testu Test obecný 1 6-12. Osooba: 9 let úroveň 0	9509	5451
9560	Poznámka k testu Test obecný 1 6-12. Osooba: 9 let úroveň 1	9510	5451
9561	Poznámka k testu Test obecný 1 6-12. Osooba: 10 let úroveň 0	9511	5451
9562	Poznámka k testu Test obecný 1 6-12. Osooba: 10 let úroveň 1	9512	5451
9563	Poznámka k testu Test obecný 1 6-12. Osooba: 11 let úroveň 0	9513	5451
9564	Poznámka k testu Test obecný 1 6-12. Osooba: 11 let úroveň 1	9514	5451
9565	Poznámka k testu Test obecný 1 6-12. Osooba: 12 let úroveň 0	9515	5451
9566	Poznámka k testu Test obecný 1 6-12. Osooba: 12 let úroveň 1	9516	5451
9567	Poznámka k testu Test obecný 1 6-12. Osooba: 13 let úroveň 0	9517	5451
9568	Poznámka k testu Test obecný 1 6-12. Osooba: 13 let úroveň 1	9518	5451
9569	Poznámka k testu Test obecný 1 6-12. Osooba: 14 let úroveň 0	9519	5451
9570	Poznámka k testu Test obecný 1 6-12. Osooba: 14 let úroveň 1	9520	5451
9571	Poznámka k testu Test obecný 1 6-12. Osooba: 15 let úroveň 0	9521	5451
9572	Poznámka k testu Test obecný 1 6-12. Osooba: 15 let úroveň 1	9522	5451
9573	Poznámka k testu Test obecný 1 6-12. Osooba: 16 let úroveň 0	9523	5451
9574	Poznámka k testu Test obecný 1 6-12. Osooba: 16 let úroveň 1	9524	5451
9575	Poznámka k testu Test obecný 1 6-12. Osooba: 17 let úroveň 0	9525	5451
9576	Poznámka k testu Test obecný 1 6-12. Osooba: 17 let úroveň 1	9526	5451
9577	Poznámka k testu Test obecný 1 6-12. Osooba: 18 let úroveň 0	9527	5451
9578	Poznámka k testu Test obecný 1 6-12. Osooba: 18 let úroveň 1	9528	5451
9579	Poznámka k testu Test obecný 1 6-12. Osooba: 19 let úroveň 0	9529	5451
9580	Poznámka k testu Test obecný 1 6-12. Osooba: 19 let úroveň 1	9530	5451
9581	Poznámka k testu Test obecný 1 6-12. Osooba: 20 let úroveň 0	9531	5451
9582	Poznámka k testu Test obecný 1 6-12. Osooba: 20 let úroveň 1	9532	5451
9583	Poznámka k testu Test obecný 1 6-12. Osooba: 21 let úroveň 0	9533	5451
9584	Poznámka k testu Test obecný 1 6-12. Osooba: 21 let úroveň 1	9534	5451
9585	Poznámka k testu Test obecný 1 6-12. Osooba: 22 let úroveň 0	9535	5451
9586	Poznámka k testu Test obecný 1 6-12. Osooba: 22 let úroveň 1	9536	5451
9587	Poznámka k testu Test obecný 1 6-12. Osooba: 23 let úroveň 0	9537	5451
9588	Poznámka k testu Test obecný 1 6-12. Osooba: 23 let úroveň 1	9538	5451
9589	Poznámka k testu Test obecný 1 6-12. Osooba: 24 let úroveň 0	9539	5451
9590	Poznámka k testu Test obecný 1 6-12. Osooba: 24 let úroveň 1	9540	5451
9591	Poznámka k testu Test obecný 1 6-12. Osooba: 25 let úroveň 0	9541	5451
9592	Poznámka k testu Test obecný 1 6-12. Osooba: 25 let úroveň 1	9542	5451
9593	Poznámka k testu Test obecný 1 6-12. Osooba: 26 let úroveň 0	9543	5451
9594	Poznámka k testu Test obecný 1 6-12. Osooba: 26 let úroveň 1	9544	5451
9595	Poznámka k testu Test obecný 1 6-12. Osooba: 27 let úroveň 0	9545	5451
9596	Poznámka k testu Test obecný 1 6-12. Osooba: 27 let úroveň 1	9546	5451
9597	Poznámka k testu Test obecný 1 6-12. Osooba: 28 let úroveň 0	9547	5451
9598	Poznámka k testu Test obecný 1 6-12. Osooba: 28 let úroveň 1	9548	5451
9599	Poznámka k testu Test obecný 1 6-12. Osooba: 29 let úroveň 0	9549	5451
9600	Poznámka k testu Test obecný 1 6-12. Osooba: 29 let úroveň 1	9550	5451
10351	Poznámka k testu Test obecný 1 6-12. Osooba: 30 let úroveň 0	10301	5451
10352	Poznámka k testu Test obecný 1 6-12. Osooba: 30 let úroveň 1	10302	5451
10353	Poznámka k testu Test obecný 1 6-12. Osooba: 31 let úroveň 0	10303	5451
10354	Poznámka k testu Test obecný 1 6-12. Osooba: 31 let úroveň 1	10304	5451
10355	Poznámka k testu Test obecný 1 6-12. Osooba: 32 let úroveň 0	10305	5451
10356	Poznámka k testu Test obecný 1 6-12. Osooba: 32 let úroveň 1	10306	5451
10357	Poznámka k testu Test obecný 1 6-12. Osooba: 33 let úroveň 0	10307	5451
10358	Poznámka k testu Test obecný 1 6-12. Osooba: 33 let úroveň 1	10308	5451
10359	Poznámka k testu Test obecný 1 6-12. Osooba: 34 let úroveň 0	10309	5451
10360	Poznámka k testu Test obecný 1 6-12. Osooba: 34 let úroveň 1	10310	5451
10361	Poznámka k testu Test obecný 1 6-12. Osooba: 35 let úroveň 0	10311	5451
10362	Poznámka k testu Test obecný 1 6-12. Osooba: 35 let úroveň 1	10312	5451
10363	Poznámka k testu Test obecný 1 6-12. Osooba: 36 let úroveň 0	10313	5451
10364	Poznámka k testu Test obecný 1 6-12. Osooba: 36 let úroveň 1	10314	5451
10365	Poznámka k testu Test obecný 1 6-12. Osooba: 37 let úroveň 0	10315	5451
10366	Poznámka k testu Test obecný 1 6-12. Osooba: 37 let úroveň 1	10316	5451
10367	Poznámka k testu Test obecný 1 6-12. Osooba: 38 let úroveň 0	10317	5451
10368	Poznámka k testu Test obecný 1 6-12. Osooba: 38 let úroveň 1	10318	5451
10369	Poznámka k testu Test obecný 1 6-12. Osooba: 39 let úroveň 0	10319	5451
10370	Poznámka k testu Test obecný 1 6-12. Osooba: 39 let úroveň 1	10320	5451
10371	Poznámka k testu Test obecný 1 6-12. Osooba: 40 let úroveň 0	10321	5451
10372	Poznámka k testu Test obecný 1 6-12. Osooba: 40 let úroveň 1	10322	5451
10373	Poznámka k testu Test obecný 1 6-12. Osooba: 41 let úroveň 0	10323	5451
10374	Poznámka k testu Test obecný 1 6-12. Osooba: 41 let úroveň 1	10324	5451
10375	Poznámka k testu Test obecný 1 6-12. Osooba: 42 let úroveň 0	10325	5451
10376	Poznámka k testu Test obecný 1 6-12. Osooba: 42 let úroveň 1	10326	5451
10377	Poznámka k testu Test obecný 1 6-12. Osooba: 43 let úroveň 0	10327	5451
10378	Poznámka k testu Test obecný 1 6-12. Osooba: 43 let úroveň 1	10328	5451
10379	Poznámka k testu Test obecný 1 6-12. Osooba: 44 let úroveň 0	10329	5451
10380	Poznámka k testu Test obecný 1 6-12. Osooba: 44 let úroveň 1	10330	5451
10381	Poznámka k testu Test obecný 1 6-12. Osooba: 45 let úroveň 0	10331	5451
10382	Poznámka k testu Test obecný 1 6-12. Osooba: 45 let úroveň 1	10332	5451
10383	Poznámka k testu Test obecný 1 6-12. Osooba: 46 let úroveň 0	10333	5451
10384	Poznámka k testu Test obecný 1 6-12. Osooba: 46 let úroveň 1	10334	5451
10385	Poznámka k testu Test obecný 1 6-12. Osooba: 47 let úroveň 0	10335	5451
10386	Poznámka k testu Test obecný 1 6-12. Osooba: 47 let úroveň 1	10336	5451
10387	Poznámka k testu Test obecný 1 6-12. Osooba: 48 let úroveň 0	10337	5451
10388	Poznámka k testu Test obecný 1 6-12. Osooba: 48 let úroveň 1	10338	5451
10389	Poznámka k testu Test obecný 1 6-12. Osooba: 49 let úroveň 0	10339	5451
10390	Poznámka k testu Test obecný 1 6-12. Osooba: 49 let úroveň 1	10340	5451
10391	Poznámka k testu Test obecný 1 15+. Osooba: Jan Selinger	10341	5453
10392	Poznámka k testu Test obecný 1 15+. Osooba: Luděk Rous	10342	5453
10393	Poznámka k testu Test obecný 1 15+. Osooba: 6 let úroveň 0	10343	5453
10394	Poznámka k testu Test obecný 1 15+. Osooba: 6 let úroveň 1	10344	5453
10395	Poznámka k testu Test obecný 1 15+. Osooba: 7 let úroveň 0	10345	5453
10396	Poznámka k testu Test obecný 1 15+. Osooba: 7 let úroveň 1	10346	5453
10397	Poznámka k testu Test obecný 1 15+. Osooba: 8 let úroveň 0	10347	5453
10398	Poznámka k testu Test obecný 1 15+. Osooba: 8 let úroveň 1	10348	5453
10399	Poznámka k testu Test obecný 1 15+. Osooba: 9 let úroveň 0	10349	5453
10400	Poznámka k testu Test obecný 1 15+. Osooba: 9 let úroveň 1	10350	5453
11251	Poznámka k testu Test obecný 1 15+. Osooba: 10 let úroveň 0	11201	5453
11252	Poznámka k testu Test obecný 1 15+. Osooba: 10 let úroveň 1	11202	5453
11253	Poznámka k testu Test obecný 1 15+. Osooba: 11 let úroveň 0	11203	5453
11254	Poznámka k testu Test obecný 1 15+. Osooba: 11 let úroveň 1	11204	5453
11255	Poznámka k testu Test obecný 1 15+. Osooba: 12 let úroveň 0	11205	5453
11256	Poznámka k testu Test obecný 1 15+. Osooba: 12 let úroveň 1	11206	5453
11257	Poznámka k testu Test obecný 1 15+. Osooba: 13 let úroveň 0	11207	5453
11258	Poznámka k testu Test obecný 1 15+. Osooba: 13 let úroveň 1	11208	5453
11259	Poznámka k testu Test obecný 1 15+. Osooba: 14 let úroveň 0	11209	5453
11260	Poznámka k testu Test obecný 1 15+. Osooba: 14 let úroveň 1	11210	5453
11261	Poznámka k testu Test obecný 1 15+. Osooba: 15 let úroveň 0	11211	5453
11262	Poznámka k testu Test obecný 1 15+. Osooba: 15 let úroveň 1	11212	5453
11263	Poznámka k testu Test obecný 1 15+. Osooba: 16 let úroveň 0	11213	5453
11264	Poznámka k testu Test obecný 1 15+. Osooba: 16 let úroveň 1	11214	5453
11265	Poznámka k testu Test obecný 1 15+. Osooba: 17 let úroveň 0	11215	5453
11266	Poznámka k testu Test obecný 1 15+. Osooba: 17 let úroveň 1	11216	5453
11267	Poznámka k testu Test obecný 1 15+. Osooba: 18 let úroveň 0	11217	5453
11268	Poznámka k testu Test obecný 1 15+. Osooba: 18 let úroveň 1	11218	5453
11269	Poznámka k testu Test obecný 1 15+. Osooba: 19 let úroveň 0	11219	5453
11270	Poznámka k testu Test obecný 1 15+. Osooba: 19 let úroveň 1	11220	5453
11271	Poznámka k testu Test obecný 1 15+. Osooba: 20 let úroveň 0	11221	5453
11272	Poznámka k testu Test obecný 1 15+. Osooba: 20 let úroveň 1	11222	5453
11273	Poznámka k testu Test obecný 1 15+. Osooba: 21 let úroveň 0	11223	5453
11274	Poznámka k testu Test obecný 1 15+. Osooba: 21 let úroveň 1	11224	5453
11275	Poznámka k testu Test obecný 1 15+. Osooba: 22 let úroveň 0	11225	5453
11276	Poznámka k testu Test obecný 1 15+. Osooba: 22 let úroveň 1	11226	5453
11277	Poznámka k testu Test obecný 1 15+. Osooba: 23 let úroveň 0	11227	5453
11278	Poznámka k testu Test obecný 1 15+. Osooba: 23 let úroveň 1	11228	5453
11279	Poznámka k testu Test obecný 1 15+. Osooba: 24 let úroveň 0	11229	5453
11280	Poznámka k testu Test obecný 1 15+. Osooba: 24 let úroveň 1	11230	5453
11281	Poznámka k testu Test obecný 1 15+. Osooba: 25 let úroveň 0	11231	5453
11282	Poznámka k testu Test obecný 1 15+. Osooba: 25 let úroveň 1	11232	5453
11283	Poznámka k testu Test obecný 1 15+. Osooba: 26 let úroveň 0	11233	5453
11284	Poznámka k testu Test obecný 1 15+. Osooba: 26 let úroveň 1	11234	5453
11285	Poznámka k testu Test obecný 1 15+. Osooba: 27 let úroveň 0	11235	5453
11286	Poznámka k testu Test obecný 1 15+. Osooba: 27 let úroveň 1	11236	5453
11287	Poznámka k testu Test obecný 1 15+. Osooba: 28 let úroveň 0	11237	5453
11288	Poznámka k testu Test obecný 1 15+. Osooba: 28 let úroveň 1	11238	5453
11289	Poznámka k testu Test obecný 1 15+. Osooba: 29 let úroveň 0	11239	5453
11290	Poznámka k testu Test obecný 1 15+. Osooba: 29 let úroveň 1	11240	5453
11291	Poznámka k testu Test obecný 1 15+. Osooba: 30 let úroveň 0	11241	5453
11292	Poznámka k testu Test obecný 1 15+. Osooba: 30 let úroveň 1	11242	5453
11293	Poznámka k testu Test obecný 1 15+. Osooba: 31 let úroveň 0	11243	5453
11294	Poznámka k testu Test obecný 1 15+. Osooba: 31 let úroveň 1	11244	5453
11295	Poznámka k testu Test obecný 1 15+. Osooba: 32 let úroveň 0	11245	5453
11296	Poznámka k testu Test obecný 1 15+. Osooba: 32 let úroveň 1	11246	5453
11297	Poznámka k testu Test obecný 1 15+. Osooba: 33 let úroveň 0	11247	5453
11298	Poznámka k testu Test obecný 1 15+. Osooba: 33 let úroveň 1	11248	5453
11299	Poznámka k testu Test obecný 1 15+. Osooba: 34 let úroveň 0	11249	5453
11300	Poznámka k testu Test obecný 1 15+. Osooba: 34 let úroveň 1	11250	5453
12451	Poznámka k testu Test obecný 1 15+. Osooba: 35 let úroveň 0	12401	5453
12452	Poznámka k testu Test obecný 1 15+. Osooba: 35 let úroveň 1	12402	5453
12453	Poznámka k testu Test obecný 1 15+. Osooba: 36 let úroveň 0	12403	5453
12454	Poznámka k testu Test obecný 1 15+. Osooba: 36 let úroveň 1	12404	5453
12455	Poznámka k testu Test obecný 1 15+. Osooba: 37 let úroveň 0	12405	5453
12456	Poznámka k testu Test obecný 1 15+. Osooba: 37 let úroveň 1	12406	5453
12457	Poznámka k testu Test obecný 1 15+. Osooba: 38 let úroveň 0	12407	5453
12458	Poznámka k testu Test obecný 1 15+. Osooba: 38 let úroveň 1	12408	5453
12459	Poznámka k testu Test obecný 1 15+. Osooba: 39 let úroveň 0	12409	5453
12460	Poznámka k testu Test obecný 1 15+. Osooba: 39 let úroveň 1	12410	5453
12461	Poznámka k testu Test obecný 1 15+. Osooba: 40 let úroveň 0	12411	5453
12462	Poznámka k testu Test obecný 1 15+. Osooba: 40 let úroveň 1	12412	5453
12463	Poznámka k testu Test obecný 1 15+. Osooba: 41 let úroveň 0	12413	5453
12464	Poznámka k testu Test obecný 1 15+. Osooba: 41 let úroveň 1	12414	5453
12465	Poznámka k testu Test obecný 1 15+. Osooba: 42 let úroveň 0	12415	5453
12466	Poznámka k testu Test obecný 1 15+. Osooba: 42 let úroveň 1	12416	5453
12467	Poznámka k testu Test obecný 1 15+. Osooba: 43 let úroveň 0	12417	5453
12468	Poznámka k testu Test obecný 1 15+. Osooba: 43 let úroveň 1	12418	5453
12469	Poznámka k testu Test obecný 1 15+. Osooba: 44 let úroveň 0	12419	5453
12470	Poznámka k testu Test obecný 1 15+. Osooba: 44 let úroveň 1	12420	5453
12471	Poznámka k testu Test obecný 1 15+. Osooba: 45 let úroveň 0	12421	5453
12472	Poznámka k testu Test obecný 1 15+. Osooba: 45 let úroveň 1	12422	5453
12473	Poznámka k testu Test obecný 1 15+. Osooba: 46 let úroveň 0	12423	5453
12474	Poznámka k testu Test obecný 1 15+. Osooba: 46 let úroveň 1	12424	5453
12475	Poznámka k testu Test obecný 1 15+. Osooba: 47 let úroveň 0	12425	5453
12476	Poznámka k testu Test obecný 1 15+. Osooba: 47 let úroveň 1	12426	5453
12477	Poznámka k testu Test obecný 1 15+. Osooba: 48 let úroveň 0	12427	5453
12478	Poznámka k testu Test obecný 1 15+. Osooba: 48 let úroveň 1	12428	5453
12479	Poznámka k testu Test obecný 1 15+. Osooba: 49 let úroveň 0	12429	5453
12480	Poznámka k testu Test obecný 1 15+. Osooba: 49 let úroveň 1	12430	5453
12481	Poznámka k testu Test obecný 1 13-15. Osooba: Jan Selinger	12431	5452
12482	Poznámka k testu Test obecný 1 13-15. Osooba: Luděk Rous	12432	5452
12483	Poznámka k testu Test obecný 1 13-15. Osooba: 6 let úroveň 0	12433	5452
12484	Poznámka k testu Test obecný 1 13-15. Osooba: 6 let úroveň 1	12434	5452
12485	Poznámka k testu Test obecný 1 13-15. Osooba: 7 let úroveň 0	12435	5452
12486	Poznámka k testu Test obecný 1 13-15. Osooba: 7 let úroveň 1	12436	5452
12487	Poznámka k testu Test obecný 1 13-15. Osooba: 8 let úroveň 0	12437	5452
12488	Poznámka k testu Test obecný 1 13-15. Osooba: 8 let úroveň 1	12438	5452
12489	Poznámka k testu Test obecný 1 13-15. Osooba: 9 let úroveň 0	12439	5452
12490	Poznámka k testu Test obecný 1 13-15. Osooba: 9 let úroveň 1	12440	5452
12491	Poznámka k testu Test obecný 1 13-15. Osooba: 10 let úroveň 0	12441	5452
12492	Poznámka k testu Test obecný 1 13-15. Osooba: 10 let úroveň 1	12442	5452
12493	Poznámka k testu Test obecný 1 13-15. Osooba: 11 let úroveň 0	12443	5452
12494	Poznámka k testu Test obecný 1 13-15. Osooba: 11 let úroveň 1	12444	5452
12495	Poznámka k testu Test obecný 1 13-15. Osooba: 12 let úroveň 0	12445	5452
12496	Poznámka k testu Test obecný 1 13-15. Osooba: 12 let úroveň 1	12446	5452
12497	Poznámka k testu Test obecný 1 13-15. Osooba: 13 let úroveň 0	12447	5452
12498	Poznámka k testu Test obecný 1 13-15. Osooba: 13 let úroveň 1	12448	5452
12499	Poznámka k testu Test obecný 1 13-15. Osooba: 14 let úroveň 0	12449	5452
12500	Poznámka k testu Test obecný 1 13-15. Osooba: 14 let úroveň 1	12450	5452
13651	Poznámka k testu Test obecný 1 13-15. Osooba: 15 let úroveň 0	13601	5452
13652	Poznámka k testu Test obecný 1 13-15. Osooba: 15 let úroveň 1	13602	5452
13653	Poznámka k testu Test obecný 1 13-15. Osooba: 16 let úroveň 0	13603	5452
13654	Poznámka k testu Test obecný 1 13-15. Osooba: 16 let úroveň 1	13604	5452
13655	Poznámka k testu Test obecný 1 13-15. Osooba: 17 let úroveň 0	13605	5452
13656	Poznámka k testu Test obecný 1 13-15. Osooba: 17 let úroveň 1	13606	5452
13657	Poznámka k testu Test obecný 1 13-15. Osooba: 18 let úroveň 0	13607	5452
13658	Poznámka k testu Test obecný 1 13-15. Osooba: 18 let úroveň 1	13608	5452
13659	Poznámka k testu Test obecný 1 13-15. Osooba: 19 let úroveň 0	13609	5452
13660	Poznámka k testu Test obecný 1 13-15. Osooba: 19 let úroveň 1	13610	5452
13661	Poznámka k testu Test obecný 1 13-15. Osooba: 20 let úroveň 0	13611	5452
13662	Poznámka k testu Test obecný 1 13-15. Osooba: 20 let úroveň 1	13612	5452
13663	Poznámka k testu Test obecný 1 13-15. Osooba: 21 let úroveň 0	13613	5452
13664	Poznámka k testu Test obecný 1 13-15. Osooba: 21 let úroveň 1	13614	5452
13665	Poznámka k testu Test obecný 1 13-15. Osooba: 22 let úroveň 0	13615	5452
13666	Poznámka k testu Test obecný 1 13-15. Osooba: 22 let úroveň 1	13616	5452
13667	Poznámka k testu Test obecný 1 13-15. Osooba: 23 let úroveň 0	13617	5452
13668	Poznámka k testu Test obecný 1 13-15. Osooba: 23 let úroveň 1	13618	5452
13669	Poznámka k testu Test obecný 1 13-15. Osooba: 24 let úroveň 0	13619	5452
13670	Poznámka k testu Test obecný 1 13-15. Osooba: 24 let úroveň 1	13620	5452
13671	Poznámka k testu Test obecný 1 13-15. Osooba: 25 let úroveň 0	13621	5452
13672	Poznámka k testu Test obecný 1 13-15. Osooba: 25 let úroveň 1	13622	5452
13673	Poznámka k testu Test obecný 1 13-15. Osooba: 26 let úroveň 0	13623	5452
13674	Poznámka k testu Test obecný 1 13-15. Osooba: 26 let úroveň 1	13624	5452
13675	Poznámka k testu Test obecný 1 13-15. Osooba: 27 let úroveň 0	13625	5452
13676	Poznámka k testu Test obecný 1 13-15. Osooba: 27 let úroveň 1	13626	5452
13677	Poznámka k testu Test obecný 1 13-15. Osooba: 28 let úroveň 0	13627	5452
13678	Poznámka k testu Test obecný 1 13-15. Osooba: 28 let úroveň 1	13628	5452
13679	Poznámka k testu Test obecný 1 13-15. Osooba: 29 let úroveň 0	13629	5452
13680	Poznámka k testu Test obecný 1 13-15. Osooba: 29 let úroveň 1	13630	5452
13681	Poznámka k testu Test obecný 1 13-15. Osooba: 30 let úroveň 0	13631	5452
13682	Poznámka k testu Test obecný 1 13-15. Osooba: 30 let úroveň 1	13632	5452
13683	Poznámka k testu Test obecný 1 13-15. Osooba: 31 let úroveň 0	13633	5452
13684	Poznámka k testu Test obecný 1 13-15. Osooba: 31 let úroveň 1	13634	5452
13685	Poznámka k testu Test obecný 1 13-15. Osooba: 32 let úroveň 0	13635	5452
13686	Poznámka k testu Test obecný 1 13-15. Osooba: 32 let úroveň 1	13636	5452
13687	Poznámka k testu Test obecný 1 13-15. Osooba: 33 let úroveň 0	13637	5452
13688	Poznámka k testu Test obecný 1 13-15. Osooba: 33 let úroveň 1	13638	5452
13689	Poznámka k testu Test obecný 1 13-15. Osooba: 34 let úroveň 0	13639	5452
13690	Poznámka k testu Test obecný 1 13-15. Osooba: 34 let úroveň 1	13640	5452
13691	Poznámka k testu Test obecný 1 13-15. Osooba: 35 let úroveň 0	13641	5452
13692	Poznámka k testu Test obecný 1 13-15. Osooba: 35 let úroveň 1	13642	5452
13693	Poznámka k testu Test obecný 1 13-15. Osooba: 36 let úroveň 0	13643	5452
13694	Poznámka k testu Test obecný 1 13-15. Osooba: 36 let úroveň 1	13644	5452
13695	Poznámka k testu Test obecný 1 13-15. Osooba: 37 let úroveň 0	13645	5452
13696	Poznámka k testu Test obecný 1 13-15. Osooba: 37 let úroveň 1	13646	5452
13697	Poznámka k testu Test obecný 1 13-15. Osooba: 38 let úroveň 0	13647	5452
13698	Poznámka k testu Test obecný 1 13-15. Osooba: 38 let úroveň 1	13648	5452
13699	Poznámka k testu Test obecný 1 13-15. Osooba: 39 let úroveň 0	13649	5452
13700	Poznámka k testu Test obecný 1 13-15. Osooba: 39 let úroveň 1	13650	5452
14801	Poznámka k testu Test obecný 1 13-15. Osooba: 40 let úroveň 0	14751	5452
14802	Poznámka k testu Test obecný 1 13-15. Osooba: 40 let úroveň 1	14752	5452
14803	Poznámka k testu Test obecný 1 13-15. Osooba: 41 let úroveň 0	14753	5452
14804	Poznámka k testu Test obecný 1 13-15. Osooba: 41 let úroveň 1	14754	5452
14805	Poznámka k testu Test obecný 1 13-15. Osooba: 42 let úroveň 0	14755	5452
14806	Poznámka k testu Test obecný 1 13-15. Osooba: 42 let úroveň 1	14756	5452
14807	Poznámka k testu Test obecný 1 13-15. Osooba: 43 let úroveň 0	14757	5452
14808	Poznámka k testu Test obecný 1 13-15. Osooba: 43 let úroveň 1	14758	5452
14809	Poznámka k testu Test obecný 1 13-15. Osooba: 44 let úroveň 0	14759	5452
14810	Poznámka k testu Test obecný 1 13-15. Osooba: 44 let úroveň 1	14760	5452
14811	Poznámka k testu Test obecný 1 13-15. Osooba: 45 let úroveň 0	14761	5452
14812	Poznámka k testu Test obecný 1 13-15. Osooba: 45 let úroveň 1	14762	5452
14813	Poznámka k testu Test obecný 1 13-15. Osooba: 46 let úroveň 0	14763	5452
14814	Poznámka k testu Test obecný 1 13-15. Osooba: 46 let úroveň 1	14764	5452
14815	Poznámka k testu Test obecný 1 13-15. Osooba: 47 let úroveň 0	14765	5452
14816	Poznámka k testu Test obecný 1 13-15. Osooba: 47 let úroveň 1	14766	5452
14817	Poznámka k testu Test obecný 1 13-15. Osooba: 48 let úroveň 0	14767	5452
14818	Poznámka k testu Test obecný 1 13-15. Osooba: 48 let úroveň 1	14768	5452
14819	Poznámka k testu Test obecný 1 13-15. Osooba: 49 let úroveň 0	14769	5452
14820	Poznámka k testu Test obecný 1 13-15. Osooba: 49 let úroveň 1	14770	5452
14821	Poznámka k testu Test obecný 1 13-15. Osooba: Jan Selinger	14771	5452
14822	Poznámka k testu Test obecný 1 13-15. Osooba: Luděk Rous	14772	5452
14823	Poznámka k testu Test obecný 1 13-15. Osooba: 6 let úroveň 0	14773	5452
14824	Poznámka k testu Test obecný 1 13-15. Osooba: 6 let úroveň 1	14774	5452
14825	Poznámka k testu Test obecný 1 13-15. Osooba: 7 let úroveň 0	14775	5452
14826	Poznámka k testu Test obecný 1 13-15. Osooba: 7 let úroveň 1	14776	5452
14827	Poznámka k testu Test obecný 1 13-15. Osooba: 8 let úroveň 0	14777	5452
14828	Poznámka k testu Test obecný 1 13-15. Osooba: 8 let úroveň 1	14778	5452
14829	Poznámka k testu Test obecný 1 13-15. Osooba: 9 let úroveň 0	14779	5452
14830	Poznámka k testu Test obecný 1 13-15. Osooba: 9 let úroveň 1	14780	5452
14831	Poznámka k testu Test obecný 1 13-15. Osooba: 10 let úroveň 0	14781	5452
14832	Poznámka k testu Test obecný 1 13-15. Osooba: 10 let úroveň 1	14782	5452
14833	Poznámka k testu Test obecný 1 13-15. Osooba: 11 let úroveň 0	14783	5452
14834	Poznámka k testu Test obecný 1 13-15. Osooba: 11 let úroveň 1	14784	5452
14835	Poznámka k testu Test obecný 1 13-15. Osooba: 12 let úroveň 0	14785	5452
14836	Poznámka k testu Test obecný 1 13-15. Osooba: 12 let úroveň 1	14786	5452
14837	Poznámka k testu Test obecný 1 13-15. Osooba: 13 let úroveň 0	14787	5452
14838	Poznámka k testu Test obecný 1 13-15. Osooba: 13 let úroveň 1	14788	5452
14839	Poznámka k testu Test obecný 1 13-15. Osooba: 14 let úroveň 0	14789	5452
14840	Poznámka k testu Test obecný 1 13-15. Osooba: 14 let úroveň 1	14790	5452
14841	Poznámka k testu Test obecný 1 13-15. Osooba: 15 let úroveň 0	14791	5452
14842	Poznámka k testu Test obecný 1 13-15. Osooba: 15 let úroveň 1	14792	5452
14843	Poznámka k testu Test obecný 1 13-15. Osooba: 16 let úroveň 0	14793	5452
14844	Poznámka k testu Test obecný 1 13-15. Osooba: 16 let úroveň 1	14794	5452
14845	Poznámka k testu Test obecný 1 13-15. Osooba: 17 let úroveň 0	14795	5452
14846	Poznámka k testu Test obecný 1 13-15. Osooba: 17 let úroveň 1	14796	5452
14847	Poznámka k testu Test obecný 1 13-15. Osooba: 18 let úroveň 0	14797	5452
14848	Poznámka k testu Test obecný 1 13-15. Osooba: 18 let úroveň 1	14798	5452
14849	Poznámka k testu Test obecný 1 13-15. Osooba: 19 let úroveň 0	14799	5452
14850	Poznámka k testu Test obecný 1 13-15. Osooba: 19 let úroveň 1	14800	5452
15951	Poznámka k testu Test obecný 1 13-15. Osooba: 20 let úroveň 0	15901	5452
15952	Poznámka k testu Test obecný 1 13-15. Osooba: 20 let úroveň 1	15902	5452
15953	Poznámka k testu Test obecný 1 13-15. Osooba: 21 let úroveň 0	15903	5452
15954	Poznámka k testu Test obecný 1 13-15. Osooba: 21 let úroveň 1	15904	5452
15955	Poznámka k testu Test obecný 1 13-15. Osooba: 22 let úroveň 0	15905	5452
15956	Poznámka k testu Test obecný 1 13-15. Osooba: 22 let úroveň 1	15906	5452
15957	Poznámka k testu Test obecný 1 13-15. Osooba: 23 let úroveň 0	15907	5452
15958	Poznámka k testu Test obecný 1 13-15. Osooba: 23 let úroveň 1	15908	5452
15959	Poznámka k testu Test obecný 1 13-15. Osooba: 24 let úroveň 0	15909	5452
15960	Poznámka k testu Test obecný 1 13-15. Osooba: 24 let úroveň 1	15910	5452
15961	Poznámka k testu Test obecný 1 13-15. Osooba: 25 let úroveň 0	15911	5452
15962	Poznámka k testu Test obecný 1 13-15. Osooba: 25 let úroveň 1	15912	5452
15963	Poznámka k testu Test obecný 1 13-15. Osooba: 26 let úroveň 0	15913	5452
15964	Poznámka k testu Test obecný 1 13-15. Osooba: 26 let úroveň 1	15914	5452
15965	Poznámka k testu Test obecný 1 13-15. Osooba: 27 let úroveň 0	15915	5452
15966	Poznámka k testu Test obecný 1 13-15. Osooba: 27 let úroveň 1	15916	5452
15967	Poznámka k testu Test obecný 1 13-15. Osooba: 28 let úroveň 0	15917	5452
15968	Poznámka k testu Test obecný 1 13-15. Osooba: 28 let úroveň 1	15918	5452
15969	Poznámka k testu Test obecný 1 13-15. Osooba: 29 let úroveň 0	15919	5452
15970	Poznámka k testu Test obecný 1 13-15. Osooba: 29 let úroveň 1	15920	5452
15971	Poznámka k testu Test obecný 1 13-15. Osooba: 30 let úroveň 0	15921	5452
15972	Poznámka k testu Test obecný 1 13-15. Osooba: 30 let úroveň 1	15922	5452
15973	Poznámka k testu Test obecný 1 13-15. Osooba: 31 let úroveň 0	15923	5452
15974	Poznámka k testu Test obecný 1 13-15. Osooba: 31 let úroveň 1	15924	5452
15975	Poznámka k testu Test obecný 1 13-15. Osooba: 32 let úroveň 0	15925	5452
15976	Poznámka k testu Test obecný 1 13-15. Osooba: 32 let úroveň 1	15926	5452
15977	Poznámka k testu Test obecný 1 13-15. Osooba: 33 let úroveň 0	15927	5452
15978	Poznámka k testu Test obecný 1 13-15. Osooba: 33 let úroveň 1	15928	5452
15979	Poznámka k testu Test obecný 1 13-15. Osooba: 34 let úroveň 0	15929	5452
15980	Poznámka k testu Test obecný 1 13-15. Osooba: 34 let úroveň 1	15930	5452
15981	Poznámka k testu Test obecný 1 13-15. Osooba: 35 let úroveň 0	15931	5452
15982	Poznámka k testu Test obecný 1 13-15. Osooba: 35 let úroveň 1	15932	5452
15983	Poznámka k testu Test obecný 1 13-15. Osooba: 36 let úroveň 0	15933	5452
15984	Poznámka k testu Test obecný 1 13-15. Osooba: 36 let úroveň 1	15934	5452
15985	Poznámka k testu Test obecný 1 13-15. Osooba: 37 let úroveň 0	15935	5452
15986	Poznámka k testu Test obecný 1 13-15. Osooba: 37 let úroveň 1	15936	5452
15987	Poznámka k testu Test obecný 1 13-15. Osooba: 38 let úroveň 0	15937	5452
15988	Poznámka k testu Test obecný 1 13-15. Osooba: 38 let úroveň 1	15938	5452
15989	Poznámka k testu Test obecný 1 13-15. Osooba: 39 let úroveň 0	15939	5452
15990	Poznámka k testu Test obecný 1 13-15. Osooba: 39 let úroveň 1	15940	5452
15991	Poznámka k testu Test obecný 1 13-15. Osooba: 40 let úroveň 0	15941	5452
15992	Poznámka k testu Test obecný 1 13-15. Osooba: 40 let úroveň 1	15942	5452
15993	Poznámka k testu Test obecný 1 13-15. Osooba: 41 let úroveň 0	15943	5452
15994	Poznámka k testu Test obecný 1 13-15. Osooba: 41 let úroveň 1	15944	5452
15995	Poznámka k testu Test obecný 1 13-15. Osooba: 42 let úroveň 0	15945	5452
15996	Poznámka k testu Test obecný 1 13-15. Osooba: 42 let úroveň 1	15946	5452
15997	Poznámka k testu Test obecný 1 13-15. Osooba: 43 let úroveň 0	15947	5452
15998	Poznámka k testu Test obecný 1 13-15. Osooba: 43 let úroveň 1	15948	5452
15999	Poznámka k testu Test obecný 1 13-15. Osooba: 44 let úroveň 0	15949	5452
16000	Poznámka k testu Test obecný 1 13-15. Osooba: 44 let úroveň 1	15950	5452
17101	Poznámka k testu Test obecný 1 13-15. Osooba: 45 let úroveň 0	17051	5452
17102	Poznámka k testu Test obecný 1 13-15. Osooba: 45 let úroveň 1	17052	5452
17103	Poznámka k testu Test obecný 1 13-15. Osooba: 46 let úroveň 0	17053	5452
17104	Poznámka k testu Test obecný 1 13-15. Osooba: 46 let úroveň 1	17054	5452
17105	Poznámka k testu Test obecný 1 13-15. Osooba: 47 let úroveň 0	17055	5452
17106	Poznámka k testu Test obecný 1 13-15. Osooba: 47 let úroveň 1	17056	5452
17107	Poznámka k testu Test obecný 1 13-15. Osooba: 48 let úroveň 0	17057	5452
17108	Poznámka k testu Test obecný 1 13-15. Osooba: 48 let úroveň 1	17058	5452
17109	Poznámka k testu Test obecný 1 13-15. Osooba: 49 let úroveň 0	17059	5452
17110	Poznámka k testu Test obecný 1 13-15. Osooba: 49 let úroveň 1	17060	5452
\.


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 198
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: jt-testing
--

SELECT pg_catalog.setval('hibernate_sequence', 17400, true);


--
-- TOC entry 2807 (class 2606 OID 60454)
-- Name: activity_categories activity_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_categories
    ADD CONSTRAINT activity_categories_pkey PRIMARY KEY (activities_id, categories_id);


--
-- TOC entry 2833 (class 2606 OID 60624)
-- Name: event_attached_persons event_attached_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_attached_persons
    ADD CONSTRAINT event_attached_persons_pkey PRIMARY KEY (events_id, attached_persons_id);


--
-- TOC entry 2795 (class 2606 OID 60418)
-- Name: event_tests event_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_tests
    ADD CONSTRAINT event_tests_pkey PRIMARY KEY (events_id, tests_id);


--
-- TOC entry 2791 (class 2606 OID 60401)
-- Name: jhi_persistent_audit_evt_data jhi_persistent_audit_evt_data_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_persistent_audit_evt_data
    ADD CONSTRAINT jhi_persistent_audit_evt_data_pkey PRIMARY KEY (event_id, name);


--
-- TOC entry 2785 (class 2606 OID 60381)
-- Name: jhi_user_authority jhi_user_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user_authority
    ADD CONSTRAINT jhi_user_authority_pkey PRIMARY KEY (user_id, authority_name);


--
-- TOC entry 2799 (class 2606 OID 60431)
-- Name: jttest_activities jttest_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_activities
    ADD CONSTRAINT jttest_activities_pkey PRIMARY KEY (jttests_id, activities_id);


--
-- TOC entry 2801 (class 2606 OID 60436)
-- Name: jttest_categories jttest_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_categories
    ADD CONSTRAINT jttest_categories_pkey PRIMARY KEY (jttests_id, categories_id);


--
-- TOC entry 2803 (class 2606 OID 60441)
-- Name: jttest_sports jttest_sports_pkey; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_sports
    ADD CONSTRAINT jttest_sports_pkey PRIMARY KEY (jttests_id, sports_id);


--
-- TOC entry 2819 (class 2606 OID 60494)
-- Name: person person_address_id_key; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_address_id_key UNIQUE (address_id);


--
-- TOC entry 2821 (class 2606 OID 60492)
-- Name: person person_personal_data_id_key; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_personal_data_id_key UNIQUE (personal_data_id);


--
-- TOC entry 2805 (class 2606 OID 60449)
-- Name: activity pk_activity; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id);


--
-- TOC entry 2811 (class 2606 OID 60470)
-- Name: activity_category pk_activity_category; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_category
    ADD CONSTRAINT pk_activity_category PRIMARY KEY (id);


--
-- TOC entry 2817 (class 2606 OID 60485)
-- Name: activity_result pk_activity_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_result
    ADD CONSTRAINT pk_activity_result PRIMARY KEY (id);


--
-- TOC entry 2829 (class 2606 OID 60510)
-- Name: address pk_address; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY address
    ADD CONSTRAINT pk_address PRIMARY KEY (id);


--
-- TOC entry 2775 (class 2606 OID 60350)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 2793 (class 2606 OID 60413)
-- Name: event pk_event; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event
    ADD CONSTRAINT pk_event PRIMARY KEY (id);


--
-- TOC entry 2813 (class 2606 OID 60475)
-- Name: event_result pk_event_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_result
    ADD CONSTRAINT pk_event_result PRIMARY KEY (id);


--
-- TOC entry 2783 (class 2606 OID 60376)
-- Name: jhi_authority pk_jhi_authority; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_authority
    ADD CONSTRAINT pk_jhi_authority PRIMARY KEY (name);


--
-- TOC entry 2788 (class 2606 OID 60396)
-- Name: jhi_persistent_audit_event pk_jhi_persistent_audit_event; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_persistent_audit_event
    ADD CONSTRAINT pk_jhi_persistent_audit_event PRIMARY KEY (event_id);


--
-- TOC entry 2777 (class 2606 OID 60367)
-- Name: jhi_user pk_jhi_user; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user
    ADD CONSTRAINT pk_jhi_user PRIMARY KEY (id);


--
-- TOC entry 2797 (class 2606 OID 60426)
-- Name: jt_test pk_jt_test; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jt_test
    ADD CONSTRAINT pk_jt_test PRIMARY KEY (id);


--
-- TOC entry 2823 (class 2606 OID 60490)
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT pk_person PRIMARY KEY (id);


--
-- TOC entry 2827 (class 2606 OID 60502)
-- Name: personal_data pk_personal_data; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY personal_data
    ADD CONSTRAINT pk_personal_data PRIMARY KEY (id);


--
-- TOC entry 2831 (class 2606 OID 60515)
-- Name: sport pk_sport; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY sport
    ADD CONSTRAINT pk_sport PRIMARY KEY (id);


--
-- TOC entry 2809 (class 2606 OID 60462)
-- Name: test_category pk_test_category; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY test_category
    ADD CONSTRAINT pk_test_category PRIMARY KEY (id);


--
-- TOC entry 2815 (class 2606 OID 60480)
-- Name: test_result pk_test_result; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT pk_test_result PRIMARY KEY (id);


--
-- TOC entry 2825 (class 2606 OID 60613)
-- Name: person uc_personuser_id_col; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT uc_personuser_id_col UNIQUE (user_id);


--
-- TOC entry 2779 (class 2606 OID 60369)
-- Name: jhi_user ux_user_email; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user
    ADD CONSTRAINT ux_user_email UNIQUE (email);


--
-- TOC entry 2781 (class 2606 OID 60371)
-- Name: jhi_user ux_user_login; Type: CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user
    ADD CONSTRAINT ux_user_login UNIQUE (login);


--
-- TOC entry 2786 (class 1259 OID 60402)
-- Name: idx_persistent_audit_event; Type: INDEX; Schema: public; Owner: jt-testing
--

CREATE INDEX idx_persistent_audit_event ON public.jhi_persistent_audit_event USING btree (principal, event_date);


--
-- TOC entry 2789 (class 1259 OID 60403)
-- Name: idx_persistent_audit_evt_data; Type: INDEX; Schema: public; Owner: jt-testing
--

CREATE INDEX idx_persistent_audit_evt_data ON public.jhi_persistent_audit_evt_data USING btree (event_id);


--
-- TOC entry 2858 (class 2606 OID 60625)
-- Name: event_attached_persons FKcc1cq3mo95k6xp5duh287cfsv; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_attached_persons
    ADD CONSTRAINT "FKcc1cq3mo95k6xp5duh287cfsv" FOREIGN KEY (attached_persons_id) REFERENCES person(id);


--
-- TOC entry 2857 (class 2606 OID 60614)
-- Name: person FKe9y2rjb98wsg2nnk3eyrvc2ss; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT "FKe9y2rjb98wsg2nnk3eyrvc2ss" FOREIGN KEY (user_id) REFERENCES jhi_user(id);


--
-- TOC entry 2848 (class 2606 OID 62476)
-- Name: activity_category FKnxdhln28xokjbv8cwfj372fny; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_category
    ADD CONSTRAINT "FKnxdhln28xokjbv8cwfj372fny" FOREIGN KEY (parent_id) REFERENCES activity_category(id);


--
-- TOC entry 2859 (class 2606 OID 60630)
-- Name: event_attached_persons FKtlu2ktd0nahrhonnjrbjjrkwe; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_attached_persons
    ADD CONSTRAINT "FKtlu2ktd0nahrhonnjrbjjrkwe" FOREIGN KEY (events_id) REFERENCES event(id);


--
-- TOC entry 2846 (class 2606 OID 60561)
-- Name: activity_categories fk_activity_categories_activities_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_categories
    ADD CONSTRAINT fk_activity_categories_activities_id FOREIGN KEY (activities_id) REFERENCES activity(id);


--
-- TOC entry 2847 (class 2606 OID 60566)
-- Name: activity_categories fk_activity_categories_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_categories
    ADD CONSTRAINT fk_activity_categories_categories_id FOREIGN KEY (categories_id) REFERENCES activity_category(id);


--
-- TOC entry 2854 (class 2606 OID 60596)
-- Name: activity_result fk_activity_result_activity_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_result
    ADD CONSTRAINT fk_activity_result_activity_id FOREIGN KEY (activity_id) REFERENCES activity(id);


--
-- TOC entry 2853 (class 2606 OID 60591)
-- Name: activity_result fk_activity_result_test_result_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_result
    ADD CONSTRAINT fk_activity_result_test_result_id FOREIGN KEY (test_result_id) REFERENCES test_result(id);


--
-- TOC entry 2834 (class 2606 OID 60382)
-- Name: jhi_user_authority fk_authority_name; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user_authority
    ADD CONSTRAINT fk_authority_name FOREIGN KEY (authority_name) REFERENCES jhi_authority(name);


--
-- TOC entry 2837 (class 2606 OID 60516)
-- Name: event fk_event_address_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event
    ADD CONSTRAINT fk_event_address_id FOREIGN KEY (address_id) REFERENCES address(id);


--
-- TOC entry 2849 (class 2606 OID 60571)
-- Name: event_result fk_event_result_event_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_result
    ADD CONSTRAINT fk_event_result_event_id FOREIGN KEY (event_id) REFERENCES event(id);


--
-- TOC entry 2850 (class 2606 OID 60576)
-- Name: event_result fk_event_result_person_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_result
    ADD CONSTRAINT fk_event_result_person_id FOREIGN KEY (person_id) REFERENCES person(id);


--
-- TOC entry 2838 (class 2606 OID 60521)
-- Name: event_tests fk_event_tests_events_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_tests
    ADD CONSTRAINT fk_event_tests_events_id FOREIGN KEY (events_id) REFERENCES event(id);


--
-- TOC entry 2839 (class 2606 OID 60526)
-- Name: event_tests fk_event_tests_tests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_tests
    ADD CONSTRAINT fk_event_tests_tests_id FOREIGN KEY (tests_id) REFERENCES jt_test(id);


--
-- TOC entry 2836 (class 2606 OID 60404)
-- Name: jhi_persistent_audit_evt_data fk_evt_pers_audit_evt_data; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_persistent_audit_evt_data
    ADD CONSTRAINT fk_evt_pers_audit_evt_data FOREIGN KEY (event_id) REFERENCES jhi_persistent_audit_event(event_id);


--
-- TOC entry 2841 (class 2606 OID 60536)
-- Name: jttest_activities fk_jttest_activities_activities_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_activities
    ADD CONSTRAINT fk_jttest_activities_activities_id FOREIGN KEY (activities_id) REFERENCES activity(id);


--
-- TOC entry 2840 (class 2606 OID 60531)
-- Name: jttest_activities fk_jttest_activities_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_activities
    ADD CONSTRAINT fk_jttest_activities_jttests_id FOREIGN KEY (jttests_id) REFERENCES jt_test(id);


--
-- TOC entry 2843 (class 2606 OID 60546)
-- Name: jttest_categories fk_jttest_categories_categories_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_categories
    ADD CONSTRAINT fk_jttest_categories_categories_id FOREIGN KEY (categories_id) REFERENCES test_category(id);


--
-- TOC entry 2842 (class 2606 OID 60541)
-- Name: jttest_categories fk_jttest_categories_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_categories
    ADD CONSTRAINT fk_jttest_categories_jttests_id FOREIGN KEY (jttests_id) REFERENCES jt_test(id);


--
-- TOC entry 2844 (class 2606 OID 60551)
-- Name: jttest_sports fk_jttest_sports_jttests_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_sports
    ADD CONSTRAINT fk_jttest_sports_jttests_id FOREIGN KEY (jttests_id) REFERENCES jt_test(id);


--
-- TOC entry 2845 (class 2606 OID 60556)
-- Name: jttest_sports fk_jttest_sports_sports_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jttest_sports
    ADD CONSTRAINT fk_jttest_sports_sports_id FOREIGN KEY (sports_id) REFERENCES sport(id);


--
-- TOC entry 2856 (class 2606 OID 60606)
-- Name: person fk_person_address_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fk_person_address_id FOREIGN KEY (address_id) REFERENCES address(id);


--
-- TOC entry 2855 (class 2606 OID 60601)
-- Name: person fk_person_personal_data_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fk_person_personal_data_id FOREIGN KEY (personal_data_id) REFERENCES personal_data(id);


--
-- TOC entry 2851 (class 2606 OID 60581)
-- Name: test_result fk_test_result_event_result_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT fk_test_result_event_result_id FOREIGN KEY (event_result_id) REFERENCES event_result(id);


--
-- TOC entry 2852 (class 2606 OID 60586)
-- Name: test_result fk_test_result_test_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT fk_test_result_test_id FOREIGN KEY (test_id) REFERENCES jt_test(id);


--
-- TOC entry 2835 (class 2606 OID 60387)
-- Name: jhi_user_authority fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY jhi_user_authority
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES jhi_user(id);


-- Completed on 2018-12-08 23:20:14

--
-- PostgreSQL database dump complete
--

