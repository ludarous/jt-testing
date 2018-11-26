--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.1

-- Started on 2018-11-26 13:14:24

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
-- TOC entry 3012 (class 0 OID 0)
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
    description character varying(255)
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
    country character varying(255) NOT NULL,
    city character varying(255) NOT NULL,
    street character varying(255) NOT NULL,
    zip_code character varying(255) NOT NULL
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
    address_id bigint
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
    description character varying(255)
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
    email character varying(255) NOT NULL
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
-- TOC entry 2994 (class 0 OID 60442)
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
\.


--
-- TOC entry 2995 (class 0 OID 60450)
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
\.


--
-- TOC entry 2997 (class 0 OID 60463)
-- Dependencies: 213
-- Data for Name: activity_category; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity_category (id, name, jhi_key, description) FROM stdin;
5301	koordinace - test prostorové orientace	\N	\N
5302	koordinace - rovnováha - statická	\N	\N
5303	koordinace - rovnováha - dynamická	\N	\N
5304	koordinace - reakční	\N	\N
5305	koordinace - schopnost spojování pohybů	\N	\N
5306	koordinace - schopnost přizpůsobování	\N	\N
5307	koordinace - učenlivost	\N	\N
5308	koordinace - rytmická	\N	\N
5309	síla	\N	\N
5310	síla - dynamická	\N	\N
5311	rychlost	\N	\N
5312	vytrvalost	\N	\N
5313	pohyblivost	\N	\N
5314	dovednost	\N	\N
5315	s míčem	\N	\N
5316	koordinace - rozlišení polohy a pohybu jednotlivých čátsí těla	\N	\N
5317	core	\N	\N
5318	basketbal	\N	\N
\.


--
-- TOC entry 3000 (class 0 OID 60481)
-- Dependencies: 216
-- Data for Name: activity_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY activity_result (id, primary_result_value, secondary_result_value, note, test_result_id, activity_id) FROM stdin;
\.


--
-- TOC entry 3003 (class 0 OID 60503)
-- Dependencies: 219
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY address (id, country, city, street, zip_code) FROM stdin;
2101	Czech Republic	Plzeň	Spojovací 16	32600
2801	Czech Republic	Plzeň	Nevim	Nevim
\.


