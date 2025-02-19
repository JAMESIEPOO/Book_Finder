--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-18 19:05:40

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
    authorname name NOT NULL,
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
    genre character varying(20),
    author character varying(20),
    rating double precision DEFAULT 0
);


ALTER TABLE public."Preferences" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16462)
-- Name: Publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Publisher" (
    "publisherID" bigint NOT NULL,
    "publisherName" character varying(50) NOT NULL,
    "publisherInfo" text
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
    "timestamp" timestamp with time zone NOT NULL
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
    "preferenceID" bigint
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 16415)
-- Dependencies: 220
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" ("authorID", authorname, biography) FROM stdin;
1	Kurt Vonnegut	Kurt Vonnegut was born on November 11, 1922 and died April 11, 2007. He was an American author known for funny and dark novels. He has published 14 novels, 3 short-story collections, 5 plays, and 5 nonfiction works over 50 years. His further works have been published since his death.
2	Roger Manley	ROGER MANLEY's screenplays, books, pictures, and history conservation endeavors have earned him a world renown reputationin the Outsider Art comunity. He is the author of several books, and a director of a feature documentary, MANA: Beyond Belief, which won him the C.I.N.E. Golden Eagle award.
3	H. P. Lovecraft	Howard Phillips Lovecraft was born on August 20, 1890 and died March 15, 1937. He was an American writer of weird, science, fantasy, and horror fiction. He is mostly known for his work in the formation of what is now called the Cthulhu Mythos through his many indirectly connected short stories.
4	Doctor Temple Grandin and Sean Barron	Temple Grandin is a successful and well known individual with autism. She is a professor at Colorado State University. Sean Barron graduated from Youngstown State University and now works as a writer for The Youngstown Vindicator.
5	Guo Gu	Guo Gu is a chan/zen Buddhist teacher and founder of the Tallahassee Chan Center in Florida. He was the closest disciple of the late Chan/zen buddhist Master Sheng Yen who died in 2009.
\.


--
-- TOC entry 4934 (class 0 OID 16408)
-- Dependencies: 219
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" ("bookID", title, "authorID", genre, summery, rating, "publisherID", "date published") FROM stdin;
1	Slaughter House-Five or the childern's crusade	1	Science Fiction	A 1969 semi-autobiographic sci-fi infused anti-war novel by Kurt Vonnegut. It follows the protagonist Billy Pilgrim, from his early years, to his post-war years. In the novel, Billy frequently travels back and forth across his life's history. This temporal crisis is a result of his post-war psychological trauma. The story centers on Billy's capture by the German Army and his survival of the Allied firebombing of Dresden as a prisoner of war, an experience that Vonnegut endured as an American serviceman.	8	1	1969-03-31
2	Weird Carolinas	2	History	 From Spanish moss reaches out from trees across lonely roads, to the Great Dismal Swamps that harbor unknown beasts and monsters, and finally to the coastlines that are covered with hidden bays and inlets where pirates buried treasures and German U-boats roamed. What makes North and South Carolina so strange and down right scary? Follow a former Charleston resident named Roger Manley to find out.	7	2	2011-10-04
3	The Shadow Out of Time	3	Science Fiction	Nathaniel Wingate Peaslee, a professor of economics at Miskatonic University, tells the reader in flashbacks about the events that occurred between May 14, 1908 and July 17–18, 1935. It was during those times that He was the victim of a body replacement by aliens he called the Great Race of Yith. They had arrived on Earth 200 million years ago and possessed the ability to swap their minds with other beings both in the past and in the future. They use this ability to create vast libraries of all the knowledge that Earth has ever posessed in any time period. The story follows Nathaniel as he embarks to make sense of the revelations of the yith and what they mean for mankinds fate.	6	3	2013-11-01
4	Unwriten Rules of Social Relationships	4	Self Help	Born with autism, both Temple Grandin and Sean Barron live successful and healthy social lives. However, their paths to this outcome were quite different. These are their life stories and what they learned that could help you navigate your own path to healthy social relationships.	5	4	2017-04-01
5	Passing Through The Gateless Barrier: Koan Practice for Real Life	5	Religion	The purpose of kōan practice is to lead us to certain gates to access a marvelous awakenings beyond the barriers of the mind. The 48 kōans of the Gateless Barrier manuscript have been awaking people to these revelations for well over 800 years. Chan teacher Guo Gu provides here a new english version of the classic text as well as the first English commentary on the kōans by a teacher of the chan/zen buddhist tradition.	6	5	2016-05-31
\.


