--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.1

-- Started on 2018-12-05 14:09:35

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
5815	\N	\N	\N	5752	5258
5816	\N	\N	\N	5752	5261
5817	\N	\N	\N	5752	5253
5818	\N	\N	\N	5752	5254
5819	\N	\N	\N	5752	5276
5820	\N	\N	\N	5752	5256
5821	\N	\N	\N	5752	5275
5822	\N	\N	\N	5752	5274
5823	\N	\N	\N	5752	5257
5827	\N	\N	\N	5752	5277
5828	\N	\N	\N	5752	5262
6651	\N	\N	\N	6601	5261
6652	\N	\N	\N	6601	5256
6653	\N	\N	\N	6601	5253
6654	\N	\N	\N	6601	5254
6655	\N	\N	\N	6601	5276
6656	\N	\N	\N	6601	5269
6657	\N	\N	\N	6601	5257
6658	\N	\N	\N	6601	5275
6659	\N	\N	\N	6601	5274
5801	\N	\N	\N	5751	5276
5802	\N	\N	\N	5751	5256
5803	\N	\N	\N	5751	5253
5804	\N	\N	\N	5751	5254
5805	\N	\N	\N	5751	5265
5806	\N	\N	\N	5751	5274
5807	\N	\N	\N	5751	5277
5808	\N	\N	\N	5751	5269
5809	\N	\N	\N	5751	5257
5810	\N	\N	\N	5751	5258
5811	\N	\N	\N	5751	5260
5812	\N	\N	\N	5751	5275
5813	\N	\N	\N	5751	5261
5814	\N	\N	\N	5751	5262
6660	\N	\N	\N	6601	5277
6661	\N	\N	\N	6601	5258
6662	\N	\N	\N	6601	5260
6663	\N	\N	\N	6601	5265
6664	\N	\N	\N	6601	5262
5824	15	\N	\N	5752	5269
5825	15	\N	\N	5752	5260
6665	10	30	\N	6602	5266
6666	10	30	\N	6602	6701
5826	15	\N	\N	5752	5265
7201	41	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 0	7151	5254
7202	35	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 0	7151	5253
7203	52	37	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 0	7151	5256
6667	20	30	\N	6603	5266
6668	20	30	\N	6603	6701
7204	87	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 0	7151	5277
7205	61	33	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 0	7151	5257
6669	11	30	\N	6604	5266
6670	11	30	\N	6604	6701
7206	34	34	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 0	7151	5276
7207	28	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 0	7151	5258
6672	14	30	\N	6605	6701
6671	14	30	\N	6605	5266
7208	31	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 0	7151	5260
7209	90	49	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 0	7151	5261
6673	12	30	\N	6606	5266
6674	22	30	\N	6606	6701
7210	45	34	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 0	7151	5262
7211	86	43	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 0	7151	5265
6675	22	30	\N	6607	5266
6676	22	30	\N	6607	6701
7212	52	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 0	7151	5275
7213	66	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 0	7151	5269
6677	13	30	\N	6608	5266
6678	13	30	\N	6608	6701
7214	35	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 0	7151	5274
7215	35	50	Poznámka k aktivitě Překážková dráha. Osooba: 6 let úroveň 1	7152	5257
6679	23	30	\N	6609	5266
6680	23	30	\N	6609	6701
7216	20	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 6 let úroveň 1	7152	5253
7217	41	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 6 let úroveň 1	7152	5254
6681	14	30	\N	6610	5266
6682	14	30	\N	6610	6701
7218	32	41	Poznámka k aktivitě Letmý start. Osooba: 6 let úroveň 1	7152	5256
7219	64	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 6 let úroveň 1	7152	5258
6683	24	30	\N	6611	5266
6684	24	30	\N	6611	6701
7220	88	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 6 let úroveň 1	7152	5260
7221	35	45	Poznámka k aktivitě Lowa brace test. Osooba: 6 let úroveň 1	7152	5261
7222	92	35	Poznámka k aktivitě Slalom s míčem. Osooba: 6 let úroveň 1	7152	5276
7223	85	39	Poznámka k aktivitě Žebřík. Osooba: 6 let úroveň 1	7152	5262
7224	76	32	Poznámka k aktivitě Skok daleký. Osooba: 6 let úroveň 1	7152	5265
7225	61	\N	Poznámka k aktivitě slalom. Osooba: 6 let úroveň 1	7152	5269
7226	28	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 6 let úroveň 1	7152	5277
7227	80	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 6 let úroveň 1	7152	5274
7228	85	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 6 let úroveň 1	7152	5275
7229	33	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 0	7153	5258
7230	47	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 0	7153	5253
7231	22	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 0	7153	5254
7232	94	42	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 0	7153	5256
7233	31	32	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 0	7153	5257
7234	86	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 0	7153	5275
7235	96	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 0	7153	5277
7236	76	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 0	7153	5260
7237	20	32	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 0	7153	5261
7238	23	40	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 0	7153	5262
7239	71	39	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 0	7153	5265
7240	66	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 0	7153	5269
7241	79	34	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 0	7153	5276
7242	43	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 0	7153	5274
7243	79	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 7 let úroveň 1	7154	5260
7244	58	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 7 let úroveň 1	7154	5253
7245	97	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 7 let úroveň 1	7154	5254
7246	32	48	Poznámka k aktivitě Slalom s míčem. Osooba: 7 let úroveň 1	7154	5276
7247	67	33	Poznámka k aktivitě Letmý start. Osooba: 7 let úroveň 1	7154	5256
7248	45	38	Poznámka k aktivitě Překážková dráha. Osooba: 7 let úroveň 1	7154	5257
7249	34	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 7 let úroveň 1	7154	5258
7250	32	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 7 let úroveň 1	7154	5277
7251	90	38	Poznámka k aktivitě Lowa brace test. Osooba: 7 let úroveň 1	7154	5261
7252	87	47	Poznámka k aktivitě Žebřík. Osooba: 7 let úroveň 1	7154	5262
7253	29	34	Poznámka k aktivitě Skok daleký. Osooba: 7 let úroveň 1	7154	5265
7254	61	\N	Poznámka k aktivitě slalom. Osooba: 7 let úroveň 1	7154	5269
7255	63	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 7 let úroveň 1	7154	5275
7256	37	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 7 let úroveň 1	7154	5274
7257	40	42	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 0	7155	5257
7258	42	39	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 0	7155	5256
7259	32	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 0	7155	5253
7260	85	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 0	7155	5254
7261	93	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 0	7155	5258
7262	70	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 0	7155	5275
7263	99	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 0	7155	5260
7264	97	31	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 0	7155	5261
7265	83	47	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 0	7155	5262
7266	99	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 0	7155	5277
7267	22	46	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 0	7155	5265
7268	96	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 0	7155	5269
7269	87	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 0	7155	5274
7270	66	50	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 0	7155	5276
7271	76	34	Poznámka k aktivitě Žebřík. Osooba: 8 let úroveň 1	7156	5262
7272	42	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 8 let úroveň 1	7156	5253
7273	44	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 8 let úroveň 1	7156	5254
7274	26	49	Poznámka k aktivitě Letmý start. Osooba: 8 let úroveň 1	7156	5256
7275	44	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 8 let úroveň 1	7156	5277
7276	99	32	Poznámka k aktivitě Překážková dráha. Osooba: 8 let úroveň 1	7156	5257
7277	67	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 8 let úroveň 1	7156	5258
7278	28	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 8 let úroveň 1	7156	5260
7279	29	47	Poznámka k aktivitě Lowa brace test. Osooba: 8 let úroveň 1	7156	5261
7280	38	30	Poznámka k aktivitě Skok daleký. Osooba: 8 let úroveň 1	7156	5265
7281	29	45	Poznámka k aktivitě Slalom s míčem. Osooba: 8 let úroveň 1	7156	5276
7282	79	\N	Poznámka k aktivitě slalom. Osooba: 8 let úroveň 1	7156	5269
7283	73	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 8 let úroveň 1	7156	5275
7284	98	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 8 let úroveň 1	7156	5274
7285	20	46	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 0	7157	5254
7286	29	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 0	7157	5253
7287	70	44	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 0	7157	5256
7288	27	31	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 0	7157	5257
7289	75	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 0	7157	5275
7290	89	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 0	7157	5258
7291	56	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 0	7157	5260
7292	61	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 0	7157	5277
7293	70	39	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 0	7157	5261
7294	55	44	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 0	7157	5262
7295	27	43	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 0	7157	5265
7296	56	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 0	7157	5269
7297	35	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 0	7157	5274
7298	20	37	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 0	7157	5276
7299	66	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 9 let úroveň 1	7158	5253
7300	90	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 9 let úroveň 1	7158	5254
7301	72	32	Poznámka k aktivitě Letmý start. Osooba: 9 let úroveň 1	7158	5256
7302	50	44	Poznámka k aktivitě Překážková dráha. Osooba: 9 let úroveň 1	7158	5257
7303	29	42	Poznámka k aktivitě Slalom s míčem. Osooba: 9 let úroveň 1	7158	5276
7304	87	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 9 let úroveň 1	7158	5258
7305	31	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 9 let úroveň 1	7158	5260
7306	88	40	Poznámka k aktivitě Lowa brace test. Osooba: 9 let úroveň 1	7158	5261
7307	87	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 9 let úroveň 1	7158	5275
7308	36	41	Poznámka k aktivitě Žebřík. Osooba: 9 let úroveň 1	7158	5262
7309	21	42	Poznámka k aktivitě Skok daleký. Osooba: 9 let úroveň 1	7158	5265
7310	87	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 9 let úroveň 1	7158	5277
7311	28	\N	Poznámka k aktivitě slalom. Osooba: 9 let úroveň 1	7158	5269
7312	36	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 9 let úroveň 1	7158	5274
7313	92	43	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 0	7159	5262
7314	57	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 0	7159	5253
7315	34	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 0	7159	5254
7316	47	30	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 0	7159	5276
7317	75	35	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 0	7159	5256
7318	39	34	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 0	7159	5257
7319	45	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 0	7159	5275
7320	53	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 0	7159	5258
7321	20	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 0	7159	5277
7322	69	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 0	7159	5260
7323	70	38	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 0	7159	5261
7324	35	30	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 0	7159	5265
7325	62	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 0	7159	5269
7326	98	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 0	7159	5274
7327	78	50	Poznámka k aktivitě Letmý start. Osooba: 10 let úroveň 1	7160	5256
7328	32	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 10 let úroveň 1	7160	5253
7329	89	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 10 let úroveň 1	7160	5254
7330	76	39	Poznámka k aktivitě Překážková dráha. Osooba: 10 let úroveň 1	7160	5257
7331	64	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 10 let úroveň 1	7160	5258
7332	41	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 10 let úroveň 1	7160	5260
7333	40	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 10 let úroveň 1	7160	5277
7334	22	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 10 let úroveň 1	7160	5275
7335	40	34	Poznámka k aktivitě Lowa brace test. Osooba: 10 let úroveň 1	7160	5261
7336	68	44	Poznámka k aktivitě Žebřík. Osooba: 10 let úroveň 1	7160	5262
7337	20	45	Poznámka k aktivitě Skok daleký. Osooba: 10 let úroveň 1	7160	5265
7338	54	\N	Poznámka k aktivitě slalom. Osooba: 10 let úroveň 1	7160	5269
7339	83	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 10 let úroveň 1	7160	5274
7340	75	31	Poznámka k aktivitě Slalom s míčem. Osooba: 10 let úroveň 1	7160	5276
7341	60	34	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 0	7161	5262
7342	29	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 0	7161	5253
7343	61	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 0	7161	5254
7344	57	35	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 0	7161	5256
7345	57	34	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 0	7161	5257
7346	91	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 0	7161	5258
7347	72	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 0	7161	5260
7348	36	50	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 0	7161	5261
7349	97	41	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 0	7161	5276
7350	69	46	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 0	7161	5265
7351	44	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 0	7161	5275
7352	69	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 0	7161	5277
7353	86	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 0	7161	5269
7354	63	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 0	7161	5274
7355	67	38	Poznámka k aktivitě Skok daleký. Osooba: 11 let úroveň 1	7162	5265
7356	55	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 11 let úroveň 1	7162	5253
7357	72	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 11 let úroveň 1	7162	5275
7358	83	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 11 let úroveň 1	7162	5254
7359	27	42	Poznámka k aktivitě Letmý start. Osooba: 11 let úroveň 1	7162	5256
7360	69	45	Poznámka k aktivitě Překážková dráha. Osooba: 11 let úroveň 1	7162	5257
7361	60	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 11 let úroveň 1	7162	5258
7362	93	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 11 let úroveň 1	7162	5260
7363	66	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 11 let úroveň 1	7162	5277
7364	77	41	Poznámka k aktivitě Lowa brace test. Osooba: 11 let úroveň 1	7162	5261
7365	84	49	Poznámka k aktivitě Žebřík. Osooba: 11 let úroveň 1	7162	5262
7366	80	\N	Poznámka k aktivitě slalom. Osooba: 11 let úroveň 1	7162	5269
7367	58	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 11 let úroveň 1	7162	5274
7368	83	42	Poznámka k aktivitě Slalom s míčem. Osooba: 11 let úroveň 1	7162	5276
7369	59	39	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 0	7163	5256
7370	49	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 0	7163	5253
7371	87	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 0	7163	5254
7372	39	50	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 0	7163	5257
7373	33	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 0	7163	5258
7374	41	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 0	7163	5260
7375	98	46	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 0	7163	5276
7376	37	36	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 0	7163	5261
7377	72	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 0	7163	5275
7378	90	31	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 0	7163	5262
7379	94	40	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 0	7163	5265
7380	53	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 0	7163	5269
7381	96	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 0	7163	5277
7382	30	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 0	7163	5274
7383	50	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 12 let úroveň 1	7164	5254
7384	70	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 12 let úroveň 1	7164	5253
7385	94	32	Poznámka k aktivitě Letmý start. Osooba: 12 let úroveň 1	7164	5256
7386	44	35	Poznámka k aktivitě Překážková dráha. Osooba: 12 let úroveň 1	7164	5257
7387	33	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 12 let úroveň 1	7164	5258
7388	96	37	Poznámka k aktivitě Slalom s míčem. Osooba: 12 let úroveň 1	7164	5276
7389	94	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 12 let úroveň 1	7164	5260
7390	54	37	Poznámka k aktivitě Lowa brace test. Osooba: 12 let úroveň 1	7164	5261
7391	87	37	Poznámka k aktivitě Žebřík. Osooba: 12 let úroveň 1	7164	5262
7392	78	46	Poznámka k aktivitě Skok daleký. Osooba: 12 let úroveň 1	7164	5265
7393	54	\N	Poznámka k aktivitě slalom. Osooba: 12 let úroveň 1	7164	5269
7394	42	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 12 let úroveň 1	7164	5275
7395	59	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 12 let úroveň 1	7164	5274
7396	93	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 12 let úroveň 1	7164	5277
7397	30	45	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 0	7165	5261
7398	52	48	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 0	7165	5253
7399	26	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 0	7165	5254
7400	25	33	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 0	7165	5256
7401	71	42	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 0	7165	5257
7402	87	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 0	7165	5258
7403	40	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 0	7165	5260
7404	79	34	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 0	7165	5276
7405	44	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 0	7165	5277
7406	36	31	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 0	7165	5262
7407	80	31	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 0	7165	5265
7408	81	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 0	7165	5275
7409	96	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 0	7165	5269
7410	72	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 0	7165	5274
7411	70	42	Poznámka k aktivitě Lowa brace test. Osooba: 13 let úroveň 1	7166	5261
7412	20	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 13 let úroveň 1	7166	5253
7413	86	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 13 let úroveň 1	7166	5254
7414	42	47	Poznámka k aktivitě Letmý start. Osooba: 13 let úroveň 1	7166	5256
7415	50	31	Poznámka k aktivitě Překážková dráha. Osooba: 13 let úroveň 1	7166	5257
7416	95	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 13 let úroveň 1	7166	5277
7417	56	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 13 let úroveň 1	7166	5258
7418	73	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 13 let úroveň 1	7166	5260
7419	78	43	Poznámka k aktivitě Žebřík. Osooba: 13 let úroveň 1	7166	5262
7420	42	41	Poznámka k aktivitě Skok daleký. Osooba: 13 let úroveň 1	7166	5265
7421	79	40	Poznámka k aktivitě Slalom s míčem. Osooba: 13 let úroveň 1	7166	5276
7422	30	\N	Poznámka k aktivitě slalom. Osooba: 13 let úroveň 1	7166	5269
7423	81	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 13 let úroveň 1	7166	5275
7424	95	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 13 let úroveň 1	7166	5274
7425	65	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 0	7167	5254
7426	89	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 0	7167	5253
7427	45	46	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 0	7167	5256
7428	71	30	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 0	7167	5257
7429	87	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 0	7167	5258
7430	50	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 0	7167	5260
7431	72	39	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 0	7167	5261
7432	87	38	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 0	7167	5262
7433	71	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 0	7167	5277
7434	63	37	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 0	7167	5265
7435	20	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 0	7167	5275
7436	42	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 0	7167	5269
7437	22	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 0	7167	5274
7438	46	32	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 0	7167	5276
7439	59	46	Poznámka k aktivitě Letmý start. Osooba: 14 let úroveň 1	7168	5256
7440	79	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 14 let úroveň 1	7168	5253
7441	26	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 14 let úroveň 1	7168	5254
7442	55	47	Poznámka k aktivitě Překážková dráha. Osooba: 14 let úroveň 1	7168	5257
7443	26	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 14 let úroveň 1	7168	5258
7444	23	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 14 let úroveň 1	7168	5260
7445	84	39	Poznámka k aktivitě Lowa brace test. Osooba: 14 let úroveň 1	7168	5261
7446	73	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 14 let úroveň 1	7168	5275
7447	46	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 14 let úroveň 1	7168	5277
7448	99	33	Poznámka k aktivitě Slalom s míčem. Osooba: 14 let úroveň 1	7168	5276
7449	83	36	Poznámka k aktivitě Žebřík. Osooba: 14 let úroveň 1	7168	5262
7450	91	42	Poznámka k aktivitě Skok daleký. Osooba: 14 let úroveň 1	7168	5265
7451	44	\N	Poznámka k aktivitě slalom. Osooba: 14 let úroveň 1	7168	5269
7452	33	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 14 let úroveň 1	7168	5274
7453	68	42	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 0	7169	5256
7454	26	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 0	7169	5253
7455	61	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 0	7169	5254
7456	42	44	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 0	7169	5257
7457	40	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 0	7169	5258
7458	93	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 0	7169	5260
7459	23	47	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 0	7169	5276
7460	60	42	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 0	7169	5261
7461	68	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 0	7169	5275
7462	25	39	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 0	7169	5262
7463	90	40	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 0	7169	5265
7464	75	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 0	7169	5269
7465	80	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 0	7169	5277
7466	99	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 0	7169	5274
7467	69	46	Poznámka k aktivitě Lowa brace test. Osooba: 15 let úroveň 1	7170	5261
7468	87	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 15 let úroveň 1	7170	5254
7469	30	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 15 let úroveň 1	7170	5253
7470	96	42	Poznámka k aktivitě Letmý start. Osooba: 15 let úroveň 1	7170	5256
7471	61	34	Poznámka k aktivitě Překážková dráha. Osooba: 15 let úroveň 1	7170	5257
7472	56	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 15 let úroveň 1	7170	5275
7473	36	38	Poznámka k aktivitě Slalom s míčem. Osooba: 15 let úroveň 1	7170	5276
7474	88	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 15 let úroveň 1	7170	5258
7475	47	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 15 let úroveň 1	7170	5260
7476	80	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 15 let úroveň 1	7170	5277
7477	77	49	Poznámka k aktivitě Žebřík. Osooba: 15 let úroveň 1	7170	5262
7478	74	31	Poznámka k aktivitě Skok daleký. Osooba: 15 let úroveň 1	7170	5265
7479	89	\N	Poznámka k aktivitě slalom. Osooba: 15 let úroveň 1	7170	5269
7480	91	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 15 let úroveň 1	7170	5274
7481	77	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 0	7171	5253
7482	86	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 0	7171	5254
7483	64	36	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 0	7171	5256
7484	67	42	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 0	7171	5257
7485	81	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 0	7171	5275
7486	95	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 0	7171	5258
7487	56	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 0	7171	5260
7488	94	31	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 0	7171	5261
7489	75	43	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 0	7171	5262
7490	71	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 0	7171	5277
7491	46	31	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 0	7171	5265
7492	34	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 0	7171	5269
7493	54	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 0	7171	5274
7494	71	43	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 0	7171	5276
7495	95	33	Poznámka k aktivitě Lowa brace test. Osooba: 16 let úroveň 1	7172	5261
7496	28	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 16 let úroveň 1	7172	5253
7497	51	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 16 let úroveň 1	7172	5275
7498	75	42	Poznámka k aktivitě Slalom s míčem. Osooba: 16 let úroveň 1	7172	5276
7499	86	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 16 let úroveň 1	7172	5254
7500	83	42	Poznámka k aktivitě Letmý start. Osooba: 16 let úroveň 1	7172	5256
7501	48	42	Poznámka k aktivitě Překážková dráha. Osooba: 16 let úroveň 1	7172	5257
7502	34	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 16 let úroveň 1	7172	5258
7503	51	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 16 let úroveň 1	7172	5260
7504	79	48	Poznámka k aktivitě Žebřík. Osooba: 16 let úroveň 1	7172	5262
7505	74	37	Poznámka k aktivitě Skok daleký. Osooba: 16 let úroveň 1	7172	5265
7506	74	\N	Poznámka k aktivitě slalom. Osooba: 16 let úroveň 1	7172	5269
7507	48	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 16 let úroveň 1	7172	5277
7508	62	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 16 let úroveň 1	7172	5274
7509	50	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 0	7173	5254
7510	45	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 0	7173	5253
7511	49	39	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 0	7173	5256
7512	59	38	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 0	7173	5257
7513	24	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 0	7173	5258
7514	59	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 0	7173	5275
7515	63	45	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 0	7173	5276
7516	67	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 0	7173	5260
7517	22	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 0	7173	5277
7518	45	47	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 0	7173	5261
7519	43	36	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 0	7173	5262
7520	47	32	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 0	7173	5265
7521	84	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 0	7173	5269
7522	60	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 0	7173	5274
7523	23	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 17 let úroveň 1	7174	5253
7524	23	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 17 let úroveň 1	7174	5254
7525	22	44	Poznámka k aktivitě Letmý start. Osooba: 17 let úroveň 1	7174	5256
7526	20	37	Poznámka k aktivitě Překážková dráha. Osooba: 17 let úroveň 1	7174	5257
7527	93	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 17 let úroveň 1	7174	5258
7528	51	30	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 17 let úroveň 1	7174	5260
7529	82	42	Poznámka k aktivitě Lowa brace test. Osooba: 17 let úroveň 1	7174	5261
7530	93	32	Poznámka k aktivitě Žebřík. Osooba: 17 let úroveň 1	7174	5262
7531	29	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 17 let úroveň 1	7174	5277
7532	70	46	Poznámka k aktivitě Skok daleký. Osooba: 17 let úroveň 1	7174	5265
7533	41	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 17 let úroveň 1	7174	5275
7534	81	47	Poznámka k aktivitě Slalom s míčem. Osooba: 17 let úroveň 1	7174	5276
7535	85	\N	Poznámka k aktivitě slalom. Osooba: 17 let úroveň 1	7174	5269
7536	65	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 17 let úroveň 1	7174	5274
7537	62	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 0	7175	5253
7538	27	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 0	7175	5254
7539	64	32	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 0	7175	5256
7540	84	50	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 0	7175	5257
7541	73	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 0	7175	5258
7542	86	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 0	7175	5260
7543	90	37	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 0	7175	5261
7544	65	30	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 0	7175	5262
7545	82	47	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 0	7175	5265
7546	23	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 0	7175	5277
7547	68	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 0	7175	5269
7548	87	43	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 0	7175	5274
7549	75	45	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 0	7175	5276
7550	59	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 0	7175	5275
7551	77	38	Poznámka k aktivitě Lowa brace test. Osooba: 18 let úroveň 1	7176	5261
7552	20	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 18 let úroveň 1	7176	5253
7553	52	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 18 let úroveň 1	7176	5254
7554	42	39	Poznámka k aktivitě Letmý start. Osooba: 18 let úroveň 1	7176	5256
7555	21	33	Poznámka k aktivitě Překážková dráha. Osooba: 18 let úroveň 1	7176	5257
7556	49	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 18 let úroveň 1	7176	5277
7557	56	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 18 let úroveň 1	7176	5258
7558	37	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 18 let úroveň 1	7176	5260
7559	27	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 18 let úroveň 1	7176	5275
7560	25	47	Poznámka k aktivitě Žebřík. Osooba: 18 let úroveň 1	7176	5262
7561	23	32	Poznámka k aktivitě Skok daleký. Osooba: 18 let úroveň 1	7176	5265
7562	59	\N	Poznámka k aktivitě slalom. Osooba: 18 let úroveň 1	7176	5269
7563	27	49	Poznámka k aktivitě Slalom s míčem. Osooba: 18 let úroveň 1	7176	5276
7564	62	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 18 let úroveň 1	7176	5274
7565	100	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 0	7177	5258
7566	93	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 0	7177	5253
7567	38	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 0	7177	5254
7568	97	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 0	7177	5275
7569	32	50	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 0	7177	5256
7570	44	39	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 0	7177	5257
7571	93	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 0	7177	5260
7572	49	49	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 0	7177	5261
7573	46	42	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 0	7177	5276
7574	54	31	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 0	7177	5262
7575	67	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 0	7177	5277
7576	31	32	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 0	7177	5265
7577	35	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 0	7177	5269
7578	74	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 0	7177	5274
7579	20	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 19 let úroveň 1	7178	5260
7580	98	34	Poznámka k aktivitě Letmý start. Osooba: 19 let úroveň 1	7178	5256
7581	55	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 19 let úroveň 1	7178	5253
7582	21	50	Poznámka k aktivitě Skok na jednu nohu. Osooba: 19 let úroveň 1	7178	5254
7583	73	30	Poznámka k aktivitě Překážková dráha. Osooba: 19 let úroveň 1	7178	5257
7584	21	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 19 let úroveň 1	7178	5258
7585	59	33	Poznámka k aktivitě Lowa brace test. Osooba: 19 let úroveň 1	7178	5261
7586	83	50	Poznámka k aktivitě Slalom s míčem. Osooba: 19 let úroveň 1	7178	5276
7587	55	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 19 let úroveň 1	7178	5275
7588	34	32	Poznámka k aktivitě Žebřík. Osooba: 19 let úroveň 1	7178	5262
7589	85	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 19 let úroveň 1	7178	5277
7590	30	44	Poznámka k aktivitě Skok daleký. Osooba: 19 let úroveň 1	7178	5265
7591	55	\N	Poznámka k aktivitě slalom. Osooba: 19 let úroveň 1	7178	5269
7592	75	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 19 let úroveň 1	7178	5274
7593	89	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 0	7179	5254
7594	26	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 0	7179	5253
7595	35	40	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 0	7179	5256
7596	47	39	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 0	7179	5257
7597	94	35	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 0	7179	5258
7598	49	50	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 0	7179	5276
7599	50	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 0	7179	5260
7600	39	34	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 0	7179	5261
7601	41	40	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 0	7179	5262
7602	37	39	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 0	7179	5265
7603	84	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 0	7179	5275
7604	41	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 0	7179	5277
7605	96	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 0	7179	5269
7606	83	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 0	7179	5274
7607	81	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 20 let úroveň 1	7180	5253
7608	84	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 20 let úroveň 1	7180	5254
7609	81	35	Poznámka k aktivitě Slalom s míčem. Osooba: 20 let úroveň 1	7180	5276
7610	30	39	Poznámka k aktivitě Letmý start. Osooba: 20 let úroveň 1	7180	5256
7611	90	40	Poznámka k aktivitě Překážková dráha. Osooba: 20 let úroveň 1	7180	5257
7612	50	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 20 let úroveň 1	7180	5258
7613	72	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 20 let úroveň 1	7180	5277
7614	78	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 20 let úroveň 1	7180	5260
7615	87	45	Poznámka k aktivitě Lowa brace test. Osooba: 20 let úroveň 1	7180	5261
7616	22	36	Poznámka k aktivitě Žebřík. Osooba: 20 let úroveň 1	7180	5262
7617	100	45	Poznámka k aktivitě Skok daleký. Osooba: 20 let úroveň 1	7180	5265
7618	63	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 20 let úroveň 1	7180	5275
7619	71	\N	Poznámka k aktivitě slalom. Osooba: 20 let úroveň 1	7180	5269
7620	26	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 20 let úroveň 1	7180	5274
7621	53	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 0	7181	5254
7622	74	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 0	7181	5253
7623	68	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 0	7181	5277
7624	67	38	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 0	7181	5256
7625	32	39	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 0	7181	5257
7626	42	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 0	7181	5258
7627	50	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 0	7181	5260
7628	49	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 0	7181	5275
7629	69	33	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 0	7181	5261
7630	81	43	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 0	7181	5262
7631	23	39	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 0	7181	5276
7632	53	48	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 0	7181	5265
7633	67	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 0	7181	5269
7634	77	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 0	7181	5274
7635	41	34	Poznámka k aktivitě Letmý start. Osooba: 21 let úroveň 1	7182	5256
7636	73	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 21 let úroveň 1	7182	5253
7637	75	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 21 let úroveň 1	7182	5275
7638	83	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 21 let úroveň 1	7182	5277
7639	60	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 21 let úroveň 1	7182	5254
7640	72	33	Poznámka k aktivitě Překážková dráha. Osooba: 21 let úroveň 1	7182	5257
7641	58	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 21 let úroveň 1	7182	5258
7642	37	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 21 let úroveň 1	7182	5260
7643	48	43	Poznámka k aktivitě Lowa brace test. Osooba: 21 let úroveň 1	7182	5261
7644	46	32	Poznámka k aktivitě Slalom s míčem. Osooba: 21 let úroveň 1	7182	5276
7645	38	32	Poznámka k aktivitě Žebřík. Osooba: 21 let úroveň 1	7182	5262
7646	80	50	Poznámka k aktivitě Skok daleký. Osooba: 21 let úroveň 1	7182	5265
7647	43	\N	Poznámka k aktivitě slalom. Osooba: 21 let úroveň 1	7182	5269
7648	57	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 21 let úroveň 1	7182	5274
7649	35	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 0	7183	5260
7650	40	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 0	7183	5253
7651	92	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 0	7183	5254
7652	61	34	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 0	7183	5256
7653	39	32	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 0	7183	5257
7654	51	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 0	7183	5277
7655	68	30	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 0	7183	5258
7656	44	33	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 0	7183	5261
7657	100	39	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 0	7183	5262
7658	91	48	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 0	7183	5265
7659	85	44	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 0	7183	5276
7660	91	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 0	7183	5269
7661	74	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 0	7183	5275
7662	73	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 0	7183	5274
7663	42	48	Poznámka k aktivitě Skok daleký. Osooba: 22 let úroveň 1	7184	5265
7664	24	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 22 let úroveň 1	7184	5253
7665	41	35	Poznámka k aktivitě Slalom s míčem. Osooba: 22 let úroveň 1	7184	5276
7666	79	35	Poznámka k aktivitě Výdrž ve sporu. Osooba: 22 let úroveň 1	7184	5275
7667	20	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 22 let úroveň 1	7184	5254
7668	62	45	Poznámka k aktivitě Letmý start. Osooba: 22 let úroveň 1	7184	5256
7669	97	33	Poznámka k aktivitě Překážková dráha. Osooba: 22 let úroveň 1	7184	5257
7670	22	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 22 let úroveň 1	7184	5258
7671	25	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 22 let úroveň 1	7184	5260
7672	56	38	Poznámka k aktivitě Lowa brace test. Osooba: 22 let úroveň 1	7184	5261
7673	76	46	Poznámka k aktivitě Žebřík. Osooba: 22 let úroveň 1	7184	5262
7674	37	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 22 let úroveň 1	7184	5277
7675	79	\N	Poznámka k aktivitě slalom. Osooba: 22 let úroveň 1	7184	5269
7676	59	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 22 let úroveň 1	7184	5274
7677	51	31	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 0	7185	5256
7678	39	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 0	7185	5253
7679	47	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 0	7185	5277
7680	49	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 0	7185	5254
7681	100	47	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 0	7185	5257
7682	29	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 0	7185	5258
7683	53	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 0	7185	5260
7684	29	45	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 0	7185	5261
7685	63	42	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 0	7185	5262
7686	89	31	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 0	7185	5265
7687	88	48	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 0	7185	5276
7688	47	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 0	7185	5269
7689	59	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 0	7185	5274
7690	36	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 0	7185	5275
7691	42	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 23 let úroveň 1	7186	5260
7692	40	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 23 let úroveň 1	7186	5253
7693	28	41	Poznámka k aktivitě Slalom s míčem. Osooba: 23 let úroveň 1	7186	5276
7694	78	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 23 let úroveň 1	7186	5254
7695	44	35	Poznámka k aktivitě Letmý start. Osooba: 23 let úroveň 1	7186	5256
7696	73	32	Poznámka k aktivitě Překážková dráha. Osooba: 23 let úroveň 1	7186	5257
7697	52	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 23 let úroveň 1	7186	5258
7698	24	43	Poznámka k aktivitě Lowa brace test. Osooba: 23 let úroveň 1	7186	5261
7699	28	49	Poznámka k aktivitě Žebřík. Osooba: 23 let úroveň 1	7186	5262
7700	60	45	Poznámka k aktivitě Skok daleký. Osooba: 23 let úroveň 1	7186	5265
7701	50	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 23 let úroveň 1	7186	5275
7702	30	\N	Poznámka k aktivitě slalom. Osooba: 23 let úroveň 1	7186	5269
7703	74	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 23 let úroveň 1	7186	5274
7704	63	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 23 let úroveň 1	7186	5277
7705	81	50	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 0	7187	5257
7706	55	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 0	7187	5253
7707	63	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 0	7187	5254
7708	93	45	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 0	7187	5256
7709	69	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 0	7187	5258
7710	93	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 0	7187	5260
7711	21	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 0	7187	5277
7712	31	49	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 0	7187	5261
7713	32	41	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 0	7187	5262
7714	43	45	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 0	7187	5276
7715	38	48	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 0	7187	5265
7716	82	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 0	7187	5269
7717	83	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 0	7187	5274
7718	81	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 0	7187	5275
7719	97	46	Poznámka k aktivitě Letmý start. Osooba: 24 let úroveň 1	7188	5256
7720	39	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 24 let úroveň 1	7188	5253
7721	39	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 24 let úroveň 1	7188	5254
7722	38	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 24 let úroveň 1	7188	5277
7723	29	31	Poznámka k aktivitě Překážková dráha. Osooba: 24 let úroveň 1	7188	5257
7724	24	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 24 let úroveň 1	7188	5258
7725	26	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 24 let úroveň 1	7188	5260
7726	47	36	Poznámka k aktivitě Lowa brace test. Osooba: 24 let úroveň 1	7188	5261
7727	100	36	Poznámka k aktivitě Žebřík. Osooba: 24 let úroveň 1	7188	5262
7728	96	43	Poznámka k aktivitě Slalom s míčem. Osooba: 24 let úroveň 1	7188	5276
7729	92	49	Poznámka k aktivitě Skok daleký. Osooba: 24 let úroveň 1	7188	5265
7730	64	\N	Poznámka k aktivitě slalom. Osooba: 24 let úroveň 1	7188	5269
7731	70	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 24 let úroveň 1	7188	5275
7732	66	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 24 let úroveň 1	7188	5274
7733	72	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 0	7189	5258
7734	93	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 0	7189	5253
7735	57	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 0	7189	5254
7736	98	50	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 0	7189	5256
7737	47	37	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 0	7189	5257
7738	43	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 0	7189	5260
7739	63	41	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 0	7189	5261
7740	42	48	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 0	7189	5262
7741	81	36	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 0	7189	5276
7742	48	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 0	7189	5277
7743	92	46	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 0	7189	5265
7744	88	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 0	7189	5269
7745	42	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 0	7189	5274
7746	53	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 0	7189	5275
7747	26	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 25 let úroveň 1	7190	5254
7748	79	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 25 let úroveň 1	7190	5253
7749	23	36	Poznámka k aktivitě Letmý start. Osooba: 25 let úroveň 1	7190	5256
7750	76	32	Poznámka k aktivitě Překážková dráha. Osooba: 25 let úroveň 1	7190	5257
7751	61	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 25 let úroveň 1	7190	5258
7752	37	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 25 let úroveň 1	7190	5260
7753	48	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 25 let úroveň 1	7190	5275
7754	62	41	Poznámka k aktivitě Lowa brace test. Osooba: 25 let úroveň 1	7190	5261
7755	90	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 25 let úroveň 1	7190	5277
7756	82	50	Poznámka k aktivitě Žebřík. Osooba: 25 let úroveň 1	7190	5262
7757	83	34	Poznámka k aktivitě Slalom s míčem. Osooba: 25 let úroveň 1	7190	5276
7758	46	49	Poznámka k aktivitě Skok daleký. Osooba: 25 let úroveň 1	7190	5265
7759	25	\N	Poznámka k aktivitě slalom. Osooba: 25 let úroveň 1	7190	5269
7760	22	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 25 let úroveň 1	7190	5274
7761	24	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 0	7191	5260
7762	63	45	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 0	7191	5256
7763	31	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 0	7191	5253
7764	88	43	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 0	7191	5254
7765	65	34	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 0	7191	5257
7766	81	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 0	7191	5258
7767	42	32	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 0	7191	5261
7768	66	32	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 0	7191	5262
7769	43	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 0	7191	5275
7770	63	39	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 0	7191	5265
7771	29	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 0	7191	5277
7772	43	36	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 0	7191	5276
7773	67	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 0	7191	5269
7774	44	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 0	7191	5274
7775	36	49	Poznámka k aktivitě Lowa brace test. Osooba: 26 let úroveň 1	7192	5261
7776	65	50	Poznámka k aktivitě Stoj na jedné noze. Osooba: 26 let úroveň 1	7192	5253
7777	55	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 26 let úroveň 1	7192	5254
7778	64	42	Poznámka k aktivitě Letmý start. Osooba: 26 let úroveň 1	7192	5256
7779	77	36	Poznámka k aktivitě Slalom s míčem. Osooba: 26 let úroveň 1	7192	5276
7780	80	37	Poznámka k aktivitě Překážková dráha. Osooba: 26 let úroveň 1	7192	5257
7781	75	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 26 let úroveň 1	7192	5277
7782	54	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 26 let úroveň 1	7192	5258
7783	93	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 26 let úroveň 1	7192	5260
7784	78	33	Poznámka k aktivitě Žebřík. Osooba: 26 let úroveň 1	7192	5262
7785	99	31	Poznámka k aktivitě Skok daleký. Osooba: 26 let úroveň 1	7192	5265
7786	49	\N	Poznámka k aktivitě slalom. Osooba: 26 let úroveň 1	7192	5269
7787	48	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 26 let úroveň 1	7192	5274
7788	64	39	Poznámka k aktivitě Výdrž ve sporu. Osooba: 26 let úroveň 1	7192	5275
7789	94	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 0	7193	5254
7790	54	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 0	7193	5253
7791	72	49	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 0	7193	5256
7792	70	32	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 0	7193	5257
7793	48	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 0	7193	5258
7794	50	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 0	7193	5275
7795	81	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 0	7193	5260
7796	68	50	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 0	7193	5261
7797	31	36	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 0	7193	5262
7798	79	33	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 0	7193	5276
7799	87	30	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 0	7193	5265
7800	36	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 0	7193	5269
7801	83	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 0	7193	5277
7802	69	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 0	7193	5274
7803	77	41	Poznámka k aktivitě Letmý start. Osooba: 27 let úroveň 1	7194	5256
7804	27	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 27 let úroveň 1	7194	5253
7805	100	35	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 27 let úroveň 1	7194	5277
7806	99	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 27 let úroveň 1	7194	5254
7807	79	45	Poznámka k aktivitě Překážková dráha. Osooba: 27 let úroveň 1	7194	5257
7808	69	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 27 let úroveň 1	7194	5258
7809	88	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 27 let úroveň 1	7194	5260
7810	78	49	Poznámka k aktivitě Lowa brace test. Osooba: 27 let úroveň 1	7194	5261
7811	93	40	Poznámka k aktivitě Žebřík. Osooba: 27 let úroveň 1	7194	5262
7812	21	41	Poznámka k aktivitě Skok daleký. Osooba: 27 let úroveň 1	7194	5265
7813	30	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 27 let úroveň 1	7194	5275
7814	79	50	Poznámka k aktivitě Slalom s míčem. Osooba: 27 let úroveň 1	7194	5276
7815	27	\N	Poznámka k aktivitě slalom. Osooba: 27 let úroveň 1	7194	5269
7816	64	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 27 let úroveň 1	7194	5274
7817	91	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 0	7195	5254
7818	63	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 0	7195	5253
7819	51	35	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 0	7195	5256
7820	48	49	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 0	7195	5257
7821	61	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 0	7195	5258
7822	26	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 0	7195	5260
7823	22	48	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 0	7195	5261
7824	51	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 0	7195	5275
7825	39	48	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 0	7195	5277
7826	91	49	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 0	7195	5262
7827	61	36	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 0	7195	5265
7828	89	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 0	7195	5269
7829	71	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 0	7195	5274
7830	24	31	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 0	7195	5276
7831	61	44	Poznámka k aktivitě Překážková dráha. Osooba: 28 let úroveň 1	7196	5257
7832	35	48	Poznámka k aktivitě Letmý start. Osooba: 28 let úroveň 1	7196	5256
7833	49	31	Poznámka k aktivitě Stoj na jedné noze. Osooba: 28 let úroveň 1	7196	5253
7834	95	31	Poznámka k aktivitě Slalom s míčem. Osooba: 28 let úroveň 1	7196	5276
7835	36	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 28 let úroveň 1	7196	5277
7836	81	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 28 let úroveň 1	7196	5254
7837	68	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 28 let úroveň 1	7196	5258
7838	98	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 28 let úroveň 1	7196	5260
7839	71	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 28 let úroveň 1	7196	5275
7840	20	36	Poznámka k aktivitě Lowa brace test. Osooba: 28 let úroveň 1	7196	5261
7841	35	47	Poznámka k aktivitě Žebřík. Osooba: 28 let úroveň 1	7196	5262
7842	26	48	Poznámka k aktivitě Skok daleký. Osooba: 28 let úroveň 1	7196	5265
7843	95	\N	Poznámka k aktivitě slalom. Osooba: 28 let úroveň 1	7196	5269
7844	47	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 28 let úroveň 1	7196	5274
7845	85	45	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 0	7197	5253
7846	56	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 0	7197	5254
7847	67	36	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 0	7197	5256
7848	37	36	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 0	7197	5257
7849	20	47	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 0	7197	5258
7850	68	37	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 0	7197	5260
7851	80	42	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 0	7197	5261
7852	96	30	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 0	7197	5262
7853	90	36	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 0	7197	5265
7854	84	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 0	7197	5275
7855	57	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 0	7197	5277
7856	78	49	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 0	7197	5276
7857	84	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 0	7197	5269
7858	24	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 0	7197	5274
7859	67	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 29 let úroveň 1	7198	5253
7860	60	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 29 let úroveň 1	7198	5254
7861	50	48	Poznámka k aktivitě Letmý start. Osooba: 29 let úroveň 1	7198	5256
7862	34	37	Poznámka k aktivitě Překážková dráha. Osooba: 29 let úroveň 1	7198	5257
7863	37	36	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 29 let úroveň 1	7198	5258
7864	25	34	Poznámka k aktivitě Slalom s míčem. Osooba: 29 let úroveň 1	7198	5276
7865	80	45	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 29 let úroveň 1	7198	5260
7866	32	38	Poznámka k aktivitě Lowa brace test. Osooba: 29 let úroveň 1	7198	5261
7867	84	42	Poznámka k aktivitě Žebřík. Osooba: 29 let úroveň 1	7198	5262
7868	49	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 29 let úroveň 1	7198	5275
7869	94	30	Poznámka k aktivitě Skok daleký. Osooba: 29 let úroveň 1	7198	5265
7870	27	\N	Poznámka k aktivitě slalom. Osooba: 29 let úroveň 1	7198	5269
7871	100	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 29 let úroveň 1	7198	5274
7872	22	46	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 29 let úroveň 1	7198	5277
7873	78	41	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 0	7199	5254
7874	72	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 0	7199	5253
7875	93	46	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 0	7199	5256
7876	32	37	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 0	7199	5277
7877	66	48	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 0	7199	5257
7878	46	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 0	7199	5258
7879	52	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 0	7199	5260
7880	48	35	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 0	7199	5261
7881	55	32	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 0	7199	5262
7882	99	46	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 0	7199	5276
7883	84	39	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 0	7199	5265
7884	47	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 0	7199	5275
7885	67	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 0	7199	5269
7886	96	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 0	7199	5274
7887	94	30	Poznámka k aktivitě Skok daleký. Osooba: 30 let úroveň 1	7200	5265
7888	27	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 30 let úroveň 1	7200	5253
7889	25	48	Poznámka k aktivitě Skok na jednu nohu. Osooba: 30 let úroveň 1	7200	5254
7890	52	47	Poznámka k aktivitě Letmý start. Osooba: 30 let úroveň 1	7200	5256
7891	68	33	Poznámka k aktivitě Překážková dráha. Osooba: 30 let úroveň 1	7200	5257
7892	27	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 30 let úroveň 1	7200	5258
7893	23	47	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 30 let úroveň 1	7200	5260
7894	37	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 30 let úroveň 1	7200	5275
7895	28	37	Poznámka k aktivitě Lowa brace test. Osooba: 30 let úroveň 1	7200	5261
7896	45	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 30 let úroveň 1	7200	5277
7897	62	44	Poznámka k aktivitě Žebřík. Osooba: 30 let úroveň 1	7200	5262
7898	41	\N	Poznámka k aktivitě slalom. Osooba: 30 let úroveň 1	7200	5269
7899	21	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 30 let úroveň 1	7200	5274
7900	30	35	Poznámka k aktivitě Slalom s míčem. Osooba: 30 let úroveň 1	7200	5276
8001	100	31	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 0	7951	5256
8002	26	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 0	7951	5253
8003	97	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 0	7951	5254
8004	53	41	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 0	7951	5257
8005	100	43	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 0	7951	5258
8006	28	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 0	7951	5275
8007	85	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 0	7951	5277
8008	21	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 0	7951	5260
8009	94	39	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 0	7951	5276
8010	51	35	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 0	7951	5261
8011	91	42	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 0	7951	5262
8012	57	48	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 0	7951	5265
8013	77	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 0	7951	5269
8014	47	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 0	7951	5274
8015	93	38	Poznámka k aktivitě Překážková dráha. Osooba: 31 let úroveň 1	7952	5257
8016	79	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 31 let úroveň 1	7952	5253
8017	25	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 31 let úroveň 1	7952	5254
8018	98	39	Poznámka k aktivitě Letmý start. Osooba: 31 let úroveň 1	7952	5256
8019	87	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 31 let úroveň 1	7952	5258
8020	94	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 31 let úroveň 1	7952	5260
8021	39	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 31 let úroveň 1	7952	5275
8022	86	42	Poznámka k aktivitě Lowa brace test. Osooba: 31 let úroveň 1	7952	5261
8023	24	41	Poznámka k aktivitě Žebřík. Osooba: 31 let úroveň 1	7952	5262
8024	60	38	Poznámka k aktivitě Skok daleký. Osooba: 31 let úroveň 1	7952	5265
8025	94	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 31 let úroveň 1	7952	5277
8026	92	\N	Poznámka k aktivitě slalom. Osooba: 31 let úroveň 1	7952	5269
8027	87	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 31 let úroveň 1	7952	5274
8028	93	30	Poznámka k aktivitě Slalom s míčem. Osooba: 31 let úroveň 1	7952	5276
8029	60	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 0	7953	5254
8030	32	34	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 0	7953	5253
8031	31	37	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 0	7953	5256
8032	51	43	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 0	7953	5257
8033	21	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 0	7953	5258
8034	47	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 0	7953	5260
8035	39	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 0	7953	5275
8036	95	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 0	7953	5277
8037	42	35	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 0	7953	5261
8038	92	49	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 0	7953	5262
8039	91	34	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 0	7953	5265
8040	29	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 0	7953	5269
8041	59	49	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 0	7953	5276
8042	86	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 0	7953	5274
8043	58	\N	Poznámka k aktivitě slalom. Osooba: 32 let úroveň 1	7954	5269
8044	25	41	Poznámka k aktivitě Stoj na jedné noze. Osooba: 32 let úroveň 1	7954	5253
8045	30	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 32 let úroveň 1	7954	5254
8046	85	40	Poznámka k aktivitě Letmý start. Osooba: 32 let úroveň 1	7954	5256
8047	54	36	Poznámka k aktivitě Překážková dráha. Osooba: 32 let úroveň 1	7954	5257
8048	46	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 32 let úroveň 1	7954	5258
8049	32	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 32 let úroveň 1	7954	5260
8050	23	36	Poznámka k aktivitě Lowa brace test. Osooba: 32 let úroveň 1	7954	5261
8051	48	50	Poznámka k aktivitě Žebřík. Osooba: 32 let úroveň 1	7954	5262
8052	43	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 32 let úroveň 1	7954	5275
8053	26	46	Poznámka k aktivitě Slalom s míčem. Osooba: 32 let úroveň 1	7954	5276
8054	55	40	Poznámka k aktivitě Skok daleký. Osooba: 32 let úroveň 1	7954	5265
8055	92	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 32 let úroveň 1	7954	5277
8056	56	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 32 let úroveň 1	7954	5274
8057	63	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 0	7955	5253
8058	42	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 0	7955	5254
8059	24	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 0	7955	5275
8060	99	44	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 0	7955	5256
8061	22	38	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 0	7955	5257
8062	87	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 0	7955	5258
8063	94	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 0	7955	5260
8064	34	33	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 0	7955	5261
8065	51	50	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 0	7955	5262
8066	57	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 0	7955	5277
8067	25	45	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 0	7955	5276
8068	34	33	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 0	7955	5265
8069	69	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 0	7955	5269
8070	55	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 0	7955	5274
8071	69	35	Poznámka k aktivitě Letmý start. Osooba: 33 let úroveň 1	7956	5256
8072	78	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 33 let úroveň 1	7956	5253
8073	72	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 33 let úroveň 1	7956	5254
8074	50	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 33 let úroveň 1	7956	5277
8075	71	33	Poznámka k aktivitě Překážková dráha. Osooba: 33 let úroveň 1	7956	5257
8076	81	38	Poznámka k aktivitě Slalom s míčem. Osooba: 33 let úroveň 1	7956	5276
8077	49	46	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 33 let úroveň 1	7956	5258
8078	58	46	Poznámka k aktivitě Výdrž ve sporu. Osooba: 33 let úroveň 1	7956	5275
8079	48	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 33 let úroveň 1	7956	5260
8080	82	31	Poznámka k aktivitě Lowa brace test. Osooba: 33 let úroveň 1	7956	5261
8081	63	49	Poznámka k aktivitě Žebřík. Osooba: 33 let úroveň 1	7956	5262
8082	85	35	Poznámka k aktivitě Skok daleký. Osooba: 33 let úroveň 1	7956	5265
8083	22	\N	Poznámka k aktivitě slalom. Osooba: 33 let úroveň 1	7956	5269
8084	80	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 33 let úroveň 1	7956	5274
8085	21	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 0	7957	5253
8086	40	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 0	7957	5254
8087	24	41	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 0	7957	5256
8088	68	41	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 0	7957	5257
8089	87	37	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 0	7957	5258
8090	89	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 0	7957	5260
8091	50	31	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 0	7957	5261
8092	26	46	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 0	7957	5262
8093	35	48	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 0	7957	5265
8094	77	45	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 0	7957	5276
8095	72	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 0	7957	5269
8096	42	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 0	7957	5275
8097	55	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 0	7957	5277
8098	69	39	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 0	7957	5274
8099	49	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 34 let úroveň 1	7958	5254
8100	46	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 34 let úroveň 1	7958	5253
8101	59	41	Poznámka k aktivitě Letmý start. Osooba: 34 let úroveň 1	7958	5256
8102	80	31	Poznámka k aktivitě Překážková dráha. Osooba: 34 let úroveň 1	7958	5257
8103	41	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 34 let úroveň 1	7958	5258
8104	33	48	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 34 let úroveň 1	7958	5260
8105	81	45	Poznámka k aktivitě Lowa brace test. Osooba: 34 let úroveň 1	7958	5261
8106	80	41	Poznámka k aktivitě Žebřík. Osooba: 34 let úroveň 1	7958	5262
8107	39	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 34 let úroveň 1	7958	5277
8108	77	48	Poznámka k aktivitě Skok daleký. Osooba: 34 let úroveň 1	7958	5265
8109	22	48	Poznámka k aktivitě Slalom s míčem. Osooba: 34 let úroveň 1	7958	5276
8110	73	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 34 let úroveň 1	7958	5275
8111	99	\N	Poznámka k aktivitě slalom. Osooba: 34 let úroveň 1	7958	5269
8112	53	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 34 let úroveň 1	7958	5274
8113	97	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 0	7959	5258
8114	20	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 0	7959	5253
8115	73	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 0	7959	5254
8116	87	45	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 0	7959	5256
8117	45	31	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 0	7959	5257
8118	96	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 0	7959	5277
8119	37	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 0	7959	5260
8120	49	46	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 0	7959	5261
8121	27	40	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 0	7959	5262
8122	83	42	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 0	7959	5265
8123	44	35	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 0	7959	5276
8124	75	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 0	7959	5269
8125	39	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 0	7959	5274
8126	27	36	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 0	7959	5275
8127	46	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 35 let úroveň 1	7960	5258
8128	41	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 35 let úroveň 1	7960	5253
8129	49	42	Poznámka k aktivitě Skok na jednu nohu. Osooba: 35 let úroveň 1	7960	5254
8130	20	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 35 let úroveň 1	7960	5277
8131	91	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 35 let úroveň 1	7960	5275
8132	57	30	Poznámka k aktivitě Slalom s míčem. Osooba: 35 let úroveň 1	7960	5276
8133	92	38	Poznámka k aktivitě Letmý start. Osooba: 35 let úroveň 1	7960	5256
8134	65	31	Poznámka k aktivitě Překážková dráha. Osooba: 35 let úroveň 1	7960	5257
8135	20	42	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 35 let úroveň 1	7960	5260
8136	29	32	Poznámka k aktivitě Lowa brace test. Osooba: 35 let úroveň 1	7960	5261
8137	44	45	Poznámka k aktivitě Žebřík. Osooba: 35 let úroveň 1	7960	5262
8138	87	46	Poznámka k aktivitě Skok daleký. Osooba: 35 let úroveň 1	7960	5265
8139	63	\N	Poznámka k aktivitě slalom. Osooba: 35 let úroveň 1	7960	5269
8140	28	48	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 35 let úroveň 1	7960	5274
8141	74	38	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 0	7961	5261
8142	74	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 0	7961	5253
8143	36	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 0	7961	5254
8144	72	44	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 0	7961	5256
8145	96	48	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 0	7961	5257
8146	23	50	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 0	7961	5258
8147	68	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 0	7961	5260
8148	47	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 0	7961	5275
8149	80	30	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 0	7961	5276
8150	51	49	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 0	7961	5262
8151	56	44	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 0	7961	5277
8152	55	45	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 0	7961	5265
8153	50	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 0	7961	5269
8154	71	46	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 0	7961	5274
8155	72	33	Poznámka k aktivitě Překážková dráha. Osooba: 36 let úroveň 1	7962	5257
8156	50	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 36 let úroveň 1	7962	5253
8157	47	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 36 let úroveň 1	7962	5254
8158	73	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 36 let úroveň 1	7962	5277
8159	44	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 36 let úroveň 1	7962	5275
8160	95	49	Poznámka k aktivitě Letmý start. Osooba: 36 let úroveň 1	7962	5256
8161	21	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 36 let úroveň 1	7962	5258
8162	30	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 36 let úroveň 1	7962	5260
8163	51	43	Poznámka k aktivitě Lowa brace test. Osooba: 36 let úroveň 1	7962	5261
8164	38	30	Poznámka k aktivitě Žebřík. Osooba: 36 let úroveň 1	7962	5262
8165	49	41	Poznámka k aktivitě Skok daleký. Osooba: 36 let úroveň 1	7962	5265
8166	44	\N	Poznámka k aktivitě slalom. Osooba: 36 let úroveň 1	7962	5269
8167	83	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 36 let úroveň 1	7962	5274
8168	84	31	Poznámka k aktivitě Slalom s míčem. Osooba: 36 let úroveň 1	7962	5276
8169	26	44	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 0	7963	5258
8170	36	46	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 0	7963	5253
8171	50	45	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 0	7963	5276
8172	91	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 0	7963	5254
8173	44	40	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 0	7963	5256
8174	84	42	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 0	7963	5257
8175	40	38	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 0	7963	5260
8176	75	33	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 0	7963	5261
8177	64	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 0	7963	5275
8178	31	33	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 0	7963	5262
8179	33	41	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 0	7963	5265
8180	92	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 0	7963	5277
8181	81	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 0	7963	5269
8182	97	34	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 0	7963	5274
8183	48	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 37 let úroveň 1	7964	5258
8184	43	38	Poznámka k aktivitě Stoj na jedné noze. Osooba: 37 let úroveň 1	7964	5253
8185	86	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 37 let úroveň 1	7964	5275
8186	41	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 37 let úroveň 1	7964	5254
8187	39	33	Poznámka k aktivitě Letmý start. Osooba: 37 let úroveň 1	7964	5256
8188	94	32	Poznámka k aktivitě Překážková dráha. Osooba: 37 let úroveň 1	7964	5257
8189	79	36	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 37 let úroveň 1	7964	5277
8190	76	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 37 let úroveň 1	7964	5260
8191	48	45	Poznámka k aktivitě Lowa brace test. Osooba: 37 let úroveň 1	7964	5261
8192	28	48	Poznámka k aktivitě Slalom s míčem. Osooba: 37 let úroveň 1	7964	5276
8193	80	48	Poznámka k aktivitě Žebřík. Osooba: 37 let úroveň 1	7964	5262
8194	36	38	Poznámka k aktivitě Skok daleký. Osooba: 37 let úroveň 1	7964	5265
8195	100	\N	Poznámka k aktivitě slalom. Osooba: 37 let úroveň 1	7964	5269
8196	32	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 37 let úroveň 1	7964	5274
8197	26	33	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 0	7965	5257
8198	25	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 0	7965	5253
8199	78	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 0	7965	5254
8200	100	34	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 0	7965	5256
8201	68	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 0	7965	5277
8202	45	31	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 0	7965	5258
8203	49	49	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 0	7965	5260
8204	55	46	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 0	7965	5261
8205	50	46	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 0	7965	5262
8206	89	31	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 0	7965	5276
8207	39	30	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 0	7965	5265
8208	50	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 0	7965	5275
8209	48	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 0	7965	5269
8210	95	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 0	7965	5274
8211	91	42	Poznámka k aktivitě Lowa brace test. Osooba: 38 let úroveň 1	7966	5261
8212	62	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 38 let úroveň 1	7966	5253
8213	62	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 38 let úroveň 1	7966	5254
8214	49	33	Poznámka k aktivitě Letmý start. Osooba: 38 let úroveň 1	7966	5256
8215	58	32	Poznámka k aktivitě Slalom s míčem. Osooba: 38 let úroveň 1	7966	5276
8216	58	33	Poznámka k aktivitě Překážková dráha. Osooba: 38 let úroveň 1	7966	5257
8217	22	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 38 let úroveň 1	7966	5258
8218	22	43	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 38 let úroveň 1	7966	5260
8219	92	44	Poznámka k aktivitě Žebřík. Osooba: 38 let úroveň 1	7966	5262
8220	35	32	Poznámka k aktivitě Skok daleký. Osooba: 38 let úroveň 1	7966	5265
8221	79	\N	Poznámka k aktivitě slalom. Osooba: 38 let úroveň 1	7966	5269
8222	81	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 38 let úroveň 1	7966	5277
8223	73	48	Poznámka k aktivitě Výdrž ve sporu. Osooba: 38 let úroveň 1	7966	5275
8224	35	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 38 let úroveň 1	7966	5274
8225	78	31	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 0	7967	5256
8226	91	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 0	7967	5253
8227	29	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 0	7967	5254
8228	70	40	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 0	7967	5257
8229	75	37	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 0	7967	5276
8230	37	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 0	7967	5258
8231	41	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 0	7967	5260
8232	84	44	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 0	7967	5261
8233	60	37	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 0	7967	5262
8234	62	36	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 0	7967	5265
8235	23	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 0	7967	5277
8236	56	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 0	7967	5269
8237	45	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 0	7967	5274
8238	87	41	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 0	7967	5275
8239	97	46	Poznámka k aktivitě Skok daleký. Osooba: 39 let úroveň 1	7968	5265
8240	73	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 39 let úroveň 1	7968	5253
8241	31	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 39 let úroveň 1	7968	5254
8242	84	30	Poznámka k aktivitě Letmý start. Osooba: 39 let úroveň 1	7968	5256
8243	34	43	Poznámka k aktivitě Překážková dráha. Osooba: 39 let úroveň 1	7968	5257
8244	24	43	Poznámka k aktivitě Slalom s míčem. Osooba: 39 let úroveň 1	7968	5276
8245	71	42	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 39 let úroveň 1	7968	5258
8246	68	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 39 let úroveň 1	7968	5260
8247	76	43	Poznámka k aktivitě Lowa brace test. Osooba: 39 let úroveň 1	7968	5261
8248	34	33	Poznámka k aktivitě Žebřík. Osooba: 39 let úroveň 1	7968	5262
8249	82	\N	Poznámka k aktivitě slalom. Osooba: 39 let úroveň 1	7968	5269
8250	26	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 39 let úroveň 1	7968	5277
8251	87	33	Poznámka k aktivitě Výdrž ve sporu. Osooba: 39 let úroveň 1	7968	5275
8252	95	44	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 39 let úroveň 1	7968	5274
8253	20	34	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 0	7969	5261
8254	59	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 0	7969	5253
8255	28	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 0	7969	5254
8256	86	42	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 0	7969	5256
8257	74	41	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 0	7969	5257
8258	30	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 0	7969	5258
8259	92	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 0	7969	5260
8260	89	32	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 0	7969	5262
8261	80	40	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 0	7969	5276
8262	31	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 0	7969	5277
8263	56	31	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 0	7969	5265
8264	85	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 0	7969	5269
8265	63	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 0	7969	5274
8266	87	50	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 0	7969	5275
8267	20	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 40 let úroveň 1	7970	5260
8268	77	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 40 let úroveň 1	7970	5253
8269	100	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 40 let úroveň 1	7970	5254
8270	31	45	Poznámka k aktivitě Letmý start. Osooba: 40 let úroveň 1	7970	5256
8271	45	45	Poznámka k aktivitě Překážková dráha. Osooba: 40 let úroveň 1	7970	5257
8272	49	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 40 let úroveň 1	7970	5258
8273	67	32	Poznámka k aktivitě Lowa brace test. Osooba: 40 let úroveň 1	7970	5261
8274	32	46	Poznámka k aktivitě Žebřík. Osooba: 40 let úroveň 1	7970	5262
8275	68	42	Poznámka k aktivitě Slalom s míčem. Osooba: 40 let úroveň 1	7970	5276
8276	60	38	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 40 let úroveň 1	7970	5277
8277	75	32	Poznámka k aktivitě Skok daleký. Osooba: 40 let úroveň 1	7970	5265
8278	82	\N	Poznámka k aktivitě slalom. Osooba: 40 let úroveň 1	7970	5269
8279	36	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 40 let úroveň 1	7970	5274
8280	84	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 40 let úroveň 1	7970	5275
8281	27	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 0	7971	5258
8282	26	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 0	7971	5253
8283	44	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 0	7971	5277
8284	49	33	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 0	7971	5254
8285	40	48	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 0	7971	5256
8286	81	42	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 0	7971	5276
8287	79	35	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 0	7971	5257
8288	70	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 0	7971	5260
8289	53	30	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 0	7971	5261
8290	74	49	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 0	7971	5262
8291	75	42	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 0	7971	5265
8292	74	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 0	7971	5269
8293	55	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 0	7971	5274
8294	82	40	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 0	7971	5275
8295	37	46	Poznámka k aktivitě Překážková dráha. Osooba: 41 let úroveň 1	7972	5257
8296	88	39	Poznámka k aktivitě Stoj na jedné noze. Osooba: 41 let úroveň 1	7972	5253
8297	74	41	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 41 let úroveň 1	7972	5277
8298	31	36	Poznámka k aktivitě Skok na jednu nohu. Osooba: 41 let úroveň 1	7972	5254
8299	49	35	Poznámka k aktivitě Letmý start. Osooba: 41 let úroveň 1	7972	5256
8300	93	38	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 41 let úroveň 1	7972	5258
8301	70	38	Poznámka k aktivitě Slalom s míčem. Osooba: 41 let úroveň 1	7972	5276
8302	90	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 41 let úroveň 1	7972	5260
8303	96	40	Poznámka k aktivitě Lowa brace test. Osooba: 41 let úroveň 1	7972	5261
8304	29	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: 41 let úroveň 1	7972	5275
8305	44	45	Poznámka k aktivitě Žebřík. Osooba: 41 let úroveň 1	7972	5262
8306	81	48	Poznámka k aktivitě Skok daleký. Osooba: 41 let úroveň 1	7972	5265
8307	30	\N	Poznámka k aktivitě slalom. Osooba: 41 let úroveň 1	7972	5269
8308	67	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 41 let úroveň 1	7972	5274
8309	53	44	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 0	7973	5261
8310	28	42	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 0	7973	5253
8311	76	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 0	7973	5277
8312	45	44	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 0	7973	5254
8313	62	39	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 0	7973	5256
8314	34	40	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 0	7973	5276
8315	61	48	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 0	7973	5257
8316	29	32	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 0	7973	5258
8317	44	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 0	7973	5260
8318	96	30	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 0	7973	5262
8319	78	36	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 0	7973	5265
8320	46	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 0	7973	5269
8321	76	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 0	7973	5275
8322	61	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 0	7973	5274
8323	21	50	Poznámka k aktivitě Žebřík. Osooba: 42 let úroveň 1	7974	5262
8324	76	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 42 let úroveň 1	7974	5253
8325	79	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 42 let úroveň 1	7974	5254
8326	22	36	Poznámka k aktivitě Letmý start. Osooba: 42 let úroveň 1	7974	5256
8327	54	33	Poznámka k aktivitě Překážková dráha. Osooba: 42 let úroveň 1	7974	5257
8328	63	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 42 let úroveň 1	7974	5258
8329	39	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 42 let úroveň 1	7974	5260
8330	98	30	Poznámka k aktivitě Slalom s míčem. Osooba: 42 let úroveň 1	7974	5276
8331	57	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 42 let úroveň 1	7974	5277
8332	97	38	Poznámka k aktivitě Lowa brace test. Osooba: 42 let úroveň 1	7974	5261
8333	23	50	Poznámka k aktivitě Skok daleký. Osooba: 42 let úroveň 1	7974	5265
8334	54	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 42 let úroveň 1	7974	5275
8335	27	\N	Poznámka k aktivitě slalom. Osooba: 42 let úroveň 1	7974	5269
8336	93	40	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 42 let úroveň 1	7974	5274
8337	23	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 0	7975	5253
8338	49	30	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 0	7975	5254
8339	69	32	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 0	7975	5277
8340	71	48	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 0	7975	5256
8341	72	46	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 0	7975	5257
8342	61	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 0	7975	5258
8343	58	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 0	7975	5260
8344	100	46	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 0	7975	5261
8345	59	35	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 0	7975	5262
8346	65	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 0	7975	5275
8347	67	35	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 0	7975	5276
8348	36	49	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 0	7975	5265
8349	97	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 0	7975	5269
8350	92	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 0	7975	5274
8351	82	41	Poznámka k aktivitě Překážková dráha. Osooba: 43 let úroveň 1	7976	5257
8352	58	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 43 let úroveň 1	7976	5253
8353	92	34	Poznámka k aktivitě Skok na jednu nohu. Osooba: 43 let úroveň 1	7976	5254
8354	46	35	Poznámka k aktivitě Letmý start. Osooba: 43 let úroveň 1	7976	5256
8355	65	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 43 let úroveň 1	7976	5258
8356	33	43	Poznámka k aktivitě Výdrž ve sporu. Osooba: 43 let úroveň 1	7976	5275
8357	55	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 43 let úroveň 1	7976	5260
8358	81	39	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 43 let úroveň 1	7976	5277
8359	37	40	Poznámka k aktivitě Lowa brace test. Osooba: 43 let úroveň 1	7976	5261
8360	42	41	Poznámka k aktivitě Žebřík. Osooba: 43 let úroveň 1	7976	5262
8361	71	31	Poznámka k aktivitě Skok daleký. Osooba: 43 let úroveň 1	7976	5265
8362	59	42	Poznámka k aktivitě Slalom s míčem. Osooba: 43 let úroveň 1	7976	5276
8363	42	\N	Poznámka k aktivitě slalom. Osooba: 43 let úroveň 1	7976	5269
8364	98	33	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 43 let úroveň 1	7976	5274
8365	49	40	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 0	7977	5257
8366	52	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 0	7977	5253
8367	68	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 0	7977	5254
8368	88	34	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 0	7977	5256
8369	41	40	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 0	7977	5258
8370	58	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 0	7977	5275
8371	92	45	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 0	7977	5276
8372	59	50	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 0	7977	5260
8373	47	41	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 0	7977	5261
8374	62	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 0	7977	5277
8375	74	46	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 0	7977	5262
8376	72	31	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 0	7977	5265
8377	73	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 0	7977	5269
8378	73	31	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 0	7977	5274
8379	32	42	Poznámka k aktivitě Letmý start. Osooba: 44 let úroveň 1	7978	5256
8380	52	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 44 let úroveň 1	7978	5253
8381	47	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 44 let úroveň 1	7978	5254
8382	36	40	Poznámka k aktivitě Překážková dráha. Osooba: 44 let úroveň 1	7978	5257
8383	34	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 44 let úroveň 1	7978	5258
8384	40	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 44 let úroveň 1	7978	5260
8385	62	46	Poznámka k aktivitě Slalom s míčem. Osooba: 44 let úroveň 1	7978	5276
8386	49	46	Poznámka k aktivitě Lowa brace test. Osooba: 44 let úroveň 1	7978	5261
8387	76	45	Poznámka k aktivitě Žebřík. Osooba: 44 let úroveň 1	7978	5262
8388	33	45	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 44 let úroveň 1	7978	5277
8389	66	32	Poznámka k aktivitě Skok daleký. Osooba: 44 let úroveň 1	7978	5265
8390	85	\N	Poznámka k aktivitě slalom. Osooba: 44 let úroveň 1	7978	5269
8391	31	32	Poznámka k aktivitě Výdrž ve sporu. Osooba: 44 let úroveň 1	7978	5275
8392	56	41	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 44 let úroveň 1	7978	5274
8393	90	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 0	7979	5253
8394	48	49	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 0	7979	5254
8395	27	42	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 0	7979	5256
8396	31	30	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 0	7979	5277
8397	95	32	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 0	7979	5257
8398	54	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 0	7979	5258
8399	55	34	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 0	7979	5260
8400	36	31	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 0	7979	5261
8401	50	50	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 0	7979	5262
8402	95	48	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 0	7979	5265
8403	67	38	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 0	7979	5276
8404	45	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 0	7979	5269
8405	41	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 0	7979	5274
8406	28	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 0	7979	5275
8407	38	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 45 let úroveň 1	7980	5258
8408	34	44	Poznámka k aktivitě Stoj na jedné noze. Osooba: 45 let úroveň 1	7980	5253
8409	64	35	Poznámka k aktivitě Skok na jednu nohu. Osooba: 45 let úroveň 1	7980	5254
8410	32	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 45 let úroveň 1	7980	5275
8411	72	32	Poznámka k aktivitě Letmý start. Osooba: 45 let úroveň 1	7980	5256
8412	56	45	Poznámka k aktivitě Překážková dráha. Osooba: 45 let úroveň 1	7980	5257
8413	48	39	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 45 let úroveň 1	7980	5260
8414	74	33	Poznámka k aktivitě Lowa brace test. Osooba: 45 let úroveň 1	7980	5261
8415	96	36	Poznámka k aktivitě Žebřík. Osooba: 45 let úroveň 1	7980	5262
8416	94	35	Poznámka k aktivitě Skok daleký. Osooba: 45 let úroveň 1	7980	5265
8417	66	49	Poznámka k aktivitě Slalom s míčem. Osooba: 45 let úroveň 1	7980	5276
8418	51	34	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 45 let úroveň 1	7980	5277
8419	89	\N	Poznámka k aktivitě slalom. Osooba: 45 let úroveň 1	7980	5269
8420	57	32	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 45 let úroveň 1	7980	5274
8421	59	38	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 0	7981	5256
8422	67	37	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 0	7981	5253
8423	89	31	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 0	7981	5276
8424	59	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 0	7981	5254
8425	80	46	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 0	7981	5257
8426	30	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 0	7981	5258
8427	74	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 0	7981	5260
8428	45	43	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 0	7981	5261
8429	38	41	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 0	7981	5262
8430	68	44	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 0	7981	5265
8431	23	47	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 0	7981	5277
8432	60	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 0	7981	5269
8433	45	37	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 0	7981	5275
8434	96	38	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 0	7981	5274
8435	52	49	Poznámka k aktivitě Stoj na jedné noze. Osooba: 46 let úroveň 1	7982	5253
8436	60	45	Poznámka k aktivitě Skok na jednu nohu. Osooba: 46 let úroveň 1	7982	5254
8437	40	44	Poznámka k aktivitě Slalom s míčem. Osooba: 46 let úroveň 1	7982	5276
8438	64	30	Poznámka k aktivitě Letmý start. Osooba: 46 let úroveň 1	7982	5256
8439	39	47	Poznámka k aktivitě Výdrž ve sporu. Osooba: 46 let úroveň 1	7982	5275
8440	39	44	Poznámka k aktivitě Překážková dráha. Osooba: 46 let úroveň 1	7982	5257
8441	22	41	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 46 let úroveň 1	7982	5258
8442	77	40	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 46 let úroveň 1	7982	5260
8443	100	34	Poznámka k aktivitě Lowa brace test. Osooba: 46 let úroveň 1	7982	5261
8444	47	40	Poznámka k aktivitě Žebřík. Osooba: 46 let úroveň 1	7982	5262
8445	36	31	Poznámka k aktivitě Skok daleký. Osooba: 46 let úroveň 1	7982	5265
8446	38	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 46 let úroveň 1	7982	5277
8447	46	\N	Poznámka k aktivitě slalom. Osooba: 46 let úroveň 1	7982	5269
8448	44	50	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 46 let úroveň 1	7982	5274
8449	21	39	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 0	7983	5261
8450	21	30	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 0	7983	5253
8451	25	39	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 0	7983	5254
8452	87	34	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 0	7983	5275
8453	93	40	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 0	7983	5277
8454	24	46	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 0	7983	5256
8455	97	49	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 0	7983	5257
8456	59	34	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 0	7983	5258
8457	92	33	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 0	7983	5260
8458	22	48	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 0	7983	5262
8459	21	48	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 0	7983	5265
8460	92	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 0	7983	5269
8461	92	36	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 0	7983	5274
8462	46	44	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 0	7983	5276
8463	54	44	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 47 let úroveň 1	7984	5260
8464	78	36	Poznámka k aktivitě Stoj na jedné noze. Osooba: 47 let úroveň 1	7984	5253
8465	21	47	Poznámka k aktivitě Skok na jednu nohu. Osooba: 47 let úroveň 1	7984	5254
8466	97	45	Poznámka k aktivitě Letmý start. Osooba: 47 let úroveň 1	7984	5256
8467	59	42	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 47 let úroveň 1	7984	5277
8468	23	38	Poznámka k aktivitě Překážková dráha. Osooba: 47 let úroveň 1	7984	5257
8469	77	49	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 47 let úroveň 1	7984	5258
8470	59	39	Poznámka k aktivitě Lowa brace test. Osooba: 47 let úroveň 1	7984	5261
8471	57	36	Poznámka k aktivitě Žebřík. Osooba: 47 let úroveň 1	7984	5262
8472	69	49	Poznámka k aktivitě Slalom s míčem. Osooba: 47 let úroveň 1	7984	5276
8473	95	50	Poznámka k aktivitě Skok daleký. Osooba: 47 let úroveň 1	7984	5265
8474	32	49	Poznámka k aktivitě Výdrž ve sporu. Osooba: 47 let úroveň 1	7984	5275
8475	42	\N	Poznámka k aktivitě slalom. Osooba: 47 let úroveň 1	7984	5269
8476	90	47	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 47 let úroveň 1	7984	5274
8477	45	32	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 0	7985	5260
8478	66	40	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 0	7985	5253
8479	37	32	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 0	7985	5254
8480	24	40	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 0	7985	5256
8481	58	50	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 0	7985	5257
8482	88	44	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 0	7985	5276
8483	68	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 0	7985	5258
8484	50	43	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 0	7985	5261
8485	38	43	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 0	7985	5262
8486	36	44	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 0	7985	5275
8487	55	49	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 0	7985	5265
8488	28	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 0	7985	5269
8489	76	43	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 0	7985	5277
8490	36	35	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 0	7985	5274
8491	72	35	Poznámka k aktivitě Stoj na jedné noze. Osooba: 48 let úroveň 1	7986	5253
8492	84	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: 48 let úroveň 1	7986	5254
8493	58	45	Poznámka k aktivitě Letmý start. Osooba: 48 let úroveň 1	7986	5256
8494	83	43	Poznámka k aktivitě Překážková dráha. Osooba: 48 let úroveň 1	7986	5257
8495	71	33	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 48 let úroveň 1	7986	5258
8496	83	46	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 48 let úroveň 1	7986	5260
8497	89	37	Poznámka k aktivitě Slalom s míčem. Osooba: 48 let úroveň 1	7986	5276
8498	43	39	Poznámka k aktivitě Lowa brace test. Osooba: 48 let úroveň 1	7986	5261
8499	94	50	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 48 let úroveň 1	7986	5277
8500	40	38	Poznámka k aktivitě Žebřík. Osooba: 48 let úroveň 1	7986	5262
8501	61	44	Poznámka k aktivitě Skok daleký. Osooba: 48 let úroveň 1	7986	5265
8502	28	\N	Poznámka k aktivitě slalom. Osooba: 48 let úroveň 1	7986	5269
8503	57	38	Poznámka k aktivitě Výdrž ve sporu. Osooba: 48 let úroveň 1	7986	5275
8504	71	49	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 48 let úroveň 1	7986	5274
8505	80	41	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 0	7987	5260
8506	89	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 0	7987	5253
8507	95	40	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 0	7987	5254
8508	61	37	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 0	7987	5256
8509	91	49	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 0	7987	5257
8510	53	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 0	7987	5258
8511	33	42	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 0	7987	5275
8512	23	32	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 0	7987	5261
8513	20	48	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 0	7987	5262
8514	75	34	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 0	7987	5265
8515	33	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 0	7987	5269
8516	48	50	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 0	7987	5276
8517	67	33	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 0	7987	5277
8518	20	45	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 0	7987	5274
8519	29	44	Poznámka k aktivitě Překážková dráha. Osooba: 49 let úroveň 1	7988	5257
8520	78	33	Poznámka k aktivitě Stoj na jedné noze. Osooba: 49 let úroveň 1	7988	5253
8521	72	38	Poznámka k aktivitě Skok na jednu nohu. Osooba: 49 let úroveň 1	7988	5254
8522	76	49	Poznámka k aktivitě Letmý start. Osooba: 49 let úroveň 1	7988	5256
8523	63	30	Poznámka k aktivitě Výdrž ve sporu. Osooba: 49 let úroveň 1	7988	5275
8524	46	33	Poznámka k aktivitě Slalom s míčem. Osooba: 49 let úroveň 1	7988	5276
8525	79	39	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: 49 let úroveň 1	7988	5258
8526	84	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: 49 let úroveň 1	7988	5277
8527	59	36	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: 49 let úroveň 1	7988	5260
8528	87	30	Poznámka k aktivitě Lowa brace test. Osooba: 49 let úroveň 1	7988	5261
8529	86	36	Poznámka k aktivitě Žebřík. Osooba: 49 let úroveň 1	7988	5262
8530	22	32	Poznámka k aktivitě Skok daleký. Osooba: 49 let úroveň 1	7988	5265
8531	39	\N	Poznámka k aktivitě slalom. Osooba: 49 let úroveň 1	7988	5269
8532	94	42	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: 49 let úroveň 1	7988	5274
8533	33	37	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 0	7989	5266
8534	32	39	Poznámka k aktivitě Dřepy. Osooba: 6 let úroveň 0	7989	6701
8535	31	41	Poznámka k aktivitě Kliky. Osooba: 6 let úroveň 1	7990	5266
8536	89	34	Poznámka k aktivitě Dřepy. Osooba: 6 let úroveň 1	7990	6701
8537	61	44	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 0	7991	5266
8538	86	42	Poznámka k aktivitě Dřepy. Osooba: 7 let úroveň 0	7991	6701
8539	72	32	Poznámka k aktivitě Kliky. Osooba: 7 let úroveň 1	7992	5266
8540	76	39	Poznámka k aktivitě Dřepy. Osooba: 7 let úroveň 1	7992	6701
8541	41	39	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 0	7993	5266
8542	65	37	Poznámka k aktivitě Dřepy. Osooba: 8 let úroveň 0	7993	6701
8543	88	39	Poznámka k aktivitě Kliky. Osooba: 8 let úroveň 1	7994	5266
8544	62	49	Poznámka k aktivitě Dřepy. Osooba: 8 let úroveň 1	7994	6701
8545	98	44	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 0	7995	5266
8546	23	32	Poznámka k aktivitě Dřepy. Osooba: 9 let úroveň 0	7995	6701
8547	48	48	Poznámka k aktivitě Kliky. Osooba: 9 let úroveň 1	7996	5266
8548	32	31	Poznámka k aktivitě Dřepy. Osooba: 9 let úroveň 1	7996	6701
8549	65	30	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 0	7997	5266
8550	91	47	Poznámka k aktivitě Dřepy. Osooba: 10 let úroveň 0	7997	6701
8551	98	39	Poznámka k aktivitě Kliky. Osooba: 10 let úroveň 1	7998	5266
8552	52	37	Poznámka k aktivitě Dřepy. Osooba: 10 let úroveň 1	7998	6701
8553	70	34	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 0	7999	5266
8554	26	35	Poznámka k aktivitě Dřepy. Osooba: 11 let úroveň 0	7999	6701
8555	44	48	Poznámka k aktivitě Kliky. Osooba: 11 let úroveň 1	8000	5266
8556	44	36	Poznámka k aktivitě Dřepy. Osooba: 11 let úroveň 1	8000	6701
8557	61	50	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 0	8651	5266
8558	93	34	Poznámka k aktivitě Dřepy. Osooba: 12 let úroveň 0	8651	6701
8559	23	33	Poznámka k aktivitě Kliky. Osooba: 12 let úroveň 1	8652	5266
8560	52	33	Poznámka k aktivitě Dřepy. Osooba: 12 let úroveň 1	8652	6701
8561	38	43	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 0	8653	5266
8562	67	41	Poznámka k aktivitě Dřepy. Osooba: 13 let úroveň 0	8653	6701
8563	31	41	Poznámka k aktivitě Kliky. Osooba: 13 let úroveň 1	8654	5266
8564	42	33	Poznámka k aktivitě Dřepy. Osooba: 13 let úroveň 1	8654	6701
8565	74	40	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 0	8655	5266
8566	74	42	Poznámka k aktivitě Dřepy. Osooba: 14 let úroveň 0	8655	6701
8567	88	50	Poznámka k aktivitě Kliky. Osooba: 14 let úroveň 1	8656	5266
8568	37	30	Poznámka k aktivitě Dřepy. Osooba: 14 let úroveň 1	8656	6701
8569	78	32	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 0	8657	5266
8570	31	47	Poznámka k aktivitě Dřepy. Osooba: 15 let úroveň 0	8657	6701
8571	73	36	Poznámka k aktivitě Kliky. Osooba: 15 let úroveň 1	8658	5266
8572	61	47	Poznámka k aktivitě Dřepy. Osooba: 15 let úroveň 1	8658	6701
8573	85	32	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 0	8659	5266
8574	98	46	Poznámka k aktivitě Dřepy. Osooba: 16 let úroveň 0	8659	6701
8575	74	47	Poznámka k aktivitě Kliky. Osooba: 16 let úroveň 1	8660	5266
8576	40	45	Poznámka k aktivitě Dřepy. Osooba: 16 let úroveň 1	8660	6701
8577	48	41	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 0	8661	5266
8578	77	49	Poznámka k aktivitě Dřepy. Osooba: 17 let úroveň 0	8661	6701
8579	92	47	Poznámka k aktivitě Kliky. Osooba: 17 let úroveň 1	8662	5266
8580	74	32	Poznámka k aktivitě Dřepy. Osooba: 17 let úroveň 1	8662	6701
8581	40	44	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 0	8663	5266
8582	43	30	Poznámka k aktivitě Dřepy. Osooba: 18 let úroveň 0	8663	6701
8583	75	36	Poznámka k aktivitě Kliky. Osooba: 18 let úroveň 1	8664	5266
8584	49	35	Poznámka k aktivitě Dřepy. Osooba: 18 let úroveň 1	8664	6701
8585	42	50	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 0	8665	5266
8586	61	31	Poznámka k aktivitě Dřepy. Osooba: 19 let úroveň 0	8665	6701
8587	40	30	Poznámka k aktivitě Kliky. Osooba: 19 let úroveň 1	8666	5266
8588	32	40	Poznámka k aktivitě Dřepy. Osooba: 19 let úroveň 1	8666	6701
8589	44	49	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 0	8667	5266
8590	27	30	Poznámka k aktivitě Dřepy. Osooba: 20 let úroveň 0	8667	6701
8591	39	32	Poznámka k aktivitě Kliky. Osooba: 20 let úroveň 1	8668	5266
8592	28	30	Poznámka k aktivitě Dřepy. Osooba: 20 let úroveň 1	8668	6701
8593	51	44	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 0	8669	5266
8594	40	39	Poznámka k aktivitě Dřepy. Osooba: 21 let úroveň 0	8669	6701
8595	80	32	Poznámka k aktivitě Kliky. Osooba: 21 let úroveň 1	8670	5266
8596	28	34	Poznámka k aktivitě Dřepy. Osooba: 21 let úroveň 1	8670	6701
8597	49	40	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 0	8671	5266
8598	83	47	Poznámka k aktivitě Dřepy. Osooba: 22 let úroveň 0	8671	6701
8599	75	46	Poznámka k aktivitě Kliky. Osooba: 22 let úroveň 1	8672	5266
8600	57	34	Poznámka k aktivitě Dřepy. Osooba: 22 let úroveň 1	8672	6701
8701	73	50	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 0	8673	5266
8702	52	37	Poznámka k aktivitě Dřepy. Osooba: 23 let úroveň 0	8673	6701
8703	40	30	Poznámka k aktivitě Kliky. Osooba: 23 let úroveň 1	8674	5266
8704	96	35	Poznámka k aktivitě Dřepy. Osooba: 23 let úroveň 1	8674	6701
8705	84	42	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 0	8675	5266
8706	96	32	Poznámka k aktivitě Dřepy. Osooba: 24 let úroveň 0	8675	6701
8707	96	42	Poznámka k aktivitě Kliky. Osooba: 24 let úroveň 1	8676	5266
8708	99	46	Poznámka k aktivitě Dřepy. Osooba: 24 let úroveň 1	8676	6701
8709	73	50	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 0	8677	5266
8710	66	39	Poznámka k aktivitě Dřepy. Osooba: 25 let úroveň 0	8677	6701
8711	73	38	Poznámka k aktivitě Kliky. Osooba: 25 let úroveň 1	8678	5266
8712	82	43	Poznámka k aktivitě Dřepy. Osooba: 25 let úroveň 1	8678	6701
8713	70	38	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 0	8679	5266
8714	51	34	Poznámka k aktivitě Dřepy. Osooba: 26 let úroveň 0	8679	6701
8715	49	48	Poznámka k aktivitě Kliky. Osooba: 26 let úroveň 1	8680	5266
8716	57	47	Poznámka k aktivitě Dřepy. Osooba: 26 let úroveň 1	8680	6701
8717	100	43	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 0	8681	5266
8718	84	45	Poznámka k aktivitě Dřepy. Osooba: 27 let úroveň 0	8681	6701
8719	100	38	Poznámka k aktivitě Kliky. Osooba: 27 let úroveň 1	8682	5266
8720	96	48	Poznámka k aktivitě Dřepy. Osooba: 27 let úroveň 1	8682	6701
8721	49	50	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 0	8683	5266
8722	42	42	Poznámka k aktivitě Dřepy. Osooba: 28 let úroveň 0	8683	6701
8723	37	48	Poznámka k aktivitě Kliky. Osooba: 28 let úroveň 1	8684	5266
8724	38	48	Poznámka k aktivitě Dřepy. Osooba: 28 let úroveň 1	8684	6701
8725	70	33	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 0	8685	5266
8726	54	31	Poznámka k aktivitě Dřepy. Osooba: 29 let úroveň 0	8685	6701
8727	92	46	Poznámka k aktivitě Kliky. Osooba: 29 let úroveň 1	8686	5266
8728	60	44	Poznámka k aktivitě Dřepy. Osooba: 29 let úroveň 1	8686	6701
8729	56	47	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 0	8687	5266
8730	78	45	Poznámka k aktivitě Dřepy. Osooba: 30 let úroveň 0	8687	6701
8731	31	36	Poznámka k aktivitě Kliky. Osooba: 30 let úroveň 1	8688	5266
8732	23	43	Poznámka k aktivitě Dřepy. Osooba: 30 let úroveň 1	8688	6701
8733	71	50	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 0	8689	5266
8734	39	34	Poznámka k aktivitě Dřepy. Osooba: 31 let úroveň 0	8689	6701
8735	65	46	Poznámka k aktivitě Kliky. Osooba: 31 let úroveň 1	8690	5266
8736	48	35	Poznámka k aktivitě Dřepy. Osooba: 31 let úroveň 1	8690	6701
8737	88	34	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 0	8691	5266
8738	85	41	Poznámka k aktivitě Dřepy. Osooba: 32 let úroveň 0	8691	6701
8739	72	44	Poznámka k aktivitě Kliky. Osooba: 32 let úroveň 1	8692	5266
8740	87	49	Poznámka k aktivitě Dřepy. Osooba: 32 let úroveň 1	8692	6701
8741	86	30	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 0	8693	5266
8742	92	46	Poznámka k aktivitě Dřepy. Osooba: 33 let úroveň 0	8693	6701
8743	65	49	Poznámka k aktivitě Kliky. Osooba: 33 let úroveň 1	8694	5266
8744	39	43	Poznámka k aktivitě Dřepy. Osooba: 33 let úroveň 1	8694	6701
8745	62	31	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 0	8695	5266
8746	58	35	Poznámka k aktivitě Dřepy. Osooba: 34 let úroveň 0	8695	6701
8747	89	36	Poznámka k aktivitě Kliky. Osooba: 34 let úroveň 1	8696	5266
8748	97	46	Poznámka k aktivitě Dřepy. Osooba: 34 let úroveň 1	8696	6701
8749	86	47	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 0	8697	5266
8750	29	36	Poznámka k aktivitě Dřepy. Osooba: 35 let úroveň 0	8697	6701
8751	67	33	Poznámka k aktivitě Kliky. Osooba: 35 let úroveň 1	8698	5266
8752	89	40	Poznámka k aktivitě Dřepy. Osooba: 35 let úroveň 1	8698	6701
8753	32	31	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 0	8699	5266
8754	40	44	Poznámka k aktivitě Dřepy. Osooba: 36 let úroveň 0	8699	6701
8755	52	39	Poznámka k aktivitě Kliky. Osooba: 36 let úroveň 1	8700	5266
8756	84	38	Poznámka k aktivitě Dřepy. Osooba: 36 let úroveň 1	8700	6701
8757	40	40	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 0	8851	5266
8758	53	50	Poznámka k aktivitě Dřepy. Osooba: 37 let úroveň 0	8851	6701
8759	57	45	Poznámka k aktivitě Kliky. Osooba: 37 let úroveň 1	8852	5266
8760	73	48	Poznámka k aktivitě Dřepy. Osooba: 37 let úroveň 1	8852	6701
8761	35	49	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 0	8853	5266
8762	96	41	Poznámka k aktivitě Dřepy. Osooba: 38 let úroveň 0	8853	6701
8763	37	35	Poznámka k aktivitě Kliky. Osooba: 38 let úroveň 1	8854	5266
8764	87	38	Poznámka k aktivitě Dřepy. Osooba: 38 let úroveň 1	8854	6701
8765	29	44	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 0	8855	5266
8766	75	37	Poznámka k aktivitě Dřepy. Osooba: 39 let úroveň 0	8855	6701
8767	68	35	Poznámka k aktivitě Kliky. Osooba: 39 let úroveň 1	8856	5266
8768	92	32	Poznámka k aktivitě Dřepy. Osooba: 39 let úroveň 1	8856	6701
8769	70	38	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 0	8857	5266
8770	67	44	Poznámka k aktivitě Dřepy. Osooba: 40 let úroveň 0	8857	6701
8771	21	35	Poznámka k aktivitě Kliky. Osooba: 40 let úroveň 1	8858	5266
8772	70	48	Poznámka k aktivitě Dřepy. Osooba: 40 let úroveň 1	8858	6701
8773	94	30	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 0	8859	5266
8774	20	45	Poznámka k aktivitě Dřepy. Osooba: 41 let úroveň 0	8859	6701
8775	45	43	Poznámka k aktivitě Kliky. Osooba: 41 let úroveň 1	8860	5266
8776	53	45	Poznámka k aktivitě Dřepy. Osooba: 41 let úroveň 1	8860	6701
8777	21	41	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 0	8861	5266
8778	90	30	Poznámka k aktivitě Dřepy. Osooba: 42 let úroveň 0	8861	6701
8779	56	48	Poznámka k aktivitě Kliky. Osooba: 42 let úroveň 1	8862	5266
8780	95	47	Poznámka k aktivitě Dřepy. Osooba: 42 let úroveň 1	8862	6701
8781	69	42	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 0	8863	5266
8782	75	41	Poznámka k aktivitě Dřepy. Osooba: 43 let úroveň 0	8863	6701
8783	64	50	Poznámka k aktivitě Kliky. Osooba: 43 let úroveň 1	8864	5266
8784	50	39	Poznámka k aktivitě Dřepy. Osooba: 43 let úroveň 1	8864	6701
8785	90	30	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 0	8865	5266
8786	29	40	Poznámka k aktivitě Dřepy. Osooba: 44 let úroveň 0	8865	6701
8787	46	30	Poznámka k aktivitě Kliky. Osooba: 44 let úroveň 1	8866	5266
8788	34	37	Poznámka k aktivitě Dřepy. Osooba: 44 let úroveň 1	8866	6701
8789	31	30	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 0	8867	5266
8790	86	39	Poznámka k aktivitě Dřepy. Osooba: 45 let úroveň 0	8867	6701
8791	37	41	Poznámka k aktivitě Kliky. Osooba: 45 let úroveň 1	8868	5266
8792	45	34	Poznámka k aktivitě Dřepy. Osooba: 45 let úroveň 1	8868	6701
8793	88	49	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 0	8869	5266
8794	36	36	Poznámka k aktivitě Dřepy. Osooba: 46 let úroveň 0	8869	6701
8795	72	50	Poznámka k aktivitě Kliky. Osooba: 46 let úroveň 1	8870	5266
8796	71	41	Poznámka k aktivitě Dřepy. Osooba: 46 let úroveň 1	8870	6701
8797	95	30	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 0	8871	5266
8798	57	49	Poznámka k aktivitě Dřepy. Osooba: 47 let úroveň 0	8871	6701
8799	38	36	Poznámka k aktivitě Kliky. Osooba: 47 let úroveň 1	8872	5266
8800	49	37	Poznámka k aktivitě Dřepy. Osooba: 47 let úroveň 1	8872	6701
8901	85	39	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 0	8873	5266
8902	50	43	Poznámka k aktivitě Dřepy. Osooba: 48 let úroveň 0	8873	6701
8903	71	41	Poznámka k aktivitě Kliky. Osooba: 48 let úroveň 1	8874	5266
8904	24	48	Poznámka k aktivitě Dřepy. Osooba: 48 let úroveň 1	8874	6701
8905	88	31	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 0	8875	5266
8906	91	41	Poznámka k aktivitě Dřepy. Osooba: 49 let úroveň 0	8875	6701
8907	77	48	Poznámka k aktivitě Kliky. Osooba: 49 let úroveň 1	8876	5266
8908	35	34	Poznámka k aktivitě Dřepy. Osooba: 49 let úroveň 1	8876	6701
9051	88	49	Poznámka k aktivitě Lowa brace test. Osooba: Luděk Rous	9001	5261
9052	49	32	Poznámka k aktivitě Stoj na jedné noze. Osooba: Luděk Rous	9001	5253
9053	68	37	Poznámka k aktivitě Skok na jednu nohu. Osooba: Luděk Rous	9001	5254
9054	84	48	Poznámka k aktivitě Letmý start. Osooba: Luděk Rous	9001	5256
9055	50	45	Poznámka k aktivitě Výdrž ve sporu. Osooba: Luděk Rous	9001	5275
9056	22	39	Poznámka k aktivitě Překážková dráha. Osooba: Luděk Rous	9001	5257
9057	78	45	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Luděk Rous	9001	5258
9058	73	31	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Luděk Rous	9001	5277
9059	90	31	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Luděk Rous	9001	5260
9060	33	41	Poznámka k aktivitě Žebřík. Osooba: Luděk Rous	9001	5262
9061	44	50	Poznámka k aktivitě Slalom s míčem. Osooba: Luděk Rous	9001	5276
9062	40	35	Poznámka k aktivitě Skok daleký. Osooba: Luděk Rous	9001	5265
9063	24	\N	Poznámka k aktivitě slalom. Osooba: Luděk Rous	9001	5269
9064	85	37	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Luděk Rous	9001	5274
9065	72	47	Poznámka k aktivitě Stoj na jedné noze. Osooba: Jan Selinger	9002	5253
9066	29	31	Poznámka k aktivitě Skok na jednu nohu. Osooba: Jan Selinger	9002	5254
9067	78	49	Poznámka k aktivitě Běh 50 metrů s míčem. Osooba: Jan Selinger	9002	5277
9068	90	39	Poznámka k aktivitě Letmý start. Osooba: Jan Selinger	9002	5256
9069	97	46	Poznámka k aktivitě Překážková dráha. Osooba: Jan Selinger	9002	5257
9070	80	48	Poznámka k aktivitě Házet tenisákem a kopat do míče. Osooba: Jan Selinger	9002	5258
9071	35	35	Poznámka k aktivitě Tři míče a vybere a zakončí. Osooba: Jan Selinger	9002	5260
9072	75	30	Poznámka k aktivitě Lowa brace test. Osooba: Jan Selinger	9002	5261
9073	94	42	Poznámka k aktivitě Žebřík. Osooba: Jan Selinger	9002	5262
9074	42	33	Poznámka k aktivitě Slalom s míčem. Osooba: Jan Selinger	9002	5276
9075	90	44	Poznámka k aktivitě Skok daleký. Osooba: Jan Selinger	9002	5265
9076	60	\N	Poznámka k aktivitě slalom. Osooba: Jan Selinger	9002	5269
9077	29	31	Poznámka k aktivitě Výdrž ve sporu. Osooba: Jan Selinger	9002	5275
9078	90	30	Poznámka k aktivitě Hod pytlíkem do díry - San Simeon. Osooba: Jan Selinger	9002	5274
9079	60	41	Poznámka k aktivitě Kliky. Osooba: Luděk Rous	9003	5266
9080	80	38	Poznámka k aktivitě Dřepy. Osooba: Luděk Rous	9003	6701
9081	45	46	Poznámka k aktivitě Kliky. Osooba: Jan Selinger	9004	5266
9082	82	47	Poznámka k aktivitě Dřepy. Osooba: Jan Selinger	9004	6701
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
6801	Test dřepy a kliky	2018-11-29 15:06:52.696	\N	\N	\N
\.