--
-- TOC entry 2981 (class 0 OID 60351)
-- Dependencies: 197
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
00000000000000	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:39.981088	1	EXECUTED	7:a6235f40597a13436aa36c6d61db2269	createSequence sequenceName=hibernate_sequence		\N	3.5.4	\N	\N	2093459943
00000000000001	jhipster	config/liquibase/changelog/00000000000000_initial_schema.xml	2018-11-13 08:17:40.044389	2	EXECUTED	7:ebc2000ab4a469430e5c638c4cf79aa2	createTable tableName=jhi_user; createTable tableName=jhi_authority; createTable tableName=jhi_user_authority; addPrimaryKey tableName=jhi_user_authority; addForeignKeyConstraint baseTableName=jhi_user_authority, constraintName=fk_authority_name, ...		\N	3.5.4	\N	\N	2093459943
20180919081349-1	jhipster	config/liquibase/changelog/20180919081349_added_entity_Event.xml	2018-11-13 08:17:40.055519	3	EXECUTED	7:e5038305fbd38914b161642650e71433	createTable tableName=event; dropDefaultValue columnName=jhi_date, tableName=event; createTable tableName=event_tests; addPrimaryKey tableName=event_tests		\N	3.5.4	\N	\N	2093459943
20180919081350-1	jhipster	config/liquibase/changelog/20180919081350_added_entity_JTTest.xml	2018-11-13 08:17:40.077001	4	EXECUTED	7:0648dc6f98e54c36da78f88f88d4179e	createTable tableName=jt_test; createTable tableName=jttest_activities; addPrimaryKey tableName=jttest_activities; createTable tableName=jttest_categories; addPrimaryKey tableName=jttest_categories; createTable tableName=jttest_sports; addPrimaryK...		\N	3.5.4	\N	\N	2093459943
20180919081351-1	jhipster	config/liquibase/changelog/20180919081351_added_entity_Activity.xml	2018-11-13 08:17:40.089369	5	EXECUTED	7:51a20693e822fc99843bc42875ebd530	createTable tableName=activity; createTable tableName=activity_categories; addPrimaryKey tableName=activity_categories		\N	3.5.4	\N	\N	2093459943
20180919081352-1	jhipster	config/liquibase/changelog/20180919081352_added_entity_TestCategory.xml	2018-11-13 08:17:40.097382	6	EXECUTED	7:209442ef19c7c22da10246fe370b38b0	createTable tableName=test_category		\N	3.5.4	\N	\N	2093459943
20180919081353-1	jhipster	config/liquibase/changelog/20180919081353_added_entity_ActivityCategory.xml	2018-11-13 08:17:40.108058	7	EXECUTED	7:f314cfb26cb50c7061bef53b28dc64ed	createTable tableName=activity_category		\N	3.5.4	\N	\N	2093459943
20180919081354-1	jhipster	config/liquibase/changelog/20180919081354_added_entity_EventResult.xml	2018-11-13 08:17:40.113721	8	EXECUTED	7:ebe4b30a347285f3c27e6149a38ebe37	createTable tableName=event_result		\N	3.5.4	\N	\N	2093459943
20180919081355-1	jhipster	config/liquibase/changelog/20180919081355_added_entity_TestResult.xml	2018-11-13 08:17:40.119662	9	EXECUTED	7:77a15fb38c878daf3cebd815691c8c88	createTable tableName=test_result		\N	3.5.4	\N	\N	2093459943
20180919081356-1	jhipster	config/liquibase/changelog/20180919081356_added_entity_ActivityResult.xml	2018-11-13 08:17:40.125061	10	EXECUTED	7:86e859787d3e65caa389eb92b8b4f024	createTable tableName=activity_result		\N	3.5.4	\N	\N	2093459943
20180919081357-1	jhipster	config/liquibase/changelog/20180919081357_added_entity_Person.xml	2018-11-13 08:17:40.13429	11	EXECUTED	7:e93b4d142509c4cc65e53f2143f9486d	createTable tableName=person		\N	3.5.4	\N	\N	2093459943
20180919081358-1	jhipster	config/liquibase/changelog/20180919081358_added_entity_PersonalData.xml	2018-11-13 08:17:40.142888	12	EXECUTED	7:7fa972ec1a3cb9d040b869b8404820c9	createTable tableName=personal_data; dropDefaultValue columnName=birth_date, tableName=personal_data		\N	3.5.4	\N	\N	2093459943
20180919081359-1	jhipster	config/liquibase/changelog/20180919081359_added_entity_Address.xml	2018-11-13 08:17:40.150992	13	EXECUTED	7:5a85d21c2275b818b1807d486fa43940	createTable tableName=address		\N	3.5.4	\N	\N	2093459943
20180919081400-1	jhipster	config/liquibase/changelog/20180919081400_added_entity_Sport.xml	2018-11-13 08:17:40.299031	14	EXECUTED	7:f52d0611a6f30a779a306d3fdd1f6efc	createTable tableName=sport		\N	3.5.4	\N	\N	2093459943
20180919081349-2	jhipster	config/liquibase/changelog/20180919081349_added_entity_constraints_Event.xml	2018-11-13 08:17:40.305196	15	EXECUTED	7:b8415974a3bbbee40af1be77144c73b8	addForeignKeyConstraint baseTableName=event, constraintName=fk_event_address_id, referencedTableName=address; addForeignKeyConstraint baseTableName=event_tests, constraintName=fk_event_tests_events_id, referencedTableName=event; addForeignKeyConst...		\N	3.5.4	\N	\N	2093459943
20180919081350-2	jhipster	config/liquibase/changelog/20180919081350_added_entity_constraints_JTTest.xml	2018-11-13 08:17:40.316289	16	EXECUTED	7:2aa590bc8418d96f1351379bfa642d38	addForeignKeyConstraint baseTableName=jttest_activities, constraintName=fk_jttest_activities_jttests_id, referencedTableName=jt_test; addForeignKeyConstraint baseTableName=jttest_activities, constraintName=fk_jttest_activities_activities_id, refer...		\N	3.5.4	\N	\N	2093459943
20180919081351-2	jhipster	config/liquibase/changelog/20180919081351_added_entity_constraints_Activity.xml	2018-11-13 08:17:40.322413	17	EXECUTED	7:2ae36c777c371f9c88083142ba5a1983	addForeignKeyConstraint baseTableName=activity_categories, constraintName=fk_activity_categories_activities_id, referencedTableName=activity; addForeignKeyConstraint baseTableName=activity_categories, constraintName=fk_activity_categories_categori...		\N	3.5.4	\N	\N	2093459943
20180919081354-2	jhipster	config/liquibase/changelog/20180919081354_added_entity_constraints_EventResult.xml	2018-11-13 08:17:40.32731	18	EXECUTED	7:d1d86da675c22daaa25d6083205be99b	addForeignKeyConstraint baseTableName=event_result, constraintName=fk_event_result_event_id, referencedTableName=event; addForeignKeyConstraint baseTableName=event_result, constraintName=fk_event_result_person_id, referencedTableName=person		\N	3.5.4	\N	\N	2093459943
20180919081355-2	jhipster	config/liquibase/changelog/20180919081355_added_entity_constraints_TestResult.xml	2018-11-13 08:17:40.332131	19	EXECUTED	7:f71ec1e25e29b2e087bfa73206b115c9	addForeignKeyConstraint baseTableName=test_result, constraintName=fk_test_result_event_result_id, referencedTableName=event_result; addForeignKeyConstraint baseTableName=test_result, constraintName=fk_test_result_test_id, referencedTableName=jt_test		\N	3.5.4	\N	\N	2093459943
20180919081356-2	jhipster	config/liquibase/changelog/20180919081356_added_entity_constraints_ActivityResult.xml	2018-11-13 08:17:40.336735	20	EXECUTED	7:b93d0e2b25de3af146ee96785ec72b02	addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_test_result_id, referencedTableName=test_result; addForeignKeyConstraint baseTableName=activity_result, constraintName=fk_activity_result_activity_id, referen...		\N	3.5.4	\N	\N	2093459943
20180919081357-2	jhipster	config/liquibase/changelog/20180919081357_added_entity_constraints_Person.xml	2018-11-13 08:17:40.340958	21	EXECUTED	7:6f22c18d852385929e915b70ccd0c175	addForeignKeyConstraint baseTableName=person, constraintName=fk_person_personal_data_id, referencedTableName=personal_data; addForeignKeyConstraint baseTableName=person, constraintName=fk_person_address_id, referencedTableName=address		\N	3.5.4	\N	\N	2093459943
1542094230696-1	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.044386	22	EXECUTED	7:8d217e9e99a9ac7683f596d22b7cff2b	addColumn tableName=person		\N	3.5.4	\N	\N	2094321018
1542094230696-2	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.053252	23	EXECUTED	7:5e841b60b47ff0aefc49a0b7da95ffb1	addUniqueConstraint constraintName=UC_PERSONUSER_ID_COL, tableName=person		\N	3.5.4	\N	\N	2094321018
1542094230696-3	RLU (generated)	config/liquibase/changelog/20181113073023_added_person_user_relation.xml	2018-11-13 08:32:01.058173	24	EXECUTED	7:90b485b8604f4e89b8f93ab068d21dab	addForeignKeyConstraint baseTableName=person, constraintName=FKe9y2rjb98wsg2nnk3eyrvc2ss, referencedTableName=jhi_user		\N	3.5.4	\N	\N	2094321018
1542203539812-1	RLU (generated)	config/liquibase/changelog/20181114135212_added_email_to_Person.xml	2018-11-14 14:57:36.771271	25	EXECUTED	7:938df0e4a12d451975ee6f637de0d637	addColumn tableName=person		\N	3.5.4	\N	\N	2203856737
1542293651906-1	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.275511	26	EXECUTED	7:6823dba0e68a6c865ef7afaa5967798e	createTable tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1542293651906-2	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.287102	27	EXECUTED	7:d0d9029f499101cf4d2906448bb5e5ff	addPrimaryKey tableName=event_attached_persons		\N	3.5.4	\N	\N	2293767209
1542293651906-3	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.2943	28	EXECUTED	7:701420cea947cf455ef06550bcfa0af5	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKcc1cq3mo95k6xp5duh287cfsv, referencedTableName=person		\N	3.5.4	\N	\N	2293767209
1542293651906-4	RLU (generated)	config/liquibase/changelog/20181115145404_added_event_person_relation.xml	2018-11-15 15:56:07.297943	29	EXECUTED	7:8734b0163166dd0e7edfc06c3acd980f	addForeignKeyConstraint baseTableName=event_attached_persons, constraintName=FKtlu2ktd0nahrhonnjrbjjrkwe, referencedTableName=event		\N	3.5.4	\N	\N	2293767209
\.


