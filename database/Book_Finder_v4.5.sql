--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-04-21 14:33:12

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

--
-- TOC entry 224 (class 1259 OID 16528)
-- Name: sq_author_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_author_id
    START WITH 8
    INCREMENT BY 1
    MINVALUE 8
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_author_id OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: Author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Author" (
    "authorID" bigint DEFAULT nextval('public.sq_author_id'::regclass) NOT NULL,
    authorname name NOT NULL,
    biography text
);


ALTER TABLE public."Author" OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16530)
-- Name: sq_book_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_book_id
    START WITH 12
    INCREMENT BY 1
    MINVALUE 12
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_book_id OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16408)
-- Name: Book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Book" (
    "bookID" bigint DEFAULT nextval('public.sq_book_id'::regclass) NOT NULL,
    title character varying(100) NOT NULL,
    "authorID" bigint,
    summery text,
    rating bigint NOT NULL,
    "publisherID" bigint NOT NULL,
    "date published" date NOT NULL,
    "genreID" bigint
);


ALTER TABLE public."Book" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16449)
-- Name: Favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Favorites" (
    "userID" bigint,
    "bookID" bigint
);


ALTER TABLE public."Favorites" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16547)
-- Name: sq_genre_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_genre_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_genre_id OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16542)
-- Name: Genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Genre" (
    "genreID" bigint DEFAULT nextval('public.sq_genre_id'::regclass) NOT NULL,
    "genreName" character varying(20) NOT NULL
);


ALTER TABLE public."Genre" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16529)
-- Name: sq_publisher_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_publisher_id
    START WITH 9
    INCREMENT BY 1
    MINVALUE 9
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_publisher_id OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16462)
-- Name: Publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Publisher" (
    "publisherID" bigint DEFAULT nextval('public.sq_publisher_id'::regclass) NOT NULL,
    "publisherName" character varying(50) NOT NULL,
    "publisherInfo" text
);


ALTER TABLE public."Publisher" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16531)
-- Name: sq_review_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_review_id
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_review_id OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16432)
-- Name: Review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Review" (
    "reviewID" bigint DEFAULT nextval('public.sq_review_id'::regclass) NOT NULL,
    "bookID" bigint NOT NULL,
    "userID" bigint NOT NULL,
    rating bigint NOT NULL,
    "reviewText" text,
    "timestamp" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Review" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16525)
-- Name: sq_user_id; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sq_user_id
    START WITH 8
    INCREMENT BY 1
    MINVALUE 8
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sq_user_id OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "userID" bigint DEFAULT nextval('public.sq_user_id'::regclass) NOT NULL,
    username name NOT NULL COLLATE pg_catalog."default",
    email character varying(254) NOT NULL,
    password character varying(128) NOT NULL,
    rating double precision,
    "authorID" bigint,
    "genreID" bigint
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- TOC entry 4948 (class 0 OID 16415)
-- Dependencies: 219
-- Data for Name: Author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Author" ("authorID", authorname, biography) FROM stdin;
1	Kurt Vonnegut	Kurt Vonnegut was born on November 11, 1922 and died April 11, 2007. He was an American author known for funny and dark novels. He has published 14 novels, 3 short-story collections, 5 plays, and 5 nonfiction works over 50 years. His further works have been published since his death.
2	Roger Manley	ROGER MANLEY's screenplays, books, pictures, and history conservation endeavors have earned him a world renown reputationin the Outsider Art comunity. He is the author of several books, and a director of a feature documentary, MANA: Beyond Belief, which won him the C.I.N.E. Golden Eagle award.
3	H. P. Lovecraft	Howard Phillips Lovecraft was born on August 20, 1890 and died March 15, 1937. He was an American writer of weird, science, fantasy, and horror fiction. He is mostly known for his work in the formation of what is now called the Cthulhu Mythos through his many indirectly connected short stories.
4	Doctor Temple Grandin and Sean Barron	Temple Grandin is a successful and well known individual with autism. She is a professor at Colorado State University. Sean Barron graduated from Youngstown State University and now works as a writer for The Youngstown Vindicator.
5	Guo Gu	Guo Gu is a chan/zen Buddhist teacher and founder of the Tallahassee Chan Center in Florida. He was the closest disciple of the late Chan/zen buddhist Master Sheng Yen who died in 2009.
6	Tom Jackson	Tom Jackson is a author who has written over 80 books and contributed to hundreds of others. His focuses are natural history, technology, and science. Tom spends his time finding new fun ways to communicate facts to people of all ages, and getting them interested in science and STEM fields.
7	Stephan Pastis	Stephan Pastis is a cartoonist and former insurance defense litigation attorney who is the creator of the newspaper comic strip Pearls Before Swine.
8	Paula Hammond	Paula Hammond is a publisher, copy-writer, ghost-writer, author, artist, and journalist. She has written fiction and non-fiction books, comics, poetry, and scripts for DVDs and CD-ROMS. She has worked with the companies Harper Collins, Marshall Cavendish, Scholastic, World Book, Disney, and the BBC.
9	Scott Adams	Scott Adams is the maker of the Dilbert comic strip that is published daily in many newspapers and websites.
10	Bob Boethling	n/a
11	Sarah Tomley	Sarah Tomley studied philosophy and literature at the University of Warwick in the UK, and now works in the publishing industry as a commissioning editor
12	Benjamin Franklin	One of americas founding farthers and an inventor, Benjamin Franklin was the first franchise owner in america and published his own newspaper.
\.


