--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-06 17:01:53

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
-- TOC entry 220 (class 1259 OID 16415)
-- Name: Author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Author" (
    "authorID" bigint NOT NULL,
    name name NOT NULL,
    biography text
);


ALTER TABLE public."Author" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16408)
-- Name: Book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book" (
    "bookID" bigint NOT NULL,
    title character varying(100) NOT NULL,
    "authorID" bigint NOT NULL,
    genre character varying(20) NOT NULL,
    summery text,
    rating double precision NOT NULL,
    "publisherID" bigint NOT NULL,
    "date published" date NOT NULL
);


ALTER TABLE public."Book" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16449)
-- Name: Favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Favorites" (
    "userID" bigint,
    "bookID" bigint
);


ALTER TABLE public."Favorites" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16395)
-- Name: Preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Preferences" (
    "preferenceID" bigint NOT NULL,
    genre character varying(20) NOT NULL,
    author character varying(20) NOT NULL,
    rating double precision DEFAULT 0
);


ALTER TABLE public."Preferences" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16462)
-- Name: Publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Publisher" (
    "publisherID" bigint NOT NULL,
    "publisher name" character varying(50) NOT NULL,
    "publisher info" text
);


ALTER TABLE public."Publisher" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16432)
-- Name: Review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Review" (
    "reviewID" bigint NOT NULL,
    "bookID" bigint NOT NULL,
    "userID" bigint NOT NULL,
    rating double precision NOT NULL,
    "reviewText" text,
    "timestamp" timestamp(6) with time zone NOT NULL
);


ALTER TABLE public."Review" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "userID" bigint NOT NULL,
    username name NOT NULL COLLATE pg_catalog."default",
    email character varying(254) NOT NULL,
    password character varying(20) NOT NULL,
    "preferenceID" bigint NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 16415)
-- Dependencies: 220
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" ("authorID", name, biography) FROM stdin;
\.


--
-- TOC entry 4934 (class 0 OID 16408)
-- Dependencies: 219
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" ("bookID", title, "authorID", genre, summery, rating, "publisherID", "date published") FROM stdin;
\.


--
-- TOC entry 4937 (class 0 OID 16449)
-- Dependencies: 222
-- Data for Name: Favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Favorites" ("userID", "bookID") FROM stdin;
\.


--
-- TOC entry 4933 (class 0 OID 16395)
-- Dependencies: 218
-- Data for Name: Preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Preferences" ("preferenceID", genre, author, rating) FROM stdin;
\.


--
-- TOC entry 4938 (class 0 OID 16462)
-- Dependencies: 223
-- Data for Name: Publisher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Publisher" ("publisherID", "publisher name", "publisher info") FROM stdin;
\.


--
-- TOC entry 4936 (class 0 OID 16432)
-- Dependencies: 221
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Review" ("reviewID", "bookID", "userID", rating, "reviewText", "timestamp") FROM stdin;
\.


--
-- TOC entry 4932 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("userID", username, email, password, "preferenceID") FROM stdin;
\.


--
-- TOC entry 4775 (class 2606 OID 16421)
-- Name: Author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY ("authorID");


--
-- TOC entry 4773 (class 2606 OID 16414)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY ("bookID");


--
-- TOC entry 4771 (class 2606 OID 16400)
-- Name: Preferences Preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Preferences"
    ADD CONSTRAINT "Preferences_pkey" PRIMARY KEY ("preferenceID");


--
-- TOC entry 4779 (class 2606 OID 16468)
-- Name: Publisher Publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publisher"
    ADD CONSTRAINT "Publisher_pkey" PRIMARY KEY ("publisherID");


--
-- TOC entry 4777 (class 2606 OID 16438)
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY ("reviewID");


--
-- TOC entry 4767 (class 2606 OID 16394)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("userID");


--
-- TOC entry 4769 (class 2606 OID 16402)
-- Name: User user_uniquekey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_uniquekey UNIQUE ("userID");


--
-- TOC entry 4781 (class 2606 OID 16427)
-- Name: Book Book_fkey_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_fkey_1" FOREIGN KEY ("authorID") REFERENCES public."Author"("authorID") NOT VALID;


--
-- TOC entry 4783 (class 2606 OID 16444)
-- Name: Review Review_fkey_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_fkey_1" FOREIGN KEY ("bookID") REFERENCES public."Book"("bookID");


--
-- TOC entry 4784 (class 2606 OID 16439)
-- Name: Review Review_fkey_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_fkey_2" FOREIGN KEY ("userID") REFERENCES public."User"("userID");


--
-- TOC entry 4780 (class 2606 OID 16403)
-- Name: User User_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_fkey" FOREIGN KEY ("preferenceID") REFERENCES public."Preferences"("preferenceID") NOT VALID;


--
-- TOC entry 4782 (class 2606 OID 16469)
-- Name: Book book_fkey_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT book_fkey_2 FOREIGN KEY ("publisherID") REFERENCES public."Publisher"("publisherID") NOT VALID;


--
-- TOC entry 4785 (class 2606 OID 16452)
-- Name: Favorites favorites_fkey_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorites"
    ADD CONSTRAINT favorites_fkey_1 FOREIGN KEY ("userID") REFERENCES public."User"("userID");


--
-- TOC entry 4786 (class 2606 OID 16457)
-- Name: Favorites favorites_fkey_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorites"
    ADD CONSTRAINT favorites_fkey_2 FOREIGN KEY ("bookID") REFERENCES public."Book"("bookID");


-- Completed on 2025-02-06 17:01:53

--
-- PostgreSQL database dump complete
--

