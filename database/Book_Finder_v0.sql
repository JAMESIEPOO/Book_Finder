--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-06 15:33:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 217 (class 1259 OID 16389)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "userID" bigint NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(254) NOT NULL,
    password character varying(20) NOT NULL,
    "preferenceID" bigint DEFAULT 0
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 4889 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("userID", username, email, password, "preferenceID") FROM stdin;
\.


--
-- TOC entry 4743 (class 2606 OID 16394)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("userID");


-- Completed on 2025-02-06 15:33:53

--
-- PostgreSQL database dump complete
--