--
-- TOC entry 2980 (class 0 OID 60346)
-- Dependencies: 196
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- TOC entry 2988 (class 0 OID 60409)
-- Dependencies: 204
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event (id, name, jhi_date, address_id) FROM stdin;
\.


--
-- TOC entry 3005 (class 0 OID 60620)
-- Dependencies: 221
-- Data for Name: event_attached_persons; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_attached_persons (events_id, attached_persons_id) FROM stdin;
\.


--
-- TOC entry 2998 (class 0 OID 60471)
-- Dependencies: 214
-- Data for Name: event_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_result (id, note, actual_height_in_cm, actual_weight_in_kg, event_id, person_id) FROM stdin;
\.


--
-- TOC entry 2989 (class 0 OID 60414)
-- Dependencies: 205
-- Data for Name: event_tests; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY event_tests (tests_id, events_id) FROM stdin;
\.


--
-- TOC entry 2984 (class 0 OID 60372)
-- Dependencies: 200
-- Data for Name: jhi_authority; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jhi_authority (name) FROM stdin;
ROLE_ADMIN
ROLE_USER
\.


--
-- TOC entry 2986 (class 0 OID 60392)
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
\.


--
-- TOC entry 2987 (class 0 OID 60397)
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
-- TOC entry 2983 (class 0 OID 60359)
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
-- TOC entry 2985 (class 0 OID 60377)
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
-- TOC entry 2990 (class 0 OID 60419)
-- Dependencies: 206
-- Data for Name: jt_test; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jt_test (id, name, description) FROM stdin;
5451	Test obecný 1 6-12	\N
5452	Test obecný 1 13-15	\N
5453	Test obecný 1 15+	\N
5454	Test basketbal 6 - 10	\N
5455	Test basketbal 11 - 15	\N
5456	Test basketbal 15 +	\N
\.