--
-- TOC entry 3006 (class 0 OID 60620)
-- Dependencies: 221
-- Data for Name: event_attached_persons; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_attached_persons (events_id, attached_persons_id) FROM stdin;
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
6801	6528
6801	6401
6801	6529
6801	6402
6801	6530
6801	6403
6801	6531
6801	6404
6801	6532
6801	6405
6801	6533
6801	6406
6801	6534
6801	6407
6801	6535
6801	6408
6801	6536
6801	6409
6801	6537
6801	6410
6801	6538
6801	6411
6801	6412
6801	6413
6801	6414
6801	6415
6801	6416
6801	6417
6801	6418
6801	6419
6801	6420
6801	6421
6801	6422
6801	6423
6801	6424
6801	6425
6801	6426
6801	6427
6801	6428
6801	6429
6801	6430
6801	6431
6801	6432
6801	6433
6801	6434
6801	6435
6801	6436
6801	6437
6801	6438
6801	6439
6801	6440
6801	6441
6801	6442
6801	6443
6801	6444
6801	6445
6801	6446
6801	6447
6801	6448
6801	6449
6801	6450
6801	6501
6801	6502
6801	6503
6801	6504
6801	6505
6801	6506
6801	6507
6801	6508
6801	6509
6801	6510
6801	6511
6801	6512
6801	6513
6801	6514
6801	6515
6801	6516
6801	6517
6801	6518
6801	6519
6801	6520
6801	6521
6801	6522
6801	6523
6801	6524
6801	6525
6801	6526
6801	6527
\.