--
-- TOC entry 4947 (class 0 OID 16408)
-- Dependencies: 218
-- Data for Name: Book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Book" ("bookID", title, "authorID", summery, rating, "publisherID", "date published", "genreID") FROM stdin;
2	Weird Carolinas	2	 From Spanish moss reaches out from trees across lonely roads, to the Great Dismal Swamps that harbor unknown beasts and monsters, and finally to the coastlines that are covered with hidden bays and inlets where pirates buried treasures and German U-boats roamed. What makes North and South Carolina so strange and down right scary? Follow a former Charleston resident named Roger Manley to find out.	7	2	2011-10-04	2
3	The Shadow Out of Time	3	Nathaniel Wingate Peaslee, a professor of economics at Miskatonic University, tells the reader in flashbacks about the events that occurred between May 14, 1908 and July 17–18, 1935. It was during those times that He was the victim of a body replacement by aliens he called the Great Race of Yith. They had arrived on Earth 200 million years ago and possessed the ability to swap their minds with other beings both in the past and in the future. They use this ability to create vast libraries of all the knowledge that Earth has ever posessed in any time period. The story follows Nathaniel as he embarks to make sense of the revelations of the yith and what they mean for mankinds fate.	6	3	2013-11-01	5
4	Unwriten Rules of Social Relationships	4	Born with autism, both Temple Grandin and Sean Barron live successful and healthy social lives. However, their paths to this outcome were quite different. These are their life stories and what they learned that could help you navigate your own path to healthy social relationships.	5	4	2017-04-01	6
5	Passing Through The Gateless Barrier: Koan Practice for Real Life	5	The purpose of kōan practice is to lead us to certain gates to access a marvelous awakenings beyond the barriers of the mind. The 48 kōans of the Gateless Barrier manuscript have been awaking people to these revelations for well over 800 years. Chan teacher Guo Gu provides here a new english version of the classic text as well as the first English commentary on the kōans by a teacher of the chan/zen buddhist tradition.	6	5	2016-05-31	3
9	At the Mountains Of Madness	3	A team of explorers led by the story's protagonist and narrator, Dr. William Dyer of Miskatonic University, try to describe a series of previously untold events in the hope of deterring the world from sending another expedition to the continent of Antartica. His team's discoveries include an ancient civilization older than life on earth, and realization of Earth's past horrors told through various sculptures and murals within the lost civilizations final city in the mountains of Antartica.	9	3	2012-02-07	5
1	Slaughter House-Five or the childern's crusade	1	A 1969 semi-autobiographic sci-fi infused anti-war novel by Kurt Vonnegut. It follows the protagonist Billy Pilgrim, from his early years, to his post-war years. In the novel, Billy frequently travels back and forth across his life's history. This temporal crisis is a result of his post-war psychological trauma. The story centers on Billy's capture by the German Army and his survival of the Allied firebombing of Dresden as a prisoner of war, an experience that Vonnegut endured as an American serviceman.	8	1	2020-09-15	5
11	The War to End Wars 1914-18 (The Eventful 20th Century)	\N	A reader's Digest book on the firts world war explaining the battles, factions, weapons, and suffering of the war.	7	8	2001-01-01	2
12	The World's Strangest Animals Nature's weird and wonderful creatures	8	This book collects more than 40 of the most unusual animals from around the world. Some of the animals you can learn about are komodo dragons, sugar gliders, mantises, seahorses, mudskipper fish, and bats.	5	9	2014-03-04	4
13	The Illustrated Encyclopedia of Islam	\N	This book explores in detail the life and work of Muhammad, the history of Islam, Islamic beliefs, its doctrine, religious practices, and worship.	7	10	2010-05-16	3
14	The Illustrated Encyclopedia of Hinduism	\N	Hinduism is the oldest of the major world religions. This book explores its historical and cultural development, from its Indian roots to its vibrant application in the present and its global context.	7	10	2012-07-16	3
15	The Illustrated Encyclopedia of buddhism	\N	Buddhism is the fifth largest world religion and is estimated to have 350 million followers. This book introduces and explains Buddhist history, philosophy, and practice from its very beginning to the present day.	8	10	2009-11-15	3
16	Your New Job Title Is "Accomplice": A Dilbert Book	9	This 14th Dilbert collection comically professes that our devices might be more sophisticated, our apps might be more plentiful, but when it comes down to the interactions between the workers and the clueless managers, discontent and sarcasm reign supreme.	6	7	2013-05-21	1
17	The Psychology Book (DK Big Ideas)	\N	This book Explores and tries to explain the fundamental ideas and groundbreaking theories in the field of psychology clearly and simply.	10	11	2024-06-11	4
18	How the Body Works: The Facts Simply Explained (DK How Stuff Works)	10	This essential visual guide introduces all your bodies weird and wonderful parts and processes.	8	11	2016-05-03	4
19	The Sociology Book: Big Ideas Simply Explained (DK Big Ideas)	11	Learn about Sociology in this overview book. this book is great for beginners who want to learn and experts wanting to refresh their knowledge!	9	11	2019-12-12	4
20	The Way to Wealth	12	The Way to Wealth by Benjamin Franklin is still considered by some to be the best book on money and wealth ever written. It was originally published in 1758 as the preface to the Poor Richard's Almanack.	10	12	1986-09-01	6
21	Go Add Value Someplace Else	9	This book is the 42nd collection of Dillbert comic strips produced by Scott Adams.	7	13	2014-10-28	1
6	Physics: An Illustrated History of the Foundations of Science	6	This Book follows the famous scientists and experts throughout the ages as they unlock the fabric of the universe to reveal the diverse number of forces, intangible particles, and energies that make up our universe.	7	6	2013-10-28	4
7	I Scream, You Scream, We All Scream Because Puns Suck	7	Pearls Before Swine returns for some of the comic’s most scandalous comic strips yet. Rat tries his hand at being a judge and presidential candidate (he’s accepting tips), Goat has a cruel encounter with Internet trolls (maybe it’s time to stop social media for good), and Pig is heart broken to learn that there is no city i Europe called “Hamsterdam” (or a dam that holds back a river of hamsters).	6	7	2017-09-12	1
8	Floundering Fathers	7	The Pearls Before Swine comic is back with all-new strips that would make our founding fathers . . . well, maybe it’s good they’re not around to see Goat get a dating app account, Rat campaign as a selfish but honest demagogue, or Stephan hit his readers with pun after pun. Floundering Fathers is guaranteed to make you laugh... or cry... or roll in pain from all the bad puns.	7	7	2018-03-20	1
10	The Case of Charles Dexter Ward	3	A inmate disappears from a insane asylum, his method of escape remains a mystery. Only the patient’s final visitor, His family physician Dr. Marinus Bicknell Willett knows the secrets to The Case of Charles Dexter Ward. This story is a macabre assortment of magic, investigation, grave-robbing, and bone-chilling famliy secrets.	5	3	2021-03-23	5
\.


