--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.4

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
-- Name: connections; Type: TABLE; Schema: public; Owner: fernanda
--

CREATE TABLE public.connections (
    connection_id integer NOT NULL,
    user_id integer,
    friend_id integer
);


ALTER TABLE public.connections OWNER TO fernanda;

--
-- Name: connections_connection_id_seq; Type: SEQUENCE; Schema: public; Owner: fernanda
--

CREATE SEQUENCE public.connections_connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.connections_connection_id_seq OWNER TO fernanda;

--
-- Name: connections_connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fernanda
--

ALTER SEQUENCE public.connections_connection_id_seq OWNED BY public.connections.connection_id;


--
-- Name: cookbooks; Type: TABLE; Schema: public; Owner: fernanda
--

CREATE TABLE public.cookbooks (
    cookbook_id integer NOT NULL,
    title character varying NOT NULL,
    cover_img character varying,
    user_id integer,
    deleted boolean NOT NULL
);


ALTER TABLE public.cookbooks OWNER TO fernanda;

--
-- Name: cookbooks_cookbook_id_seq; Type: SEQUENCE; Schema: public; Owner: fernanda
--

CREATE SEQUENCE public.cookbooks_cookbook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cookbooks_cookbook_id_seq OWNER TO fernanda;

--
-- Name: cookbooks_cookbook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fernanda
--

ALTER SEQUENCE public.cookbooks_cookbook_id_seq OWNED BY public.cookbooks.cookbook_id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: fernanda
--

CREATE TABLE public.recipes (
    recipe_id integer NOT NULL,
    cookbook_id integer NOT NULL,
    title character varying NOT NULL,
    ingredients text,
    time_required character varying,
    servings integer,
    media character varying,
    deleted boolean NOT NULL
);


ALTER TABLE public.recipes OWNER TO fernanda;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: fernanda
--

CREATE SEQUENCE public.recipes_recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_recipe_id_seq OWNER TO fernanda;

--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fernanda
--

ALTER SEQUENCE public.recipes_recipe_id_seq OWNED BY public.recipes.recipe_id;


--
-- Name: steps; Type: TABLE; Schema: public; Owner: fernanda
--

CREATE TABLE public.steps (
    step_id integer NOT NULL,
    recipe_id integer NOT NULL,
    step_number integer NOT NULL,
    body text NOT NULL,
    media character varying
);


ALTER TABLE public.steps OWNER TO fernanda;

--
-- Name: steps_step_id_seq; Type: SEQUENCE; Schema: public; Owner: fernanda
--

CREATE SEQUENCE public.steps_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.steps_step_id_seq OWNER TO fernanda;

--
-- Name: steps_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fernanda
--

ALTER SEQUENCE public.steps_step_id_seq OWNED BY public.steps.step_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: fernanda
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    fname character varying,
    lname character varying,
    email character varying,
    password character varying NOT NULL,
    profile_picture character varying
);


ALTER TABLE public.users OWNER TO fernanda;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: fernanda
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO fernanda;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fernanda
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: connections connection_id; Type: DEFAULT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.connections ALTER COLUMN connection_id SET DEFAULT nextval('public.connections_connection_id_seq'::regclass);


--
-- Name: cookbooks cookbook_id; Type: DEFAULT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.cookbooks ALTER COLUMN cookbook_id SET DEFAULT nextval('public.cookbooks_cookbook_id_seq'::regclass);


--
-- Name: recipes recipe_id; Type: DEFAULT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.recipes ALTER COLUMN recipe_id SET DEFAULT nextval('public.recipes_recipe_id_seq'::regclass);