--
-- TOC entry 2999 (class 0 OID 60471)
-- Dependencies: 214
-- Data for Name: event_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_result (id, note, actual_height_in_cm, actual_weight_in_kg, event_id, person_id) FROM stdin;
5701	\N	\N	\N	5501	2901
5702	\N	\N	\N	5501	2201
6551	\N	\N	\N	5501	6401
6552	\N	\N	\N	6801	6409
6553	\N	\N	\N	6801	6410
6554	\N	\N	\N	6801	6411
6555	\N	\N	\N	6801	6412
6556	\N	\N	\N	6801	6413
6557	\N	\N	\N	6801	6414
6558	\N	\N	\N	6801	6415
6559	\N	\N	\N	6801	6416
6560	\N	\N	\N	6801	6417
6561	\N	\N	\N	6801	6418
7101	\N	169	82	5501	6401
7102	\N	160	82	5501	6402
7103	\N	174	88	5501	6403
7104	\N	166	75	5501	6404
7105	\N	178	75	5501	6405
7106	\N	174	81	5501	6406
7107	\N	170	75	5501	6407
7108	\N	163	75	5501	6408
7109	\N	185	84	5501	6409
7110	\N	166	78	5501	6410
7111	\N	175	88	5501	6411
7112	\N	163	79	5501	6412
7113	\N	178	76	5501	6413
7114	\N	177	78	5501	6414
7115	\N	169	85	5501	6415
7116	\N	176	79	5501	6416
7117	\N	172	89	5501	6417
7118	\N	184	78	5501	6418
7119	\N	162	85	5501	6419
7120	\N	168	78	5501	6420
7121	\N	184	75	5501	6421
7122	\N	173	89	5501	6422
7123	\N	174	87	5501	6423
7124	\N	172	89	5501	6424
7125	\N	177	76	5501	6425
7126	\N	161	86	5501	6426
7127	\N	186	85	5501	6427
7128	\N	176	77	5501	6428
7129	\N	185	75	5501	6429
7130	\N	166	88	5501	6430
7131	\N	170	77	5501	6431
7132	\N	189	87	5501	6432
7133	\N	181	78	5501	6433
7134	\N	183	82	5501	6434
7135	\N	177	76	5501	6435
7136	\N	172	76	5501	6436
7137	\N	169	80	5501	6437
7138	\N	173	85	5501	6438
7139	\N	167	87	5501	6439
7140	\N	162	79	5501	6440
7141	\N	181	83	5501	6441
7142	\N	173	86	5501	6442
7143	\N	170	90	5501	6443
7144	\N	188	87	5501	6444
7145	\N	162	87	5501	6445
7146	\N	170	84	5501	6446
7147	\N	163	87	5501	6447
7148	\N	163	88	5501	6448
7149	\N	164	83	5501	6449
7150	\N	166	88	5501	6450
7901	\N	173	88	5501	6501
7902	\N	184	88	5501	6502
7903	\N	164	84	5501	6503
7904	\N	163	78	5501	6504
7905	\N	187	87	5501	6505
7906	\N	181	84	5501	6506
7907	\N	174	78	5501	6507
7908	\N	180	83	5501	6508
7909	\N	173	84	5501	6509
7910	\N	160	77	5501	6510
7911	\N	185	85	5501	6511
7912	\N	168	89	5501	6512
7913	\N	166	88	5501	6513
7914	\N	178	79	5501	6514
7915	\N	168	75	5501	6515
7916	\N	190	80	5501	6516
7917	\N	189	79	5501	6517
7918	\N	167	87	5501	6518
7919	\N	186	83	5501	6519
7920	\N	183	83	5501	6520
7921	\N	190	89	5501	6521
7922	\N	182	90	5501	6522
7923	\N	180	80	5501	6523
7924	\N	173	78	5501	6524
7925	\N	170	90	5501	6525
7926	\N	161	85	5501	6526
7927	\N	163	87	5501	6527
7928	\N	174	87	5501	6528
7929	\N	174	85	5501	6529
7930	\N	164	86	5501	6530
7931	\N	190	88	5501	6531
7932	\N	168	75	5501	6532
7933	\N	176	83	5501	6533
7934	\N	165	84	5501	6534
7935	\N	177	89	5501	6535
7936	\N	180	87	5501	6536
7937	\N	173	81	5501	6537
7938	\N	175	82	5501	6538
7939	\N	170	89	6801	6401
7940	\N	188	83	6801	6402
7941	\N	181	77	6801	6403
7942	\N	186	83	6801	6404
7943	\N	179	79	6801	6405
7944	\N	171	87	6801	6406
7945	\N	167	89	6801	6407
7946	\N	185	75	6801	6408
7947	\N	173	77	6801	6409
7948	\N	176	84	6801	6410
7949	\N	170	90	6801	6411
7950	\N	184	82	6801	6412
8601	\N	166	87	6801	6413
8602	\N	161	88	6801	6414
8603	\N	171	87	6801	6415
8604	\N	183	83	6801	6416
8605	\N	181	88	6801	6417
8606	\N	185	80	6801	6418
8607	\N	187	87	6801	6419
8608	\N	179	87	6801	6420
8609	\N	190	77	6801	6421
8610	\N	186	86	6801	6422
8611	\N	189	90	6801	6423
8612	\N	171	90	6801	6424
8613	\N	179	82	6801	6425
8614	\N	167	88	6801	6426
8615	\N	179	78	6801	6427
8616	\N	189	80	6801	6428
8617	\N	180	82	6801	6429
8618	\N	188	83	6801	6430
8619	\N	171	88	6801	6431
8620	\N	165	83	6801	6432
8621	\N	179	84	6801	6433
8622	\N	187	80	6801	6434
8623	\N	164	78	6801	6435
8624	\N	160	82	6801	6436
8625	\N	172	87	6801	6437
8626	\N	175	80	6801	6438
8627	\N	184	77	6801	6439
8628	\N	182	86	6801	6440
8629	\N	178	85	6801	6441
8630	\N	171	85	6801	6442
8631	\N	173	81	6801	6443
8632	\N	180	81	6801	6444
8633	\N	184	76	6801	6445
8634	\N	180	90	6801	6446
8635	\N	164	83	6801	6447
8636	\N	170	78	6801	6448
8637	\N	170	84	6801	6449
8638	\N	167	75	6801	6450
8639	\N	174	87	6801	6501
8640	\N	166	90	6801	6502
8641	\N	169	82	6801	6503
8642	\N	161	85	6801	6504
8643	\N	168	79	6801	6505
8644	\N	189	80	6801	6506
8645	\N	174	86	6801	6507
8646	\N	183	86	6801	6508
8647	\N	184	79	6801	6509
8648	\N	164	88	6801	6510
8649	\N	172	86	6801	6511
8650	\N	187	84	6801	6512
8801	\N	162	84	6801	6513
8802	\N	179	78	6801	6514
8803	\N	185	85	6801	6515
8804	\N	162	90	6801	6516
8805	\N	177	85	6801	6517
8806	\N	171	88	6801	6518
8807	\N	182	75	6801	6519
8808	\N	183	89	6801	6520
8809	\N	189	75	6801	6521
8810	\N	166	76	6801	6522
8811	\N	163	87	6801	6523
8812	\N	160	84	6801	6524
8813	\N	169	85	6801	6525
8814	\N	186	85	6801	6526
8815	\N	162	75	6801	6527
8816	\N	162	83	6801	6528
8817	\N	186	78	6801	6529
8818	\N	184	87	6801	6530
8819	\N	178	82	6801	6531
8820	\N	179	90	6801	6532
8821	\N	186	80	6801	6533
8822	\N	171	89	6801	6534
8823	\N	169	77	6801	6535
8824	\N	165	87	6801	6536
8825	\N	183	83	6801	6537
8826	\N	188	78	6801	6538
8951	\N	185	84	5501	2201
8952	\N	163	82	5501	2901
8953	\N	179	83	6801	2201
8954	\N	160	77	6801	2901
\.