--
-- TOC entry 4950 (class 0 OID 16449)
-- Dependencies: 221
-- Data for Name: Favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Favorites" ("userID", "bookID") FROM stdin;
2	4
1	2
3	1
3	5
3	4
4	3
4	9
4	10
5	1
9	5
9	21
9	19
6	19
8	14
\.


--
-- TOC entry 4957 (class 0 OID 16542)
-- Dependencies: 228
-- Data for Name: Genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Genre" ("genreID", "genreName") FROM stdin;
1	Comic
2	History
3	Religion
4	Science
5	Science Fiction
6	Self Help
\.


--
-- TOC entry 4951 (class 0 OID 16462)
-- Dependencies: 222
-- Data for Name: Publisher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Publisher" ("publisherID", "publisherName", "publisherInfo") FROM stdin;
1	Archaia	Archaia Entertainment was an American comicbook publishing limited liablity corporation established by Mark Smylie in 2002. On June 24, 2013, Archaia was acquired by Boom! Studios and became one of their brands.\n\nAs of 2017, 20th Century Fox bought a minority share in Boom! Studios valued at $10 million dollars.In 2019, The Walt Disney Company inherited Fox 's shares in Boom! Studios after Disney acquired 21st Century Fox's assets on March 20, 2019.\n\nAs of September 10, 2024, Disney has sold Boom! Studios to a company called Random House.
2	Union Square & Co.	The Sterling Publishing Company is a publisher of a broad range of subjects with multiple brands and more than 5,000 books. Created in 1949 by David A. Boehm, Sterling Publishing became a owned subsidiary of the Barnes & Noble company in 2003. In March 2022, Sterling rebranded as Union Square & Co. and In 2024, Barnes & Noble sold Union Square & Co. to Hachette Book Group.
3	SelfMadeHero	SelfMadeHero is an independent publishing busness which specialises in translating works of literature and ground-breaking original fiction into graphic novels. SelfMadeHero's books are made in the United Kingdom by Abrams & Chronicle Books and in the United States by Abrams Books.
4	Future Horizons INC.	Future Horizons was founded in 1996. the founders beleved that the spread of information about autism and Asperger's syndromes through books, conferences, and other media would help those who live and work with these conditions both personally and professionally. Devoted entirely to this mission, Future Horizons has grown to be a world leader in the publication of autism and Asperger's syndrome infomation books.
5	Shambhala publications INC.	Shambhala Publications is an independent publishing company located in Boulder, Colorado. it mostly publishes books that deal with Buddhism and other topics involving Eastern history, martial arts, philosophy, and religion.
6	Shelter Harbor Press	Shelter Harbor Press was made in 2012, and is a small publishing company. Its focus is on publishing high-quality trade reference and STEM books.
7	Andrews McMeel Publishing	Andrews McMeel is a publisher of comic strip books produced by a related company called Andrews McMeel Syndication. some of the comic strips they own are Peanuts, The Far Side, Calvin and Hobbes and FoxTrot. However, the company also makes books for other comic strips which are owned by other syndication companies.
8	Readers Digest	Reader's Digest is an American family magazine created in 1922 by DeWitt Wallace and his wife Lila Bell Wallace. Global editions of the magazine reach 40 million people in more than 70 countries, via 49 editions in 21 different languages. The periodical of the magazine has a global circulation of 10.5 million people, making it the largest paid-circulation magazine in the world.
9	Scholastic	The Scholastic Corporation is a multinational publishing, education, and media company that makes books, comics, and educational material for schools, parents, children, and other educational institutions.
10	Lorenz Books	Lorenz Books is an imprint of Lorenz Educational Press. It is an educational publisher based in Dayton, Ohio. The company focuses on the educational materials market, including language arts, math, science, social studies, critical thinking, team building, and movement and music. Its parent company is The Lorenz Corporation which has been in the publishing game since 1890.
11	DK Publishing	Dorling Kindersley Limited (A.K.A. DK) is a multinational company specialising in illustrated reference books.
12	Applewood Books	Applewood Books is a publishing company which focuses on reissuing original versions of historical books. It was founded by Phil Zuckerman in the year 1976.
13	SIMON & SCHUSTER	Simon & Schuster is considered one of the 5 biggest English language publishers. As of 2017, Simon & Schuster was the third largest publisher in the US, publishing 2,000 books yearly under 35 different imprints.
\.