--
-- Name: steps step_id; Type: DEFAULT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.steps ALTER COLUMN step_id SET DEFAULT nextval('public.steps_step_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: connections; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.connections (connection_id, user_id, friend_id) FROM stdin;
1	1	2
2	2	6
3	3	2
4	4	10
5	6	1
6	7	6
7	8	4
8	9	10
9	10	7
10	5	8
13	5	4
14	16	15
15	15	16
16	15	17
19	17	15
20	17	19
21	15	19
22	19	20
23	19	15
25	22	21
26	21	23
27	21	22
28	15	21
\.


--
-- Data for Name: cookbooks; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.cookbooks (cookbook_id, title, cover_img, user_id, deleted) FROM stdin;
1	Breakfast	/static/img/cooking_6.jpg	1	f
2	Dinner	/static/img/cooking_2.jpg	1	f
3	Breakfast	/static/img/cooking_7.jpg	2	f
4	Dessert	/static/img/cooking_6.jpg	2	f
5	Lunch	/static/img/cooking_6.jpg	3	f
6	Dessert	/static/img/cooking_2.jpg	3	f
7	Breakfast	/static/img/cooking_5.jpg	4	f
8	Breakfast	/static/img/cooking_4.jpg	4	f
9	Lunch	/static/img/cooking_4.jpg	5	f
10	Breakfast	/static/img/cooking_3.jpg	5	f
11	Breakfast	/static/img/cooking_4.jpg	6	f
12	Breakfast	/static/img/cooking_1.jpg	6	f
13	Lunch	/static/img/cooking_5.jpg	7	f
14	Lunch	/static/img/cooking_2.jpg	7	f
15	Lunch	/static/img/cooking_5.jpg	8	f
16	Dinner	/static/img/cooking_7.jpg	8	f
17	Lunch	/static/img/cooking_3.jpg	9	f
18	Dessert	/static/img/cooking_2.jpg	9	f
19	Lunch	/static/img/cooking_1.jpg	10	f
20	Dinner	/static/img/cooking_6.jpg	10	f
21	Favorites	https://res.cloudinary.com/deglaze/image/upload/v1599161258/Heart_font_awesome_ysrcui.png	5	f
22	test 12	http://res.cloudinary.com/deglaze/image/upload/v1599694445/cuca/g1soqvpc4u65jzwy3fp2.jpg	5	f
23	test	https://res.cloudinary.com/deglaze/image/upload/v1599528712/cuca/dinner-plate-icon-png-7_gdchhk.png	5	f
24	test2	https://res.cloudinary.com/deglaze/image/upload/v1599528712/cuca/dinner-plate-icon-png-7_gdchhk.png	5	f
25	Breakfast	http://res.cloudinary.com/deglaze/image/upload/v1599793360/cuca/anhieylmnia61b7wd1ns.jpg	15	f
26	Mexican	http://res.cloudinary.com/deglaze/image/upload/v1599793392/cuca/vvb2filzdccx4zg1icq9.jpg	15	f
28	Dessert	http://res.cloudinary.com/deglaze/image/upload/v1599793816/cuca/zhqgdh5tpyuyacttolv6.jpg	15	f
27	Favorites	http://res.cloudinary.com/deglaze/image/upload/v1599794813/cuca/mk97fg3bmftk2zw9fsm0.jpg	15	f
29	Seafood	http://res.cloudinary.com/deglaze/image/upload/v1599795137/cuca/ioxiln9qkb9g83udpryq.jpg	16	f
30	Comfort Food	http://res.cloudinary.com/deglaze/image/upload/v1599795310/cuca/xef1eszul32mphdeaamn.jpg	16	f
31	Annie's Favorites	http://res.cloudinary.com/deglaze/image/upload/v1599796904/cuca/cxztvz1zpfzm2pvtt8ra.jpg	17	f
32	Dinner	http://res.cloudinary.com/deglaze/image/upload/v1599796935/cuca/w4bpuo1ide658gtbwptd.jpg	17	f
33	Dessert	http://res.cloudinary.com/deglaze/image/upload/v1599797053/cuca/dcwmh7lrdemejjeckhzz.jpg	17	f
34	Home Cooking	http://res.cloudinary.com/deglaze/image/upload/v1599799791/cuca/pdmiiesfy7t50fhvoqvj.jpg	19	f
35	Italian	http://res.cloudinary.com/deglaze/image/upload/v1599799823/cuca/znxxwqahrpxa83yrs1lh.jpg	19	f
36	Date Night	http://res.cloudinary.com/deglaze/image/upload/v1599800391/cuca/cdrib7pkfpwcwbvuexfj.jpg	20	f
37	Soups	http://res.cloudinary.com/deglaze/image/upload/v1599801882/cuca/vo9bffipswm4b1arpiqy.jpg	21	f
39	Stir Fry	http://res.cloudinary.com/deglaze/image/upload/v1599802251/cuca/nj4djpajsxhlte9k8uau.jpg	21	f
38	Dessert	http://res.cloudinary.com/deglaze/image/upload/v1599802113/cuca/jz6rsojuqtntcwvybyis.jpg	21	f
40	Experimental	http://res.cloudinary.com/deglaze/image/upload/v1599801502/cuca/hyb2ddl67q29xsr3xc00.jpg	21	t
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.recipes (recipe_id, cookbook_id, title, ingredients, time_required, servings, media, deleted) FROM stdin;
1	1	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
2	1	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
3	2	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
4	2	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
5	3	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
6	3	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
7	4	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
8	4	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
9	5	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
10	5	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
11	6	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
12	6	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
13	7	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
14	7	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
15	8	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
16	8	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
17	9	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
18	9	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
19	10	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
20	10	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
21	11	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
22	11	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
23	12	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
24	12	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
25	13	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
26	13	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
27	14	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
28	14	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
29	15	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
30	15	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
31	16	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
32	16	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
33	17	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
34	17	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
35	18	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
36	18	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
37	19	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
38	19	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
39	20	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
40	20	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
41	21	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
42	21	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
45	9	test 3	\N	\N	\N	\N	t
44	9	test 2	\N	\N	\N	\N	t
43	9	test	\N	\N	\N	\N	t
56	32	Meat Stew	¼ cup all-purpose flour,\n¼ teaspoon freshly ground pepper,\n1 pound beef stewing meat trimmed and cut into inch cubes,\n5 teaspoons vegetable oil,\n2 tablespoons red wine vinegar,\n1 cup red wine,\n3 ½ cups beef broth homemade or low-sodium canned,\n2 bay leaves,\n1 medium onion peeled and chopped,\n5 medium carrots peeled and cut into 1/4-inch rounds,\n2 large baking potatoes peeled and cut into 3/4-inch cubes,\n2 teaspoons salt	160	4	http://res.cloudinary.com/deglaze/image/upload/v1599798588/cuca/iksrqfbi7yepwcnwgq4d.jpg	f
46	9	test		\N	\N	\N	f
47	21	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
48	21	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
49	21	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
50	21	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
51	30	Skillet Pork Chops	2 (about 1-inch thick) bone-in pork loin rib chops (8 to 10 ounces each),\n2 1/2 cups apple cider or unfiltered apple juice divided,\n1 cup water,\n1/2 cup Diamond Crystal kosher salt (2 1/2 ounces),\n1 large sweet-tart apple such as Honeycrisp or Pink Lady,\n1 small yellow onion,\n4 cloves garlic,\n1 teaspoon canola or other neutral oil,\n4 sprigs fresh thyme,	20 mins	4	http://res.cloudinary.com/deglaze/image/upload/v1599795366/cuca/pv8sdj3xsww6donnkuls.jpg	f
52	30	Fried Chicken	6 c. low-fat buttermilk divided,\n1/4 c. sugar,\n2 cloves garlic thinly sliced,\n4 Tbsp celery seed divided,\nKosher salt and pepper,\n1 5- to 6-lb whole chicken cut into 10 pieces,\n2 c. all-purpose flour,\n1/2 tsp. cayenne,\n4 c. peanut or canola oil for frying	60 mins	10	http://res.cloudinary.com/deglaze/image/upload/v1599795724/cuca/scplbfjkym7aorgahdqa.jpg	f
53	29	Glazed Salmon	4 (6 oz each) salmon filets,\n1/2 tsp kosher salt,\n1/2 tsp black pepper,\n1/2 tsp smoked paprika - (or regular paprika)	20 mins	4	http://res.cloudinary.com/deglaze/image/upload/v1599795972/cuca/w71zoz6mxinz9qyoilwz.jpg	f
54	31	Apple Pie	6 medium apples, peeled, cored and sliced  (I prefer to use Macintosh apples),\n1/2 cup to 3/4 sugar,\n2 – 3 tbsp flour,\n1/2 tsp cinnamon,\n1/8 tsp salt,\n2 cups flour,\n1/2 tsp salt,\n2/3 cup shortening (lard),\n1/4 cup water	65 mins	8	http://res.cloudinary.com/deglaze/image/upload/v1599797467/cuca/oahlz8y55qzxoaqwir12.jpg	f
58	33	Orange Cake	3 cups all purpose flour,\n1 tsp baking powder,\n1/2 tsp baking soda,\n1/2 tsp salt,\n1 1/2 cups butter (salted or unsalted) softened,\n3 cups granulated sugar divided,\n2 tsp pure vanilla extract,\n1/3 cup fresh orange zest,\n6 large eggs,\n1 cup fresh orange juice divided,\n1/2 cup milk or half and half,\n1 cup powdered sugar,\n1/4 cup fresh orange juice,\n1-2 Tbsp fresh orange zest	6 hrs	12	http://res.cloudinary.com/deglaze/image/upload/v1599799221/cuca/cz90flhgjw8zwrogfxhi.jpg	f
55	32	Veggie Pot Pie	1 cup carrots chopped,\n1 potato peeled and cubed,\n½ cup celery chopped,\n1 cup frozen peas,\n1/3 cup butter,\n⅓ cup onion,\n2 cloves garlic pressed,\n⅓ cup flour,\n½ tsp salt,\n¼ tsp pepper,\n¼ tsp celery seed,\n1¾ cup vegetable broth,\n⅔ cup unsweetened plain almond milk,\n2 unbaked pie crusts	75 mins	6	http://res.cloudinary.com/deglaze/image/upload/v1599798351/cuca/xsjnaphz2sw38uwjklfz.jpg	f
57	32	Biscuits	all-purpose flour,\nsugar,\nsalt,\nbaking powder,\ncream of tartar,\nCOLD butter,\negg,\nmilk	15 mins	12	http://res.cloudinary.com/deglaze/image/upload/v1599798759/cuca/d68l96dpcm2vgiprunw6.jpg	f
59	33	Carrot Cake	2 cups (250 grams) all-purpose flour,\n2 teaspoons baking soda,\n1/2 teaspoon fine sea salt,\n1 1/2 teaspoons ground cinnamon,\n1 1/4 cups (295 ml) canola or other vegetable oil,\n1 cup (200 grams) granulated sugar,\n1 cup (200 grams) lightly packed brown sugar,\n1 teaspoon vanilla extract,\n4 large eggs,\n3 cups (300 grams) grated peeled carrots (5 to 6 medium carrots),\n1 cup (100 grams) coarsely chopped pecans,\n1/2 cup (65 grams) raisins,\n8 ounces (225 grams) cream cheese, at room temperature,\n1 1/4 cups (140 grams) powdered sugar,\n1/3 cup (80 ml) heavy whipping cream,\n1/2 cup (50 grams) coarsely chopped pecans for topping cake	60 mins	12	http://res.cloudinary.com/deglaze/image/upload/v1599799429/cuca/g4bvuqp6lyv2orz6p6zc.jpg	f
60	38	Baked Apple	\N	\N	\N	\N	f
61	38	Monster Cake	\N	\N	\N	\N	f
63	27	Skillet Pork Chops	2 (about 1-inch thick) bone-in pork loin rib chops (8 to 10 ounces each),\n2 1/2 cups apple cider or unfiltered apple juice divided,\n1 cup water,\n1/2 cup Diamond Crystal kosher salt (2 1/2 ounces),\n1 large sweet-tart apple such as Honeycrisp or Pink Lady,\n1 small yellow onion,\n4 cloves garlic,\n1 teaspoon canola or other neutral oil,\n4 sprigs fresh thyme,	20 mins	4	http://res.cloudinary.com/deglaze/image/upload/v1599795366/cuca/pv8sdj3xsww6donnkuls.jpg	f
62	27	Monster Cake	\N	\N	\N	\N	t
64	27	Monster Cake	\N	\N	\N	\N	t
65	27	Monster Cake	Monster extract, eggs, durian	5 mins	1	http://res.cloudinary.com/deglaze/image/upload/v1599805436/cuca/tvrvnvw08ylontfqv8zz.jpg	f
66	27	Biscuits	all-purpose flour,\nsugar,\nsalt,\nbaking powder,\ncream of tartar,\nCOLD butter,\negg,\nmilk	15 mins	12	http://res.cloudinary.com/deglaze/image/upload/v1599798759/cuca/d68l96dpcm2vgiprunw6.jpg	t
67	27	Meat Stew	¼ cup all-purpose flour,\n¼ teaspoon freshly ground pepper,\n1 pound beef stewing meat trimmed and cut into inch cubes,\n5 teaspoons vegetable oil,\n2 tablespoons red wine vinegar,\n1 cup red wine,\n3 ½ cups beef broth homemade or low-sodium canned,\n2 bay leaves,\n1 medium onion peeled and chopped,\n5 medium carrots peeled and cut into 1/4-inch rounds,\n2 large baking potatoes peeled and cut into 3/4-inch cubes,\n2 teaspoons salt	160	4	http://res.cloudinary.com/deglaze/image/upload/v1599798588/cuca/iksrqfbi7yepwcnwgq4d.jpg	f
\.


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.steps (step_id, recipe_id, step_number, body, media) FROM stdin;
1	1	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
2	1	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
3	1	3	Add another layer of cheese, and then sprinkle with pepper.	\N
4	1	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
5	2	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
6	2	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
7	2	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
8	2	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
9	3	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
10	3	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
11	3	3	Add another layer of cheese, and then sprinkle with pepper.	\N
12	3	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
13	4	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
14	4	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
15	4	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
16	4	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
17	5	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
18	5	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
19	5	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
20	5	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
21	6	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
22	6	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
23	6	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
24	6	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
25	7	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
26	7	2	minutes, or until dough is fluffy and golden brown.	\N
27	7	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
28	7	4	When on Social Media, the Pink	\N
29	7	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
30	7	6	Email	\N
31	7	7	Address	\N
32	7	8	Subscribe	\N
33	7	9	Powered by Convert	\N
34	7	10	Kit	\N
35	8	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
36	8	2	minutes, or until dough is fluffy and golden brown.	\N
37	8	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
38	8	4	When on Social Media, the Pink	\N
39	8	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
40	8	6	Email	\N
41	8	7	Address	\N
42	8	8	Subscribe	\N
43	8	9	Powered by Convert	\N
44	8	10	Kit	\N
45	9	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
46	9	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
47	9	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
48	9	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
49	9	5	Pile on the steak and vegetables.	\N
50	9	6	Roll up, making sure the ends are sealed.	\N
51	9	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
52	9	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
53	9	9	Enjoy the happy faces around you :)	\N
54	10	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
55	10	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
56	10	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
57	10	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
58	10	5	Pile on the steak and vegetables.	\N
59	10	6	Roll up, making sure the ends are sealed.	\N
60	10	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
61	10	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
62	10	9	Enjoy the happy faces around you :)	\N
63	11	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
64	11	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
65	11	3	Add another layer of cheese, and then sprinkle with pepper.	\N
66	11	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
67	12	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
68	12	2	minutes, or until dough is fluffy and golden brown.	\N
69	12	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
70	12	4	When on Social Media, the Pink	\N
71	12	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
72	12	6	Email	\N
73	12	7	Address	\N
74	12	8	Subscribe	\N
75	12	9	Powered by Convert	\N
76	12	10	Kit	\N
77	13	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
78	13	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
79	13	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
80	13	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
81	13	5	Pile on the steak and vegetables.	\N
82	13	6	Roll up, making sure the ends are sealed.	\N
83	13	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
84	13	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
85	13	9	Enjoy the happy faces around you :)	\N
86	14	1	Preheat oven to 375	\N
87	14	2	Combine all ingredients in a medium bowl.	\N
88	14	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
89	14	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
90	14	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
91	15	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
92	15	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
93	15	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
94	15	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
95	15	5	Pile on the steak and vegetables.	\N
96	15	6	Roll up, making sure the ends are sealed.	\N
97	15	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
98	15	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
99	15	9	Enjoy the happy faces around you :)	\N
100	16	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
101	16	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
102	16	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
103	16	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
104	16	5	Pile on the steak and vegetables.	\N
105	16	6	Roll up, making sure the ends are sealed.	\N
106	16	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
107	16	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
108	16	9	Enjoy the happy faces around you :)	\N
109	17	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
110	17	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
111	17	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
112	17	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
113	17	5	Pile on the steak and vegetables.	\N
114	17	6	Roll up, making sure the ends are sealed.	\N
178	26	3	Add another layer of cheese, and then sprinkle with pepper.	\N
179	26	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
115	17	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
116	17	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
117	17	9	Enjoy the happy faces around you :)	\N
122	19	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
123	19	2	minutes, or until dough is fluffy and golden brown.	\N
124	19	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
125	19	4	When on Social Media, the Pink	\N
126	19	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
127	19	6	Email	\N
128	19	7	Address	\N
129	19	8	Subscribe	\N
130	19	9	Powered by Convert	\N
131	19	10	Kit	\N
132	20	1	Preheat oven to 375	\N
133	20	2	Combine all ingredients in a medium bowl.	\N
134	20	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
135	20	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
136	20	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
137	21	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
138	21	2	minutes, or until dough is fluffy and golden brown.	\N
139	21	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
140	21	4	When on Social Media, the Pink	\N
141	21	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
142	21	6	Email	\N
143	21	7	Address	\N
144	21	8	Subscribe	\N
145	21	9	Powered by Convert	\N
146	21	10	Kit	\N
147	22	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
148	22	2	minutes, or until dough is fluffy and golden brown.	\N
149	22	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
150	22	4	When on Social Media, the Pink	\N
151	22	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
152	22	6	Email	\N
153	22	7	Address	\N
154	22	8	Subscribe	\N
155	22	9	Powered by Convert	\N
156	22	10	Kit	\N
157	23	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
158	23	2	minutes, or until dough is fluffy and golden brown.	\N
159	23	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
160	23	4	When on Social Media, the Pink	\N
161	23	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
162	23	6	Email	\N
163	23	7	Address	\N
164	23	8	Subscribe	\N
165	23	9	Powered by Convert	\N
166	23	10	Kit	\N
167	24	1	Preheat oven to 375	\N
168	24	2	Combine all ingredients in a medium bowl.	\N
169	24	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
170	24	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
171	24	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
172	25	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
173	25	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
174	25	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
175	25	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
176	26	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
177	26	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
180	27	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
181	27	2	minutes, or until dough is fluffy and golden brown.	\N
182	27	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
183	27	4	When on Social Media, the Pink	\N
184	27	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
185	27	6	Email	\N
186	27	7	Address	\N
187	27	8	Subscribe	\N
188	27	9	Powered by Convert	\N
189	27	10	Kit	\N
190	28	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
191	28	2	minutes, or until dough is fluffy and golden brown.	\N
192	28	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
193	28	4	When on Social Media, the Pink	\N
194	28	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
195	28	6	Email	\N
196	28	7	Address	\N
197	28	8	Subscribe	\N
198	28	9	Powered by Convert	\N
199	28	10	Kit	\N
200	29	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
201	29	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
202	29	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
203	29	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
204	29	5	Pile on the steak and vegetables.	\N
205	29	6	Roll up, making sure the ends are sealed.	\N
206	29	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
207	29	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
208	29	9	Enjoy the happy faces around you :)	\N
209	30	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
210	30	2	minutes, or until dough is fluffy and golden brown.	\N
211	30	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
212	30	4	When on Social Media, the Pink	\N
213	30	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
214	30	6	Email	\N
215	30	7	Address	\N
216	30	8	Subscribe	\N
217	30	9	Powered by Convert	\N
218	30	10	Kit	\N
219	31	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
220	31	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
221	31	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
222	31	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
223	31	5	Pile on the steak and vegetables.	\N
224	31	6	Roll up, making sure the ends are sealed.	\N
225	31	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
226	31	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
227	31	9	Enjoy the happy faces around you :)	\N
228	32	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
229	32	2	minutes, or until dough is fluffy and golden brown.	\N
230	32	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
231	32	4	When on Social Media, the Pink	\N
232	32	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
233	32	6	Email	\N
234	32	7	Address	\N
235	32	8	Subscribe	\N
236	32	9	Powered by Convert	\N
237	32	10	Kit	\N
238	33	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
239	33	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
240	33	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
241	33	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
242	33	5	Pile on the steak and vegetables.	\N
243	33	6	Roll up, making sure the ends are sealed.	\N
244	33	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
245	33	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
246	33	9	Enjoy the happy faces around you :)	\N
247	34	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
248	34	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
249	34	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
250	34	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
251	34	5	Pile on the steak and vegetables.	\N
252	34	6	Roll up, making sure the ends are sealed.	\N
253	34	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
254	34	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
255	34	9	Enjoy the happy faces around you :)	\N
256	35	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
257	35	2	minutes, or until dough is fluffy and golden brown.	\N
258	35	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
259	35	4	When on Social Media, the Pink	\N
260	35	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
261	35	6	Email	\N
262	35	7	Address	\N
263	35	8	Subscribe	\N
264	35	9	Powered by Convert	\N
265	35	10	Kit	\N
266	36	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
267	36	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
268	36	3	Add another layer of cheese, and then sprinkle with pepper.	\N
269	36	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
270	37	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
271	37	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
272	37	3	Add another layer of cheese, and then sprinkle with pepper.	\N
273	37	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
274	38	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
275	38	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
276	38	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
277	38	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
278	39	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
279	39	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
280	39	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
281	39	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
282	40	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
283	40	2	minutes, or until dough is fluffy and golden brown.	\N
284	40	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
285	40	4	When on Social Media, the Pink	\N
286	40	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
287	40	6	Email	\N
288	40	7	Address	\N
289	40	8	Subscribe	\N
290	40	9	Powered by Convert	\N
291	40	10	Kit	\N
296	41	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
297	41	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
298	41	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
299	41	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
300	41	5	Pile on the steak and vegetables.	\N
304	41	9	Enjoy the happy faces around you :)	\N
307	42	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
314	43	1		
560	66	4	Add in the milk and egg and mix just until the ingredients are combined. The dough will be sticky but don't keep working it. You should be able to see the butter pieces in the dough.	
564	66	8	Place the biscuits on a lightly greased baking sheet or parchment lined baking sheet and bake for 10 to 15 minutes or until golden brown on top.	
566	67	1	Combine the flour and pepper in a bowl, add the beef and toss to coat well. Heat 3 teaspoons of the oil in a large pot. Add the beef a few pieces at a time; do not overcrowd. Cook, turning the pieces until beef is browned on all sides, about 5 minutes per batch; add more oil as needed between batches.	
581	65	1	Combine ingredients in a wok over a campfire	
301	41	6	Roll up, making sure the ends are sealed.	\N
306	42	2	Combine all ingredients in a medium bowl.	\N
557	66	1	Preheat oven to 400 F	
561	66	5	The secret to excellent biscuits is COLD BUTTER. Really cold. Many times the biscuit dough gets worked so much that the butter softens before the biscuits even go in the oven. Try cutting the butter into small pieces and stick back in the fridge pulling out only when ready to incorporate into the dough.	
565	66	9	Brush with butter and enjoy!	http://res.cloudinary.com/deglaze/image/upload/v1599860936/cuca/mxztqlgq2ralvyufmmev.jpg
567	67	2	Remove the beef from the pot and add the vinegar and wine. Cook over medium-high heat, scraping the pan with a wooden spoon to loosen any browned bits. Add the beef, beef broth and bay leaves. Bring to a boil, then reduce to a slow simmer.	
583	65	3	Let it bounce around for a while	
302	41	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
308	42	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
315	44	1		
559	66	3	Use a pastry cutter to cut cold butter into flour mixture. Don't go too crazy here - you want to see small, pea-sized pieces of butter throughout the dough. 	http://res.cloudinary.com/deglaze/image/upload/v1599799049/cuca/pca2w6zm3h8hqvpitead.jpg
563	66	7	Pat the dough out to 3/4 - 1 inch thickness and cut with a biscuit cutter or glass. I ended up with nine this time but depending on who is snacking on biscuit dough, I can get up to 12 biscuits. 	http://res.cloudinary.com/deglaze/image/upload/v1599799083/cuca/m0oj7ztop2zpestp7vla.jpg
568	67	3	Cover and cook, skimming broth from time to time, until the beef is tender, about 1 1/2 hours. Add the onions and carrots and simmer, covered, for 10 minutes. Add the potatoes and simmer until vegetables are tender, about 30 minutes more. Add broth or water if the stew is dry. Season with salt and pepper to taste. Ladle among 4 bowls and serve.	
582	65	2	Enjoy!	
303	41	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
305	42	1	Preheat oven to 375	\N
309	42	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
316	45	1		
319	46	1		
320	18	1	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	http://res.cloudinary.com/deglaze/image/upload/v1599765616/cuca/fdktggxmh2gyyqkj5xpb.jpg
321	18	2	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
322	18	3	Add another layer of cheese, and then sprinkle with pepper.	\N
323	18	4	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
342	47	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	http://res.cloudinary.com/deglaze/image/upload/v1599766211/cuca/uila4q7aljuij4jutwej.jpg
343	47	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
344	47	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
345	47	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
346	47	5	Pile on the steak and vegetables.	\N
347	47	6	Roll up, making sure the ends are sealed.	\N
348	47	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
349	47	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
350	47	9	Enjoy!	
351	48	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
352	48	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
353	48	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
354	48	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
355	49	1	Preheat oven to 375	\N
356	49	2	Combine all ingredients in a medium bowl.	\N
357	49	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
358	49	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
359	49	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
360	50	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
361	50	2	minutes, or until dough is fluffy and golden brown.	\N
362	50	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
363	50	4	When on Social Media, the Pink	\N
364	50	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
365	50	6	Email	\N
366	50	7	Address	\N
367	50	8	Subscribe	\N
368	50	9	Powered by Convert	\N
369	50	10	Kit	\N
371	51	1	Prick 2 pork chops all over with a fork about 1/8-inch deep. Flip the pork chops and repeat pricking the other side.	
372	51	2	Place 2 cups of the apple cider, 1 cup water, and 1/2 cup kosher salt in a gallon-size zip-top bag, seal the bag, and massage to dissolve the salt. Add the pork chops and seal the bag. Place the bag on a rimmed baking sheet and arrange the pork chops so they sit in a single layer. Let brine at room temperature for 30 minutes, or refrigerate for up to 8 hours.	
373	51	3	When ready to cook, core and cut 1 large apple into 1/4-inch thick slices, cut 1 small yellow onion into 1/2-inch wedges, and peel and smash 4 cloves garlic. Remove the pork chops from the brine and pat dry with paper towels.	
374	51	4	Heat a large cast-iron skillet over medium-high heat until just beginning to smoke. Add the pork chops and cook until they begin to brown, about 1 minute on each side.	
375	51	5	Reduce the heat to medium. Continue to cook, flipping the chops every minute, until they register 140 to 145°F in the thickest part, 6 to 8 minutes more. Transfer the pork chops to a clean plate.	
376	51	6	Add 1 teaspoon canola or other neutral oil to the pan. Add the onion, garlic, and 4 sprigs fresh thyme, and cook until onion begins to soften and brown, 3 to 4 minutes. Add the apples and remaining 1/2 cup apple cider and nestle the chops on top. Cook until the apples are warm and tender but not falling apart, 3 to 4 minutes.	
377	52	1	In large bowl, whisk together 4 cups buttermilk, sugar, garlic, 2 tablespoons celery seed, and 1/2 cup salt. Add chicken and toss to coat. Cover and refrigerate 1 hour.	
378	52	2	Meanwhile, in large bowl, whisk together flour, cayenne, 1 teaspoon salt, 1 tablespoon pepper, and remaining 2 tablespoons celery seed.	
379	52	3	Attach deep-fry thermometer to large Dutch oven and heat oil on medium to 325°F. Place remaining 2 cups buttermilk in second bowl. Working with a couple of pieces at a time, remove chicken from marinade, letting excess drip off. Coat in flour, shaking off excess, then coat in buttermilk and then in flour once more. Shake off excess flour and add chicken to oil.	
380	52	4	Fry chicken until golden brown and cooked through, 4 to 10 minutes depending on piece. Repeat with remaining chicken, adjusting heat to maintain oil temperature between 300°F and 325°F. 	
381	53	1		
558	66	2	Combine the dry ingredients in a large bowl.	
562	66	6	Turn the dough out onto a generously floured surface. Sprinkle some flour on to the top of dough so it won't stick to your fingers and knead 10-15 times. If the dough is super sticky just sprinkle on some additional flour.	
415	54	1	Preheat your oven to 425 degrees.	http://res.cloudinary.com/deglaze/image/upload/v1599797918/cuca/d0qb078wextavzq9tj49.jpg
432	55	1	Boil a pot of water and add your chopped potato, carrot and celery and boil gently for about 15 minutes. When there are 2 minutes left on the timer, add your frozen peas to the mix.	
433	55	2	In a large skillet over medium heat, melt the butter and cook your onions and garlic for about 2 minutes. Then, stir in the flour, salt, pepper and celery seed.	
434	55	3	Slowly whisk in your veggie broth and then your unsweetened plain almond milk. Whisk for about 5 minutes until thickened.	
435	55	4	Place your bottom crust into pie dish and pre-bake for 5 minutes.	
436	55	5	Add your boiled veggies to the 'sauce' skillet and mix gently to combine.	
437	55	6	Add your filling into bottom pie crust.	
438	55	7	Cover with top pie crust, seal edges and then cut several small slits into the top of the pie crust to allow steam to escape.	
439	55	8	Bake in the preheated oven for about 30 minutes or until pastry is golden brown and filling is bubbly.\nRemove your pie from the oven and allow it to cool for 10 minutes before serving. Enjoy:)	
440	56	1	Combine the flour and pepper in a bowl, add the beef and toss to coat well. Heat 3 teaspoons of the oil in a large pot. Add the beef a few pieces at a time; do not overcrowd. Cook, turning the pieces until beef is browned on all sides, about 5 minutes per batch; add more oil as needed between batches.	
441	56	2	Remove the beef from the pot and add the vinegar and wine. Cook over medium-high heat, scraping the pan with a wooden spoon to loosen any browned bits. Add the beef, beef broth and bay leaves. Bring to a boil, then reduce to a slow simmer.	
442	56	3	Cover and cook, skimming broth from time to time, until the beef is tender, about 1 1/2 hours. Add the onions and carrots and simmer, covered, for 10 minutes. Add the potatoes and simmer until vegetables are tender, about 30 minutes more. Add broth or water if the stew is dry. Season with salt and pepper to taste. Ladle among 4 bowls and serve.	
451	57	1	The secret to excellent biscuits is COLD BUTTER. Really cold. Many times the biscuit dough gets worked so much that the butter softens before the biscuits even go in the oven. Try cutting the butter into small pieces and stick back in the fridge pulling out only when ready to incorporate into the dough.	
452	57	2	Combine the dry ingredients in a large bowl. 	
453	57	3	Use a pastry cutter to cut cold butter into flour mixture. Don't go too crazy here - you want to see small, pea-sized pieces of butter throughout the dough. 	http://res.cloudinary.com/deglaze/image/upload/v1599799049/cuca/pca2w6zm3h8hqvpitead.jpg
454	57	4	Add in the milk and egg and mix just until the ingredients are combined. The dough will be sticky but don't keep working it. You should be able to see the butter pieces in the dough.	
455	57	5	Turn the dough out onto a generously floured surface. Sprinkle some flour on to the top of dough so it won't stick to your fingers and knead 10-15 times. If the dough is super sticky just sprinkle on some additional flour.	
456	57	6	Pat the dough out to 3/4 - 1 inch thickness and cut with a biscuit cutter or glass. I ended up with nine this time but depending on who is snacking on biscuit dough, I can get up to 12 biscuits. 	http://res.cloudinary.com/deglaze/image/upload/v1599799083/cuca/m0oj7ztop2zpestp7vla.jpg
457	57	7	Place the biscuits on a lightly greased baking sheet or parchment lined baking sheet and bake for 10 to 15 minutes or until golden brown on top.	
458	57	8	Brush with butter and enjoy!	
459	58	1	Preheat oven to 325°F. Grease and flour a standard 10-15 cup bundt pan, or spray with baking spray. Set aside.	
460	59	1	Heat the oven to 350 degrees Fahrenheit (176C). Grease two 9-inch round cake pans and line the bottom with parchment paper then grease the top of the paper. Or, grease and flour the bottom and sides of both pans.	
461	59	2	In a medium bowl, whisk flour, baking soda, salt, and the cinnamon until well blended.	
462	59	3	In a separate bowl, whisk the oil, sugars, and vanilla. Whisk in eggs, one at a time, until combined.	
463	59	4	Switch to a large rubber spatula. Scrape the sides and bottom of the bowl then add the dry ingredients in 3 parts, gently stirring until they disappear and the batter is smooth. Stir in the carrots, nuts, and raisins.	
464	59	5	Divide the batter between the prepared cake pans. Bake until the tops of the cake layers are springy when touched and when a toothpick inserted into the center of the cake comes out clean, 35 to 45 minutes.	
465	59	6	Cool cakes in pans for 15 minutes then turn out onto cooling racks, peel off parchment paper and cool completely. (If you find that a cake layer is stuck to the bottom of the pan, leave the cake pan upside down and allow gravity to do its thing).	
466	59	7	In a large bowl, beat cream cheese with a handheld mixer on medium speed until creamy, about 1 minute.	
467	59	8	Beat in the powdered sugar, a 1/4 cup at a time until fluffy. Pour in cream and beat on medium speed for 1 minute. Chill covered until ready to frost cake.	
473	63	2	Place 2 cups of the apple cider, 1 cup water, and 1/2 cup kosher salt in a gallon-size zip-top bag, seal the bag, and massage to dissolve the salt. Add the pork chops and seal the bag. Place the bag on a rimmed baking sheet and arrange the pork chops so they sit in a single layer. Let brine at room temperature for 30 minutes, or refrigerate for up to 8 hours.	
477	63	6	Add 1 teaspoon canola or other neutral oil to the pan. Add the onion, garlic, and 4 sprigs fresh thyme, and cook until onion begins to soften and brown, 3 to 4 minutes. Add the apples and remaining 1/2 cup apple cider and nestle the chops on top. Cook until the apples are warm and tender but not falling apart, 3 to 4 minutes.	
478	64	1		
468	59	9	When the cake layers are completely cool, frost the top of one cake layer, place the other cake layer on top. Decoratively swirl the top of the cake with remaining frosting, leaving the sides unfrosted. Scatter nuts on top.	
469	60	1		
470	61	1		
471	62	1		
472	63	1	Prick 2 pork chops all over with a fork about 1/8-inch deep. Flip the pork chops and repeat pricking the other side.	
474	63	3	When ready to cook, core and cut 1 large apple into 1/4-inch thick slices, cut 1 small yellow onion into 1/2-inch wedges, and peel and smash 4 cloves garlic. Remove the pork chops from the brine and pat dry with paper towels.	
475	63	4	Heat a large cast-iron skillet over medium-high heat until just beginning to smoke. Add the pork chops and cook until they begin to brown, about 1 minute on each side.	
476	63	5	Reduce the heat to medium. Continue to cook, flipping the chops every minute, until they register 140 to 145°F in the thickest part, 6 to 8 minutes more. Transfer the pork chops to a clean plate.	
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.users (user_id, fname, lname, email, password, profile_picture) FROM stdin;
1	Thomas	Weber	TWeber@email.com	$2b$12$a5rxCS0RdXNOeK6ZRk5CEuGs9swdqkPjy1d3kZe4Ck7uS8jr3xlLO	/static/img/chef_hat.png
2	Chad	Nunez	CNunez@email.com	$2b$12$FKVH5cf/WdAUXlY6I0dKgueYAYmTUJ6WOp/LVX/o.i06yBoLu1bC6	/static/img/chef_hat.png
3	Hector	Wilson	HWilson@email.com	$2b$12$za0e6qzA5/Fv1g462uEyj.L/wfIIsjH2OHG0/q3XyETGAQ3dIBgiC	/static/img/chef_hat.png
4	Daniel	Barton	DBarton@email.com	$2b$12$yo52UfKuYZV7/bxWy3NV7uLNFYIp.NvGyXrc2drhoM50m.CqRw9sK	/static/img/chef_hat.png
5	Michael	Orr	MOrr@email.com	$2b$12$4LLxwAo02KlmIDjaJ0GJIucCDn4Hhw4QmTX53ELo5V6YUSy3SnES6	/static/img/chef_hat.png
6	Daniel	Levine	DLevine@email.com	$2b$12$4vZqSMtxRLIkKuTriVlTvuPLKwcfSaWaa.DY9OJIijZ/3tsGXWUai	/static/img/chef_hat.png
7	Kristin	Yates	KYates@email.com	$2b$12$uvvw20HX2C9z5an7Jx3eyOrOa8d6QvWujTfpTNQnZ9vNu1qrlyRt6	/static/img/chef_hat.png
8	Tracy	Davenport	TDavenport@email.com	$2b$12$a2bT3pkAukpspVBQZ/4ure1BXxQkxQ/ItU6vki0rhKL6nuiNpfp.O	/static/img/chef_hat.png
9	Joshua	Ward	JWard@email.com	$2b$12$D6XcAGfRso/DYNbi4xzh3ect9j4ch4rZu3CU9Bj8XYGiDWYQ5QXg2	/static/img/chef_hat.png
10	Donna	Juarez	DJuarez@email.com	$2b$12$5st/e6fJA5oEnQglz16CZucZHad3rcXbwBrh6.4PudB1oPJQ1P2Tq	/static/img/chef_hat.png
11				$2b$12$ui4fPiys4YRMp.O5y/xtuuTfn5qZpYWle2yvTyc6Oibgw8RRP4nte	/static/img/chef_hat.png
12			test@new.come	$2b$12$S6miGF6MK4TENmR23soMF.R6T1g3raA0ufUbLdl.QYNj5vSx1TEu6	/static/img/chef_hat.png
13			test	$2b$12$mN3cZRiG8N6pLALzs.azf.gTQNjk2O9JXqxUfwe6Eu6lj7TevNzaC	/static/img/chef_hat.png
14	Atul	Uncle	atul@spiritfarer.com	$2b$12$8KM.i.DsGP2Qy3rP1ya.9OeEZSENFk9whnKysh7N2VyjMtM60PA/6	/static/img/chef_hat.png
15	Stella	Spiritfarer	Stella@mail.box	$2b$12$tKDZSfSMvFE9k3l.kVSGtuzpguSrfqfb16Tnl.NU21dGP98sDZJq.	http://res.cloudinary.com/deglaze/image/upload/v1599791965/cuca/n4j9qxrlzmfte8atfjr0.jpg
16	Atul		Atul@mail.box	$2b$12$1Su2bbbLQ/ZmAfRnF.g/tO63EyV8smMatlj.B68f2i5IzBZMwbYDG	http://res.cloudinary.com/deglaze/image/upload/v1599794970/cuca/smeckmzcrsjywxitkpu4.png
17	Alice		Alice@mail.box	$2b$12$1693YxVbh0lOm4Z2XWS3m.iINzCZc/VCk/eJUr/utZlvHxuI4f9r6	http://res.cloudinary.com/deglaze/image/upload/v1599796040/cuca/obzjqbetucdlqjshyzyq.png
18	Gwen		Gwen@mail.box	$2b$12$pvgCqkQvOQfbzjTXKFap3.roSVW7DDfaXY.3eTpoigAndVRVc18wW	http://res.cloudinary.com/deglaze/image/upload/v1599796092/cuca/labvweyqlrrov1s8l2le.png
19	Astrid		Astrid@mail.box	$2b$12$9vuwKRrmcEoAZY3vszsW/eLiCHSD5i/1eZdXI7Kgx76WveRwR0NG6	http://res.cloudinary.com/deglaze/image/upload/v1599796139/cuca/veeubo0gsh8hp6fvld3j.png
20	Giovanni		Gio@mail.box	$2b$12$fMu68ba7Rmz/RGQmdi9m2OvXOIyS3aJqQEgo7vrIjmLr758jjaTQ6	http://res.cloudinary.com/deglaze/image/upload/v1599800361/cuca/fdfpijpgdmed7czfsdqi.png
21	Link	Champion	Link@Hyrule.com	$2b$12$Q036LkE3tIzFxaYN.n4Mb.e7qH3qAi9qvV.wQrqN1RF5l68eTC45i	http://res.cloudinary.com/deglaze/image/upload/v1599800737/cuca/cjlhckec2hptkhdjn9d3.jpg
22	Sidon		Sidon@Hyrule.com	$2b$12$X5LlmAWsRnVjcM8LksMta.JV8JQRthxcHh5LF4zkg5kYGkF5juVRa	http://res.cloudinary.com/deglaze/image/upload/v1599802707/cuca/fezxzhlrvwq5jcpfrnjq.jpg
23	Zelda		Zelda@Hyrule.com	$2b$12$3txCe63TKe7dqV9wL77cfeZvgp8PREoCstYDciauTSTcp38GdZn36	http://res.cloudinary.com/deglaze/image/upload/v1599802759/cuca/qiutbxyb6uuys08lp7bi.png
\.


--
-- Name: connections_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.connections_connection_id_seq', 28, true);


--
-- Name: cookbooks_cookbook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.cookbooks_cookbook_id_seq', 40, true);


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.recipes_recipe_id_seq', 67, true);


--
-- Name: steps_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.steps_step_id_seq', 583, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.users_user_id_seq', 23, true);


--
-- Name: connections connections_pkey; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_pkey PRIMARY KEY (connection_id);


--
-- Name: cookbooks cookbooks_pkey; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.cookbooks
    ADD CONSTRAINT cookbooks_pkey PRIMARY KEY (cookbook_id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (step_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: connections connections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.connections
    ADD CONSTRAINT connections_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: cookbooks cookbooks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.cookbooks
    ADD CONSTRAINT cookbooks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: recipes recipes_cookbook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_cookbook_id_fkey FOREIGN KEY (cookbook_id) REFERENCES public.cookbooks(cookbook_id);


--
-- Name: steps steps_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fernanda
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- PostgreSQL database dump complete
--