--
-- TOC entry 2990 (class 0 OID 60414)
-- Dependencies: 205
-- Data for Name: event_tests; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_tests (tests_id, events_id) FROM stdin;
5451	5501
6751	6801
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
2201	2151	2101	2351	rousludek@gmail.com	f
2901	2851	2801	\N	seli@vocas.cz	f
6401	6351	\N	\N	6-0@virtual.virtual	t
6402	6352	\N	\N	6-1@virtual.virtual	t
6403	6353	\N	\N	7-0@virtual.virtual	t
6404	6354	\N	\N	7-1@virtual.virtual	t
6405	6355	\N	\N	8-0@virtual.virtual	t
6406	6356	\N	\N	8-1@virtual.virtual	t
6407	6357	\N	\N	9-0@virtual.virtual	t
6408	6358	\N	\N	9-1@virtual.virtual	t
6409	6359	\N	\N	10-0@virtual.virtual	t
6410	6360	\N	\N	10-1@virtual.virtual	t
6411	6361	\N	\N	11-0@virtual.virtual	t
6412	6362	\N	\N	11-1@virtual.virtual	t
6413	6363	\N	\N	12-0@virtual.virtual	t
6414	6364	\N	\N	12-1@virtual.virtual	t
6415	6365	\N	\N	13-0@virtual.virtual	t
6416	6366	\N	\N	13-1@virtual.virtual	t
6417	6367	\N	\N	14-0@virtual.virtual	t
6418	6368	\N	\N	14-1@virtual.virtual	t
6419	6369	\N	\N	15-0@virtual.virtual	t
6420	6370	\N	\N	15-1@virtual.virtual	t
6421	6371	\N	\N	16-0@virtual.virtual	t
6422	6372	\N	\N	16-1@virtual.virtual	t
6423	6373	\N	\N	17-0@virtual.virtual	t
6424	6374	\N	\N	17-1@virtual.virtual	t
6425	6375	\N	\N	18-0@virtual.virtual	t
6426	6376	\N	\N	18-1@virtual.virtual	t
6427	6377	\N	\N	19-0@virtual.virtual	t
6428	6378	\N	\N	19-1@virtual.virtual	t
6429	6379	\N	\N	20-0@virtual.virtual	t
6430	6380	\N	\N	20-1@virtual.virtual	t
6431	6381	\N	\N	21-0@virtual.virtual	t
6432	6382	\N	\N	21-1@virtual.virtual	t
6433	6383	\N	\N	22-0@virtual.virtual	t
6434	6384	\N	\N	22-1@virtual.virtual	t
6435	6385	\N	\N	23-0@virtual.virtual	t
6436	6386	\N	\N	23-1@virtual.virtual	t
6437	6387	\N	\N	24-0@virtual.virtual	t
6438	6388	\N	\N	24-1@virtual.virtual	t
6439	6389	\N	\N	25-0@virtual.virtual	t
6440	6390	\N	\N	25-1@virtual.virtual	t
6441	6391	\N	\N	26-0@virtual.virtual	t
6442	6392	\N	\N	26-1@virtual.virtual	t
6443	6393	\N	\N	27-0@virtual.virtual	t
6444	6394	\N	\N	27-1@virtual.virtual	t
6445	6395	\N	\N	28-0@virtual.virtual	t
6446	6396	\N	\N	28-1@virtual.virtual	t
6447	6397	\N	\N	29-0@virtual.virtual	t
6448	6398	\N	\N	29-1@virtual.virtual	t
6449	6399	\N	\N	30-0@virtual.virtual	t
6450	6400	\N	\N	30-1@virtual.virtual	t
6501	6451	\N	\N	31-0@virtual.virtual	t
6502	6452	\N	\N	31-1@virtual.virtual	t
6503	6453	\N	\N	32-0@virtual.virtual	t
6504	6454	\N	\N	32-1@virtual.virtual	t
6505	6455	\N	\N	33-0@virtual.virtual	t
6506	6456	\N	\N	33-1@virtual.virtual	t
6507	6457	\N	\N	34-0@virtual.virtual	t
6508	6458	\N	\N	34-1@virtual.virtual	t
6509	6459	\N	\N	35-0@virtual.virtual	t
6510	6460	\N	\N	35-1@virtual.virtual	t
6511	6461	\N	\N	36-0@virtual.virtual	t
6512	6462	\N	\N	36-1@virtual.virtual	t
6513	6463	\N	\N	37-0@virtual.virtual	t
6514	6464	\N	\N	37-1@virtual.virtual	t
6515	6465	\N	\N	38-0@virtual.virtual	t
6516	6466	\N	\N	38-1@virtual.virtual	t
6517	6467	\N	\N	39-0@virtual.virtual	t
6518	6468	\N	\N	39-1@virtual.virtual	t
6519	6469	\N	\N	40-0@virtual.virtual	t
6520	6470	\N	\N	40-1@virtual.virtual	t
6521	6471	\N	\N	41-0@virtual.virtual	t
6522	6472	\N	\N	41-1@virtual.virtual	t
6523	6473	\N	\N	42-0@virtual.virtual	t
6524	6474	\N	\N	42-1@virtual.virtual	t
6525	6475	\N	\N	43-0@virtual.virtual	t
6526	6476	\N	\N	43-1@virtual.virtual	t
6527	6477	\N	\N	44-0@virtual.virtual	t
6528	6478	\N	\N	44-1@virtual.virtual	t
6529	6479	\N	\N	45-0@virtual.virtual	t
6530	6480	\N	\N	45-1@virtual.virtual	t
6531	6481	\N	\N	46-0@virtual.virtual	t
6532	6482	\N	\N	46-1@virtual.virtual	t
6533	6483	\N	\N	47-0@virtual.virtual	t
6534	6484	\N	\N	47-1@virtual.virtual	t
6535	6485	\N	\N	48-0@virtual.virtual	t
6536	6486	\N	\N	48-1@virtual.virtual	t
6537	6487	\N	\N	49-0@virtual.virtual	t
6538	6488	\N	\N	49-1@virtual.virtual	t
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
7193	Poznámka k testu Test obecný 1 6-12. Osooba: 27 let úroveň 0	7143	5451
7194	Poznámka k testu Test obecný 1 6-12. Osooba: 27 let úroveň 1	7144	5451
7195	Poznámka k testu Test obecný 1 6-12. Osooba: 28 let úroveň 0	7145	5451
7196	Poznámka k testu Test obecný 1 6-12. Osooba: 28 let úroveň 1	7146	5451
7197	Poznámka k testu Test obecný 1 6-12. Osooba: 29 let úroveň 0	7147	5451
7198	Poznámka k testu Test obecný 1 6-12. Osooba: 29 let úroveň 1	7148	5451
7199	Poznámka k testu Test obecný 1 6-12. Osooba: 30 let úroveň 0	7149	5451
5751	\N	5701	5451
5752	\N	5702	5451
6601	\N	6551	5451
6602	\N	6552	6751
6603	\N	6553	6751
6604	\N	6554	6751
6605	\N	6555	6751
6606	\N	6556	6751
6607	\N	6557	6751
6608	\N	6558	6751
6609	\N	6559	6751
6610	\N	6560	6751
6611	\N	6561	6751
7151	Poznámka k testu Test obecný 1 6-12. Osooba: 6 let úroveň 0	7101	5451
7152	Poznámka k testu Test obecný 1 6-12. Osooba: 6 let úroveň 1	7102	5451
7153	Poznámka k testu Test obecný 1 6-12. Osooba: 7 let úroveň 0	7103	5451
7154	Poznámka k testu Test obecný 1 6-12. Osooba: 7 let úroveň 1	7104	5451
7155	Poznámka k testu Test obecný 1 6-12. Osooba: 8 let úroveň 0	7105	5451
7156	Poznámka k testu Test obecný 1 6-12. Osooba: 8 let úroveň 1	7106	5451
7157	Poznámka k testu Test obecný 1 6-12. Osooba: 9 let úroveň 0	7107	5451
7158	Poznámka k testu Test obecný 1 6-12. Osooba: 9 let úroveň 1	7108	5451
7159	Poznámka k testu Test obecný 1 6-12. Osooba: 10 let úroveň 0	7109	5451
7160	Poznámka k testu Test obecný 1 6-12. Osooba: 10 let úroveň 1	7110	5451
7161	Poznámka k testu Test obecný 1 6-12. Osooba: 11 let úroveň 0	7111	5451
7162	Poznámka k testu Test obecný 1 6-12. Osooba: 11 let úroveň 1	7112	5451
7163	Poznámka k testu Test obecný 1 6-12. Osooba: 12 let úroveň 0	7113	5451
7164	Poznámka k testu Test obecný 1 6-12. Osooba: 12 let úroveň 1	7114	5451
7165	Poznámka k testu Test obecný 1 6-12. Osooba: 13 let úroveň 0	7115	5451
7166	Poznámka k testu Test obecný 1 6-12. Osooba: 13 let úroveň 1	7116	5451
7167	Poznámka k testu Test obecný 1 6-12. Osooba: 14 let úroveň 0	7117	5451
7168	Poznámka k testu Test obecný 1 6-12. Osooba: 14 let úroveň 1	7118	5451
7169	Poznámka k testu Test obecný 1 6-12. Osooba: 15 let úroveň 0	7119	5451
7170	Poznámka k testu Test obecný 1 6-12. Osooba: 15 let úroveň 1	7120	5451
7171	Poznámka k testu Test obecný 1 6-12. Osooba: 16 let úroveň 0	7121	5451
7172	Poznámka k testu Test obecný 1 6-12. Osooba: 16 let úroveň 1	7122	5451
7173	Poznámka k testu Test obecný 1 6-12. Osooba: 17 let úroveň 0	7123	5451
7174	Poznámka k testu Test obecný 1 6-12. Osooba: 17 let úroveň 1	7124	5451
7175	Poznámka k testu Test obecný 1 6-12. Osooba: 18 let úroveň 0	7125	5451
7176	Poznámka k testu Test obecný 1 6-12. Osooba: 18 let úroveň 1	7126	5451
7177	Poznámka k testu Test obecný 1 6-12. Osooba: 19 let úroveň 0	7127	5451
7178	Poznámka k testu Test obecný 1 6-12. Osooba: 19 let úroveň 1	7128	5451
7179	Poznámka k testu Test obecný 1 6-12. Osooba: 20 let úroveň 0	7129	5451
7180	Poznámka k testu Test obecný 1 6-12. Osooba: 20 let úroveň 1	7130	5451
7181	Poznámka k testu Test obecný 1 6-12. Osooba: 21 let úroveň 0	7131	5451
7182	Poznámka k testu Test obecný 1 6-12. Osooba: 21 let úroveň 1	7132	5451
7183	Poznámka k testu Test obecný 1 6-12. Osooba: 22 let úroveň 0	7133	5451
7184	Poznámka k testu Test obecný 1 6-12. Osooba: 22 let úroveň 1	7134	5451
7185	Poznámka k testu Test obecný 1 6-12. Osooba: 23 let úroveň 0	7135	5451
7186	Poznámka k testu Test obecný 1 6-12. Osooba: 23 let úroveň 1	7136	5451
7187	Poznámka k testu Test obecný 1 6-12. Osooba: 24 let úroveň 0	7137	5451
7188	Poznámka k testu Test obecný 1 6-12. Osooba: 24 let úroveň 1	7138	5451
7189	Poznámka k testu Test obecný 1 6-12. Osooba: 25 let úroveň 0	7139	5451
7190	Poznámka k testu Test obecný 1 6-12. Osooba: 25 let úroveň 1	7140	5451
7191	Poznámka k testu Test obecný 1 6-12. Osooba: 26 let úroveň 0	7141	5451
7192	Poznámka k testu Test obecný 1 6-12. Osooba: 26 let úroveň 1	7142	5451
7200	Poznámka k testu Test obecný 1 6-12. Osooba: 30 let úroveň 1	7150	5451
7951	Poznámka k testu Test obecný 1 6-12. Osooba: 31 let úroveň 0	7901	5451
7952	Poznámka k testu Test obecný 1 6-12. Osooba: 31 let úroveň 1	7902	5451
7953	Poznámka k testu Test obecný 1 6-12. Osooba: 32 let úroveň 0	7903	5451
7954	Poznámka k testu Test obecný 1 6-12. Osooba: 32 let úroveň 1	7904	5451
7955	Poznámka k testu Test obecný 1 6-12. Osooba: 33 let úroveň 0	7905	5451
7956	Poznámka k testu Test obecný 1 6-12. Osooba: 33 let úroveň 1	7906	5451
7957	Poznámka k testu Test obecný 1 6-12. Osooba: 34 let úroveň 0	7907	5451
7958	Poznámka k testu Test obecný 1 6-12. Osooba: 34 let úroveň 1	7908	5451
7959	Poznámka k testu Test obecný 1 6-12. Osooba: 35 let úroveň 0	7909	5451
7960	Poznámka k testu Test obecný 1 6-12. Osooba: 35 let úroveň 1	7910	5451
7961	Poznámka k testu Test obecný 1 6-12. Osooba: 36 let úroveň 0	7911	5451
7962	Poznámka k testu Test obecný 1 6-12. Osooba: 36 let úroveň 1	7912	5451
7963	Poznámka k testu Test obecný 1 6-12. Osooba: 37 let úroveň 0	7913	5451
7964	Poznámka k testu Test obecný 1 6-12. Osooba: 37 let úroveň 1	7914	5451
7965	Poznámka k testu Test obecný 1 6-12. Osooba: 38 let úroveň 0	7915	5451
7966	Poznámka k testu Test obecný 1 6-12. Osooba: 38 let úroveň 1	7916	5451
7967	Poznámka k testu Test obecný 1 6-12. Osooba: 39 let úroveň 0	7917	5451
7968	Poznámka k testu Test obecný 1 6-12. Osooba: 39 let úroveň 1	7918	5451
7969	Poznámka k testu Test obecný 1 6-12. Osooba: 40 let úroveň 0	7919	5451
7970	Poznámka k testu Test obecný 1 6-12. Osooba: 40 let úroveň 1	7920	5451
7971	Poznámka k testu Test obecný 1 6-12. Osooba: 41 let úroveň 0	7921	5451
7972	Poznámka k testu Test obecný 1 6-12. Osooba: 41 let úroveň 1	7922	5451
7973	Poznámka k testu Test obecný 1 6-12. Osooba: 42 let úroveň 0	7923	5451
7974	Poznámka k testu Test obecný 1 6-12. Osooba: 42 let úroveň 1	7924	5451
7975	Poznámka k testu Test obecný 1 6-12. Osooba: 43 let úroveň 0	7925	5451
7976	Poznámka k testu Test obecný 1 6-12. Osooba: 43 let úroveň 1	7926	5451
7977	Poznámka k testu Test obecný 1 6-12. Osooba: 44 let úroveň 0	7927	5451
7978	Poznámka k testu Test obecný 1 6-12. Osooba: 44 let úroveň 1	7928	5451
7979	Poznámka k testu Test obecný 1 6-12. Osooba: 45 let úroveň 0	7929	5451
7980	Poznámka k testu Test obecný 1 6-12. Osooba: 45 let úroveň 1	7930	5451
7981	Poznámka k testu Test obecný 1 6-12. Osooba: 46 let úroveň 0	7931	5451
7982	Poznámka k testu Test obecný 1 6-12. Osooba: 46 let úroveň 1	7932	5451
7983	Poznámka k testu Test obecný 1 6-12. Osooba: 47 let úroveň 0	7933	5451
7984	Poznámka k testu Test obecný 1 6-12. Osooba: 47 let úroveň 1	7934	5451
7985	Poznámka k testu Test obecný 1 6-12. Osooba: 48 let úroveň 0	7935	5451
7986	Poznámka k testu Test obecný 1 6-12. Osooba: 48 let úroveň 1	7936	5451
7987	Poznámka k testu Test obecný 1 6-12. Osooba: 49 let úroveň 0	7937	5451
7988	Poznámka k testu Test obecný 1 6-12. Osooba: 49 let úroveň 1	7938	5451
7989	Poznámka k testu Test dřepy a kliky. Osooba: 6 let úroveň 0	7939	6751
7990	Poznámka k testu Test dřepy a kliky. Osooba: 6 let úroveň 1	7940	6751
7991	Poznámka k testu Test dřepy a kliky. Osooba: 7 let úroveň 0	7941	6751
7992	Poznámka k testu Test dřepy a kliky. Osooba: 7 let úroveň 1	7942	6751
7993	Poznámka k testu Test dřepy a kliky. Osooba: 8 let úroveň 0	7943	6751
7994	Poznámka k testu Test dřepy a kliky. Osooba: 8 let úroveň 1	7944	6751
7995	Poznámka k testu Test dřepy a kliky. Osooba: 9 let úroveň 0	7945	6751
7996	Poznámka k testu Test dřepy a kliky. Osooba: 9 let úroveň 1	7946	6751
7997	Poznámka k testu Test dřepy a kliky. Osooba: 10 let úroveň 0	7947	6751
7998	Poznámka k testu Test dřepy a kliky. Osooba: 10 let úroveň 1	7948	6751
7999	Poznámka k testu Test dřepy a kliky. Osooba: 11 let úroveň 0	7949	6751
8000	Poznámka k testu Test dřepy a kliky. Osooba: 11 let úroveň 1	7950	6751
8651	Poznámka k testu Test dřepy a kliky. Osooba: 12 let úroveň 0	8601	6751
8652	Poznámka k testu Test dřepy a kliky. Osooba: 12 let úroveň 1	8602	6751
8653	Poznámka k testu Test dřepy a kliky. Osooba: 13 let úroveň 0	8603	6751
8654	Poznámka k testu Test dřepy a kliky. Osooba: 13 let úroveň 1	8604	6751
8655	Poznámka k testu Test dřepy a kliky. Osooba: 14 let úroveň 0	8605	6751
8656	Poznámka k testu Test dřepy a kliky. Osooba: 14 let úroveň 1	8606	6751
8657	Poznámka k testu Test dřepy a kliky. Osooba: 15 let úroveň 0	8607	6751
8658	Poznámka k testu Test dřepy a kliky. Osooba: 15 let úroveň 1	8608	6751
8659	Poznámka k testu Test dřepy a kliky. Osooba: 16 let úroveň 0	8609	6751
8660	Poznámka k testu Test dřepy a kliky. Osooba: 16 let úroveň 1	8610	6751
8661	Poznámka k testu Test dřepy a kliky. Osooba: 17 let úroveň 0	8611	6751
8662	Poznámka k testu Test dřepy a kliky. Osooba: 17 let úroveň 1	8612	6751
8663	Poznámka k testu Test dřepy a kliky. Osooba: 18 let úroveň 0	8613	6751
8664	Poznámka k testu Test dřepy a kliky. Osooba: 18 let úroveň 1	8614	6751
8665	Poznámka k testu Test dřepy a kliky. Osooba: 19 let úroveň 0	8615	6751
8666	Poznámka k testu Test dřepy a kliky. Osooba: 19 let úroveň 1	8616	6751
8667	Poznámka k testu Test dřepy a kliky. Osooba: 20 let úroveň 0	8617	6751
8668	Poznámka k testu Test dřepy a kliky. Osooba: 20 let úroveň 1	8618	6751
8669	Poznámka k testu Test dřepy a kliky. Osooba: 21 let úroveň 0	8619	6751
8670	Poznámka k testu Test dřepy a kliky. Osooba: 21 let úroveň 1	8620	6751
8671	Poznámka k testu Test dřepy a kliky. Osooba: 22 let úroveň 0	8621	6751
8672	Poznámka k testu Test dřepy a kliky. Osooba: 22 let úroveň 1	8622	6751
8673	Poznámka k testu Test dřepy a kliky. Osooba: 23 let úroveň 0	8623	6751
8674	Poznámka k testu Test dřepy a kliky. Osooba: 23 let úroveň 1	8624	6751
8675	Poznámka k testu Test dřepy a kliky. Osooba: 24 let úroveň 0	8625	6751
8676	Poznámka k testu Test dřepy a kliky. Osooba: 24 let úroveň 1	8626	6751
8677	Poznámka k testu Test dřepy a kliky. Osooba: 25 let úroveň 0	8627	6751
8678	Poznámka k testu Test dřepy a kliky. Osooba: 25 let úroveň 1	8628	6751
8679	Poznámka k testu Test dřepy a kliky. Osooba: 26 let úroveň 0	8629	6751
8680	Poznámka k testu Test dřepy a kliky. Osooba: 26 let úroveň 1	8630	6751
8681	Poznámka k testu Test dřepy a kliky. Osooba: 27 let úroveň 0	8631	6751
8682	Poznámka k testu Test dřepy a kliky. Osooba: 27 let úroveň 1	8632	6751
8683	Poznámka k testu Test dřepy a kliky. Osooba: 28 let úroveň 0	8633	6751
8684	Poznámka k testu Test dřepy a kliky. Osooba: 28 let úroveň 1	8634	6751
8685	Poznámka k testu Test dřepy a kliky. Osooba: 29 let úroveň 0	8635	6751
8686	Poznámka k testu Test dřepy a kliky. Osooba: 29 let úroveň 1	8636	6751
8687	Poznámka k testu Test dřepy a kliky. Osooba: 30 let úroveň 0	8637	6751
8688	Poznámka k testu Test dřepy a kliky. Osooba: 30 let úroveň 1	8638	6751
8689	Poznámka k testu Test dřepy a kliky. Osooba: 31 let úroveň 0	8639	6751
8690	Poznámka k testu Test dřepy a kliky. Osooba: 31 let úroveň 1	8640	6751
8691	Poznámka k testu Test dřepy a kliky. Osooba: 32 let úroveň 0	8641	6751
8692	Poznámka k testu Test dřepy a kliky. Osooba: 32 let úroveň 1	8642	6751
8693	Poznámka k testu Test dřepy a kliky. Osooba: 33 let úroveň 0	8643	6751
8694	Poznámka k testu Test dřepy a kliky. Osooba: 33 let úroveň 1	8644	6751
8695	Poznámka k testu Test dřepy a kliky. Osooba: 34 let úroveň 0	8645	6751
8696	Poznámka k testu Test dřepy a kliky. Osooba: 34 let úroveň 1	8646	6751
8697	Poznámka k testu Test dřepy a kliky. Osooba: 35 let úroveň 0	8647	6751
8698	Poznámka k testu Test dřepy a kliky. Osooba: 35 let úroveň 1	8648	6751
8699	Poznámka k testu Test dřepy a kliky. Osooba: 36 let úroveň 0	8649	6751
8700	Poznámka k testu Test dřepy a kliky. Osooba: 36 let úroveň 1	8650	6751
8851	Poznámka k testu Test dřepy a kliky. Osooba: 37 let úroveň 0	8801	6751
8852	Poznámka k testu Test dřepy a kliky. Osooba: 37 let úroveň 1	8802	6751
8853	Poznámka k testu Test dřepy a kliky. Osooba: 38 let úroveň 0	8803	6751
8854	Poznámka k testu Test dřepy a kliky. Osooba: 38 let úroveň 1	8804	6751
8855	Poznámka k testu Test dřepy a kliky. Osooba: 39 let úroveň 0	8805	6751
8856	Poznámka k testu Test dřepy a kliky. Osooba: 39 let úroveň 1	8806	6751
8857	Poznámka k testu Test dřepy a kliky. Osooba: 40 let úroveň 0	8807	6751
8858	Poznámka k testu Test dřepy a kliky. Osooba: 40 let úroveň 1	8808	6751
8859	Poznámka k testu Test dřepy a kliky. Osooba: 41 let úroveň 0	8809	6751
8860	Poznámka k testu Test dřepy a kliky. Osooba: 41 let úroveň 1	8810	6751
8861	Poznámka k testu Test dřepy a kliky. Osooba: 42 let úroveň 0	8811	6751
8862	Poznámka k testu Test dřepy a kliky. Osooba: 42 let úroveň 1	8812	6751
8863	Poznámka k testu Test dřepy a kliky. Osooba: 43 let úroveň 0	8813	6751
8864	Poznámka k testu Test dřepy a kliky. Osooba: 43 let úroveň 1	8814	6751
8865	Poznámka k testu Test dřepy a kliky. Osooba: 44 let úroveň 0	8815	6751
8866	Poznámka k testu Test dřepy a kliky. Osooba: 44 let úroveň 1	8816	6751
8867	Poznámka k testu Test dřepy a kliky. Osooba: 45 let úroveň 0	8817	6751
8868	Poznámka k testu Test dřepy a kliky. Osooba: 45 let úroveň 1	8818	6751
8869	Poznámka k testu Test dřepy a kliky. Osooba: 46 let úroveň 0	8819	6751
8870	Poznámka k testu Test dřepy a kliky. Osooba: 46 let úroveň 1	8820	6751
8871	Poznámka k testu Test dřepy a kliky. Osooba: 47 let úroveň 0	8821	6751
8872	Poznámka k testu Test dřepy a kliky. Osooba: 47 let úroveň 1	8822	6751
8873	Poznámka k testu Test dřepy a kliky. Osooba: 48 let úroveň 0	8823	6751
8874	Poznámka k testu Test dřepy a kliky. Osooba: 48 let úroveň 1	8824	6751
8875	Poznámka k testu Test dřepy a kliky. Osooba: 49 let úroveň 0	8825	6751
8876	Poznámka k testu Test dřepy a kliky. Osooba: 49 let úroveň 1	8826	6751
9001	Poznámka k testu Test obecný 1 6-12. Osooba: Luděk Rous	8951	5451
9002	Poznámka k testu Test obecný 1 6-12. Osooba: Jan Selinger	8952	5451
9003	Poznámka k testu Test dřepy a kliky. Osooba: Luděk Rous	8953	6751
9004	Poznámka k testu Test dřepy a kliky. Osooba: Jan Selinger	8954	6751
\.


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 198
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: jt-testing
--

SELECT pg_catalog.setval('hibernate_sequence', 9100, true);


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


-- Completed on 2018-12-05 14:09:36

--
-- PostgreSQL database dump complete
--