--
-- TOC entry 4949 (class 0 OID 16432)
-- Dependencies: 220
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Review" ("reviewID", "bookID", "userID", rating, "reviewText", "timestamp") FROM stdin;
1	2	3	9	This Book was a thrill to read and helped me pick out were to visit on my trip thruogh south carolina.	2025-02-18 19:04:19.44364-05
2	8	5	9	Some of the jokes about the presidency were so funny I hope the next book is just as fun	2025-02-27 17:35:27.487176-05
4	9	4	10	This story was lovecrafts first venture into science fiction and it does not disappoint!	2025-02-27 17:42:55.166168-05
5	11	2	7	This book was relly good, but it did not have a lot about the engineering behind the vechicles and weapons of WW1	2025-03-06 17:14:39.214072-05
6	5	2	5	This book is real helpful at understanding buddhist though, however it is extremely deep and hard for beginners to grasp.	2025-03-06 17:17:53.422336-05
7	6	7	10	This book is awsome. It is an great sorce for understanding the history of classical physics.	2025-03-06 17:21:55.171763-05
8	5	10	8	I don't know why the other review said that this wasn't for beginners. I thought it was really easy.	2025-03-19 14:33:04.567808-04
9	21	8	9	Dispite what the author has done recently, I still think his comics are the best.	2025-03-19 14:35:39.657556-04
3	4	6	6	This book was really helpful to me when I was struggling with my own autism but only Temple's story and advice spoke to me.	2025-02-27 17:39:53.726619-05
10	15	10	10	This publisher does the best work breaking down a religion.	2025-03-19 14:40:54.752269-04
11	20	9	1	book is bad	2025-03-19 14:42:02.191619-04
12	5	9	4	book is fine	2025-03-19 14:42:19.279863-04
13	3	9	9	book is great	2025-03-19 14:42:55.936227-04
14	9	9	9	book is great	2025-03-19 14:43:31.288496-04
15	6	4	4	This was a little to much science for me.	2025-03-19 14:44:32.719436-04
16	8	7	9	This was dark but funny.	2025-03-19 14:51:39.023798-04
17	2	7	4	This was good, but some parts of it were very dry reading.	2025-03-19 14:54:19.415929-04
\.


