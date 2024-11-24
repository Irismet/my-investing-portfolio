--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO invest_user;

--
-- Name: brokers; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.brokers (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.brokers OWNER TO invest_user;

--
-- Name: brokers_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.brokers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brokers_id_seq OWNER TO invest_user;

--
-- Name: brokers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.brokers_id_seq OWNED BY public.brokers.id;


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.currencies (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.currencies OWNER TO invest_user;

--
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.currencies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.currencies_id_seq OWNER TO invest_user;

--
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.currencies_id_seq OWNED BY public.currencies.id;


--
-- Name: deals; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.deals (
    id integer NOT NULL,
    security_id integer NOT NULL,
    broker_id integer NOT NULL,
    deal_type character varying(10) NOT NULL,
    deal_date date NOT NULL,
    quantity numeric(12,2) NOT NULL,
    amount numeric(12,2) NOT NULL,
    price numeric(12,2) NOT NULL
);


ALTER TABLE public.deals OWNER TO invest_user;

--
-- Name: deals_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.deals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deals_id_seq OWNER TO invest_user;

--
-- Name: deals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.deals_id_seq OWNED BY public.deals.id;


--
-- Name: exchanges; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.exchanges (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.exchanges OWNER TO invest_user;

--
-- Name: exchanges_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.exchanges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exchanges_id_seq OWNER TO invest_user;

--
-- Name: exchanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.exchanges_id_seq OWNED BY public.exchanges.id;


--
-- Name: securities; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.securities (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    ticker character varying(10) NOT NULL,
    currency_id integer NOT NULL,
    exchange_id integer NOT NULL,
    has_dividends boolean,
    security_type_id integer NOT NULL
);


ALTER TABLE public.securities OWNER TO invest_user;

--
-- Name: securities_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.securities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.securities_id_seq OWNER TO invest_user;

--
-- Name: securities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.securities_id_seq OWNED BY public.securities.id;


--
-- Name: security_types; Type: TABLE; Schema: public; Owner: invest_user
--

CREATE TABLE public.security_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.security_types OWNER TO invest_user;

--
-- Name: security_types_id_seq; Type: SEQUENCE; Schema: public; Owner: invest_user
--

CREATE SEQUENCE public.security_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.security_types_id_seq OWNER TO invest_user;

--
-- Name: security_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: invest_user
--

ALTER SEQUENCE public.security_types_id_seq OWNED BY public.security_types.id;


--
-- Name: brokers id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.brokers ALTER COLUMN id SET DEFAULT nextval('public.brokers_id_seq'::regclass);


--
-- Name: currencies id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.currencies ALTER COLUMN id SET DEFAULT nextval('public.currencies_id_seq'::regclass);


--
-- Name: deals id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.deals ALTER COLUMN id SET DEFAULT nextval('public.deals_id_seq'::regclass);


--
-- Name: exchanges id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.exchanges ALTER COLUMN id SET DEFAULT nextval('public.exchanges_id_seq'::regclass);


--
-- Name: securities id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.securities ALTER COLUMN id SET DEFAULT nextval('public.securities_id_seq'::regclass);


--
-- Name: security_types id; Type: DEFAULT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.security_types ALTER COLUMN id SET DEFAULT nextval('public.security_types_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.alembic_version (version_num) FROM stdin;
1457f324f264
\.


--
-- Data for Name: brokers; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.brokers (id, name) FROM stdin;
1	Freedom Broker
2	Jusan Invest
3	Tabys
4	Halyk Finance
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.currencies (id, name) FROM stdin;
1	Тенге
2	Доллар США
\.


--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.deals (id, security_id, broker_id, deal_type, deal_date, quantity, amount, price) FROM stdin;
1	1	2	buy	2024-09-04	61644.00	300.00	205.48
2	2	2	buy	2024-09-04	30.00	44340.00	1478.00
3	3	2	buy	2024-09-04	9.00	13302.00	1478.00
4	4	2	buy	2024-09-04	30.00	24477.00	815.90
7	7	2	buy	2024-09-10	5.00	90050.00	18010.00
5	5	2	buy	2024-09-04	17.00	13849.90	814.70
6	6	2	buy	2024-09-10	5.00	304000.00	60800.00
8	8	3	buy	2024-09-10	25.00	195.50	7.82
\.


--
-- Data for Name: exchanges; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.exchanges (id, name) FROM stdin;
1	KASE
2	AIX
3	NYSE
4	NASDAQ
\.


--
-- Data for Name: securities; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.securities (id, name, description, ticker, currency_id, exchange_id, has_dividends, security_type_id) FROM stdin;
1	АО "Народный Банк Казахстана"	Акция обыкновенная Халык банка	HSBK	1	1	t	1
2	АО "KEGOC"	Акция обыкновенная АО "KEGOC"	KEGC	1	1	t	1
3	АО "KEGOC"	Акция обыкновенная АО "KEGOC"	KEGC	1	1	t	1
4	АО "Эйр Астана"	Акция обыкновенная  АО "Эйр Астана"	AIRA	1	1	f	1
5	АО "КазТрансОйл"	Акция обыкновенная  АО "КазТрансОйл"	KZTO	1	1	t	1
6	АО Kaspi.kz	Акция обыкновенная  АО Kaspi.kz	KSPI	1	1	t	1
7	АО "Национальная атомная компания "Казатомпром"	Акция обыкновенная АО "Национальная атомная компания "Казатомпром"	KZAP	1	1	t	1
8	High Yield Corporate Bonds	Облигации компаний США с высокой доходностью	IXR	2	2	t	4
\.


--
-- Data for Name: security_types; Type: TABLE DATA; Schema: public; Owner: invest_user
--

COPY public.security_types (id, name) FROM stdin;
1	Акция
2	Облигация
3	ETF
4	ETN
5	ПИФ
\.


--
-- Name: brokers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.brokers_id_seq', 4, true);


--
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.currencies_id_seq', 2, true);


--
-- Name: deals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.deals_id_seq', 8, true);


--
-- Name: exchanges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.exchanges_id_seq', 4, true);


--
-- Name: securities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.securities_id_seq', 8, true);


--
-- Name: security_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: invest_user
--

SELECT pg_catalog.setval('public.security_types_id_seq', 5, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: brokers brokers_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.brokers
    ADD CONSTRAINT brokers_pkey PRIMARY KEY (id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: exchanges exchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.exchanges
    ADD CONSTRAINT exchanges_pkey PRIMARY KEY (id);


--
-- Name: securities securities_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.securities
    ADD CONSTRAINT securities_pkey PRIMARY KEY (id);


--
-- Name: security_types security_types_name_key; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.security_types
    ADD CONSTRAINT security_types_name_key UNIQUE (name);


--
-- Name: security_types security_types_pkey; Type: CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.security_types
    ADD CONSTRAINT security_types_pkey PRIMARY KEY (id);


--
-- Name: deals deals_broker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_broker_id_fkey FOREIGN KEY (broker_id) REFERENCES public.brokers(id);


--
-- Name: deals deals_security_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_security_id_fkey FOREIGN KEY (security_id) REFERENCES public.securities(id);


--
-- Name: securities securities_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.securities
    ADD CONSTRAINT securities_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currencies(id);


--
-- Name: securities securities_exchange_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.securities
    ADD CONSTRAINT securities_exchange_id_fkey FOREIGN KEY (exchange_id) REFERENCES public.exchanges(id);


--
-- Name: securities securities_security_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: invest_user
--

ALTER TABLE ONLY public.securities
    ADD CONSTRAINT securities_security_type_id_fkey FOREIGN KEY (security_type_id) REFERENCES public.security_types(id);


--
-- PostgreSQL database dump complete
--