--
-- TOC entry 4937 (class 0 OID 16449)
-- Dependencies: 222
-- Data for Name: Favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Favorites" ("userID", "bookID") FROM stdin;
2	4
1	2
3	1
3	5
\.


--
-- TOC entry 4933 (class 0 OID 16395)
-- Dependencies: 218
-- Data for Name: Preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Preferences" ("preferenceID", genre, author, rating) FROM stdin;
1	Science Fiction	\N	8
2	History	Roger Manley	0
\.


--
-- TOC entry 4938 (class 0 OID 16462)
-- Dependencies: 223
-- Data for Name: Publisher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Publisher" ("publisherID", "publisherName", "publisherInfo") FROM stdin;
1	Archaia	Archaia Entertainment was an American comicbook publishing limited liablity corporation established by Mark Smylie in 2002. On June 24, 2013, Archaia was acquired by Boom! Studios and became one of their brands.\n\nAs of 2017, 20th Century Fox bought a minority share in Boom! Studios valued at $10 million dollars.In 2019, The Walt Disney Company inherited Fox 's shares in Boom! Studios after Disney acquired 21st Century Fox's assets on March 20, 2019.\n\nAs of September 10, 2024, Disney has sold Boom! Studios to a company called Random House.
2	Union Square & Co.	The Sterling Publishing Company is a publisher of a broad range of subjects with multiple brands and more than 5,000 books. Created in 1949 by David A. Boehm, Sterling Publishing became a owned subsidiary of the Barnes & Noble company in 2003. In March 2022, Sterling rebranded as Union Square & Co. and In 2024, Barnes & Noble sold Union Square & Co. to Hachette Book Group.
3	SelfMadeHero	SelfMadeHero is an independent publishing busness which specialises in translating works of literature and ground-breaking original fiction into graphic novels. SelfMadeHero's books are made in the United Kingdom by Abrams & Chronicle Books and in the United States by Abrams Books.
4	Future Horizons INC.	Future Horizons was founded in 1996. the founders beleved that the spread of information about autism and Asperger's syndromes through books, conferences, and other media would help those who live and work with these conditions both personally and professionally. Devoted entirely to this mission, Future Horizons has grown to be a world leader in the publication of autism and Asperger's syndrome infomation books.
5	Shambhala publications INC.	Shambhala Publications is an independent publishing company located in Boulder, Colorado. it mostly publishes books that deal with Buddhism and other topics involving Eastern history, martial arts, philosophy, and religion.
\.


--
-- TOC entry 4936 (class 0 OID 16432)
-- Dependencies: 221
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Review" ("reviewID", "bookID", "userID", rating, "reviewText", "timestamp") FROM stdin;
1	2	3	9	This Book was a thrill to read and helped me pick out were to visit on my trip thruogh south carolina.	2025-02-18 19:04:19.44364-05
\.


--
-- TOC entry 4932 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("userID", username, email, password, "preferenceID") FROM stdin;
1	Jake Smith	jakeshith123@yahoo.com	apple123	1
2	Neil Uberoth	uberoth112@gmail.com	apple12pear13	\N
3	Jean Casavan	jean994@hotmail.com	bacon101	2
\.


--
-- TOC entry 4775 (class 2606 OID 16488)
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
-- TOC entry 4781 (class 2606 OID 16489)
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


-- Completed on 2025-02-18 19:05:40

--
-- PostgreSQL database dump complete
--