--
-- TOC entry 4946 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("userID", username, email, password, rating, "authorID", "genreID") FROM stdin;
2	Neil Uberoth	uberoth112@gmail.com	apple12pear13	\N	\N	\N
5	Rick Sanchez	portalme@outlook.com	Diane101	\N	\N	\N
6	Mike Jonah	jonah123@gmail.com	bowling1453	\N	\N	\N
7	Tony Graslow	baronvonme@hotmail.com	grape123#!	\N	\N	\N
4	Tony Hannabal	tony117Hannabal@att.net	Carthage660	\N	3	\N
1	Jake Smith	jakeshith123@yahoo.com	apple123	8	\N	5
3	Jean Casavan	jean994@hotmail.com	bacon101	\N	2	2
9	Main User	Thisisanemail@email.com	password	5	3	5
8	Mack Danel	mackdaddy345@hotmail.com	daddy0#!	\N	\N	1
10	Steven Yuan	yinyangyo@gmail.com	z3n101#	\N	\N	\N
\.


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 224
-- Name: sq_author_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_author_id', 12, true);


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 226
-- Name: sq_book_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_book_id', 21, true);


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 229
-- Name: sq_genre_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_genre_id', 6, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 225
-- Name: sq_publisher_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_publisher_id', 13, true);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 227
-- Name: sq_review_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_review_id', 17, true);


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 223
-- Name: sq_user_id; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sq_user_id', 10, true);