--
-- TOC entry 2991 (class 0 OID 60427)
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
\.


--
-- TOC entry 2992 (class 0 OID 60432)
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
-- TOC entry 2993 (class 0 OID 60437)
-- Dependencies: 209
-- Data for Name: jttest_sports; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY jttest_sports (sports_id, jttests_id) FROM stdin;
\.


--
-- TOC entry 3001 (class 0 OID 60486)
-- Dependencies: 217
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY person (id, personal_data_id, address_id, user_id, email) FROM stdin;
2201	2151	2101	2351	rousludek@gmail.com
2901	2851	2801	\N	seli@vocas.cz
\.


--
-- TOC entry 3002 (class 0 OID 60495)
-- Dependencies: 218
-- Data for Name: personal_data; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY personal_data (id, first_name, last_name, birth_date, nationality) FROM stdin;
2151	Luděk	Rous	2018-11-14 16:27:11.288	cz
2851	Jan	Selinger	2018-11-16 14:04:58.205	cz
\.


--
-- TOC entry 3004 (class 0 OID 60511)
-- Dependencies: 220
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY sport (id, name) FROM stdin;
\.


--
-- TOC entry 2996 (class 0 OID 60455)
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
-- TOC entry 2999 (class 0 OID 60476)
-- Dependencies: 215
-- Data for Name: test_result; Type: TABLE DATA; Schema: public; Owner: jt-testing
--

COPY test_result (id, note, event_result_id, test_id) FROM stdin;
\.


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 198
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: jt-testing
--

SELECT pg_catalog.setval('hibernate_sequence', 5500, true);


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
-- TOC entry 2857 (class 2606 OID 60625)
-- Name: event_attached_persons FKcc1cq3mo95k6xp5duh287cfsv; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_attached_persons
    ADD CONSTRAINT "FKcc1cq3mo95k6xp5duh287cfsv" FOREIGN KEY (attached_persons_id) REFERENCES person(id);


--
-- TOC entry 2856 (class 2606 OID 60614)
-- Name: person FKe9y2rjb98wsg2nnk3eyrvc2ss; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT "FKe9y2rjb98wsg2nnk3eyrvc2ss" FOREIGN KEY (user_id) REFERENCES jhi_user(id);


--
-- TOC entry 2858 (class 2606 OID 60630)
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
-- TOC entry 2853 (class 2606 OID 60596)
-- Name: activity_result fk_activity_result_activity_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY activity_result
    ADD CONSTRAINT fk_activity_result_activity_id FOREIGN KEY (activity_id) REFERENCES activity(id);


--
-- TOC entry 2852 (class 2606 OID 60591)
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
-- TOC entry 2848 (class 2606 OID 60571)
-- Name: event_result fk_event_result_event_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY event_result
    ADD CONSTRAINT fk_event_result_event_id FOREIGN KEY (event_id) REFERENCES event(id);


--
-- TOC entry 2849 (class 2606 OID 60576)
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
-- TOC entry 2855 (class 2606 OID 60606)
-- Name: person fk_person_address_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fk_person_address_id FOREIGN KEY (address_id) REFERENCES address(id);


--
-- TOC entry 2854 (class 2606 OID 60601)
-- Name: person fk_person_personal_data_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY person
    ADD CONSTRAINT fk_person_personal_data_id FOREIGN KEY (personal_data_id) REFERENCES personal_data(id);


--
-- TOC entry 2850 (class 2606 OID 60581)
-- Name: test_result fk_test_result_event_result_id; Type: FK CONSTRAINT; Schema: public; Owner: jt-testing
--

ALTER TABLE ONLY test_result
    ADD CONSTRAINT fk_test_result_event_result_id FOREIGN KEY (event_result_id) REFERENCES event_result(id);


--
-- TOC entry 2851 (class 2606 OID 60586)
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


-- Completed on 2018-11-26 13:14:26

--
-- PostgreSQL database dump complete
--