--
-- TOC entry 4785 (class 2606 OID 16488)
-- Name: Author Author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Author"
    ADD CONSTRAINT "Author_pkey" PRIMARY KEY ("authorID");


--
-- TOC entry 4783 (class 2606 OID 16414)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY ("bookID");


--
-- TOC entry 4791 (class 2606 OID 16546)
-- Name: Genre Genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Genre"
    ADD CONSTRAINT "Genre_pkey" PRIMARY KEY ("genreID");


--
-- TOC entry 4789 (class 2606 OID 16468)
-- Name: Publisher Publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Publisher"
    ADD CONSTRAINT "Publisher_pkey" PRIMARY KEY ("publisherID");


--
-- TOC entry 4787 (class 2606 OID 16438)
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY ("reviewID");


--
-- TOC entry 4779 (class 2606 OID 16394)
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("userID");


--
-- TOC entry 4781 (class 2606 OID 16402)
-- Name: User user_uniquekey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT user_uniquekey UNIQUE ("userID");


--
-- TOC entry 4797 (class 2606 OID 16444)
-- Name: Review Review_fkey_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_fkey_1" FOREIGN KEY ("bookID") REFERENCES public."Book"("bookID");


--
-- TOC entry 4798 (class 2606 OID 16439)
-- Name: Review Review_fkey_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_fkey_2" FOREIGN KEY ("userID") REFERENCES public."User"("userID");


--
-- TOC entry 4799 (class 2606 OID 16452)
-- Name: Favorites favorites_fkey_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorites"
    ADD CONSTRAINT favorites_fkey_1 FOREIGN KEY ("userID") REFERENCES public."User"("userID");


--
-- TOC entry 4800 (class 2606 OID 16457)
-- Name: Favorites favorites_fkey_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Favorites"
    ADD CONSTRAINT favorites_fkey_2 FOREIGN KEY ("bookID") REFERENCES public."Book"("bookID");


--
-- TOC entry 4794 (class 2606 OID 16489)
-- Name: Book fk_book_author_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT fk_book_author_id FOREIGN KEY ("authorID") REFERENCES public."Author"("authorID") NOT VALID;


--
-- TOC entry 4795 (class 2606 OID 16549)
-- Name: Book fk_book_genre_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT fk_book_genre_id FOREIGN KEY ("genreID") REFERENCES public."Genre"("genreID") NOT VALID;


--
-- TOC entry 4796 (class 2606 OID 16469)
-- Name: Book fk_book_publisher_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT fk_book_publisher_id FOREIGN KEY ("publisherID") REFERENCES public."Publisher"("publisherID") NOT VALID;


--
-- TOC entry 4792 (class 2606 OID 16532)
-- Name: User fk_user_author_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT fk_user_author_id FOREIGN KEY ("authorID") REFERENCES public."Author"("authorID") NOT VALID;


--
-- TOC entry 4793 (class 2606 OID 16554)
-- Name: User fk_user_genre_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT fk_user_genre_id FOREIGN KEY ("genreID") REFERENCES public."Genre"("genreID") NOT VALID;


-- Completed on 2025-04-21 14:33:12

--
-- PostgreSQL database dump complete
--

