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
2	2	4
3	3	4
4	4	5
5	5	7
6	6	3
7	7	5
8	8	2
9	9	6
10	10	5
\.


--
-- Data for Name: cookbooks; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.cookbooks (cookbook_id, title, cover_img, user_id, deleted) FROM stdin;
1	Breakfast	/static/img/cooking_2.jpg	1	f
2	Dinner	/static/img/cooking_1.jpg	1	f
3	Dinner	/static/img/cooking_2.jpg	2	f
4	Dinner	/static/img/cooking_1.jpg	2	f
5	Breakfast	/static/img/cooking_3.jpg	3	f
6	Lunch	/static/img/cooking_4.jpg	3	f
7	Dinner	/static/img/cooking_4.jpg	4	f
8	Lunch	/static/img/cooking_6.jpg	4	f
9	Dessert	/static/img/cooking_7.jpg	5	f
10	Lunch	/static/img/cooking_2.jpg	5	f
11	Dinner	/static/img/cooking_2.jpg	6	f
12	Breakfast	/static/img/cooking_2.jpg	6	f
13	Dessert	/static/img/cooking_3.jpg	7	f
14	Dessert	/static/img/cooking_2.jpg	7	f
15	Breakfast	/static/img/cooking_1.jpg	8	f
16	Dessert	/static/img/cooking_1.jpg	8	f
17	Dinner	/static/img/cooking_4.jpg	9	f
18	Lunch	/static/img/cooking_7.jpg	9	f
19	Breakfast	/static/img/cooking_1.jpg	10	f
20	Breakfast	/static/img/cooking_1.jpg	10	f
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.recipes (recipe_id, cookbook_id, title, ingredients, time_required, servings, media, deleted) FROM stdin;
1	1	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
2	1	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
3	2	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
4	2	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
5	3	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
6	3	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
7	4	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
8	4	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
9	5	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
10	5	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
11	6	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
12	6	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
13	7	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
14	7	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
15	8	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
16	8	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
17	9	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
18	9	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
19	10	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
20	10	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
21	11	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
22	11	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
23	12	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
24	12	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
25	13	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
26	13	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
27	14	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
28	14	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
29	15	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
30	15	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
31	16	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
32	16	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
33	17	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
34	17	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
35	18	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
36	18	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
37	19	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
38	19	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
39	20	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
40	20	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
\.


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.steps (step_id, recipe_id, step_number, body, media) FROM stdin;
1	1	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
2	1	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
3	1	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
4	1	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
5	1	5	Pile on the steak and vegetables.	\N
6	1	6	Roll up, making sure the ends are sealed.	\N
7	1	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
8	1	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
9	1	9	Enjoy the happy faces around you :)	\N
10	2	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
11	2	2	minutes, or until dough is fluffy and golden brown.	\N
12	2	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
13	2	4	When on Social Media, the Pink	\N
14	2	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
15	2	6	Email	\N
16	2	7	Address	\N
17	2	8	Subscribe	\N
18	2	9	Powered by Convert	\N
19	2	10	Kit	\N
20	3	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
21	3	2	minutes, or until dough is fluffy and golden brown.	\N
22	3	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
23	3	4	When on Social Media, the Pink	\N
24	3	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
25	3	6	Email	\N
26	3	7	Address	\N
27	3	8	Subscribe	\N
28	3	9	Powered by Convert	\N
29	3	10	Kit	\N
30	4	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
31	4	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
32	4	3	Add another layer of cheese, and then sprinkle with pepper.	\N
33	4	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
34	5	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
35	5	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
36	5	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
37	5	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
38	6	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
39	6	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
40	6	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
41	6	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
42	7	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
43	7	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
44	7	3	Add another layer of cheese, and then sprinkle with pepper.	\N
45	7	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
46	8	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
47	8	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
48	8	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
49	8	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
50	8	5	Pile on the steak and vegetables.	\N
51	8	6	Roll up, making sure the ends are sealed.	\N
52	8	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
53	8	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
54	8	9	Enjoy the happy faces around you :)	\N
55	9	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
56	9	2	minutes, or until dough is fluffy and golden brown.	\N
57	9	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
58	9	4	When on Social Media, the Pink	\N
59	9	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
60	9	6	Email	\N
61	9	7	Address	\N
62	9	8	Subscribe	\N
63	9	9	Powered by Convert	\N
64	9	10	Kit	\N
65	10	1	Preheat oven to 375	\N
66	10	2	Combine all ingredients in a medium bowl.	\N
67	10	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
68	10	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
69	10	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
70	11	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
71	11	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
72	11	3	Add another layer of cheese, and then sprinkle with pepper.	\N
73	11	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
74	12	1	Preheat oven to 375	\N
75	12	2	Combine all ingredients in a medium bowl.	\N
76	12	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
77	12	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
78	12	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
79	13	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
80	13	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
81	13	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
82	13	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
83	13	5	Pile on the steak and vegetables.	\N
84	13	6	Roll up, making sure the ends are sealed.	\N
85	13	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
86	13	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
87	13	9	Enjoy the happy faces around you :)	\N
88	14	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
89	14	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
90	14	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
91	14	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
92	14	5	Pile on the steak and vegetables.	\N
93	14	6	Roll up, making sure the ends are sealed.	\N
94	14	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
95	14	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
96	14	9	Enjoy the happy faces around you :)	\N
97	15	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
98	15	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
99	15	3	Add another layer of cheese, and then sprinkle with pepper.	\N
100	15	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
101	16	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
102	16	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
103	16	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
104	16	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
105	16	5	Pile on the steak and vegetables.	\N
106	16	6	Roll up, making sure the ends are sealed.	\N
107	16	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
108	16	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
109	16	9	Enjoy the happy faces around you :)	\N
110	17	1	Preheat oven to 375	\N
111	17	2	Combine all ingredients in a medium bowl.	\N
112	17	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
113	17	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
114	17	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
115	18	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
116	18	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
117	18	3	Add another layer of cheese, and then sprinkle with pepper.	\N
180	26	10	Kit	\N
118	18	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
119	19	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
120	19	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
121	19	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
122	19	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
123	20	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
124	20	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
125	20	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
126	20	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
127	21	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
128	21	2	minutes, or until dough is fluffy and golden brown.	\N
129	21	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
130	21	4	When on Social Media, the Pink	\N
131	21	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
132	21	6	Email	\N
133	21	7	Address	\N
134	21	8	Subscribe	\N
135	21	9	Powered by Convert	\N
136	21	10	Kit	\N
137	22	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
138	22	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
139	22	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
140	22	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
141	22	5	Pile on the steak and vegetables.	\N
142	22	6	Roll up, making sure the ends are sealed.	\N
143	22	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
144	22	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
145	22	9	Enjoy the happy faces around you :)	\N
146	23	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
147	23	2	minutes, or until dough is fluffy and golden brown.	\N
148	23	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
149	23	4	When on Social Media, the Pink	\N
150	23	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
151	23	6	Email	\N
152	23	7	Address	\N
153	23	8	Subscribe	\N
154	23	9	Powered by Convert	\N
155	23	10	Kit	\N
156	24	1	Preheat oven to 375	\N
157	24	2	Combine all ingredients in a medium bowl.	\N
158	24	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
159	24	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
160	24	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
161	25	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
162	25	2	minutes, or until dough is fluffy and golden brown.	\N
163	25	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
164	25	4	When on Social Media, the Pink	\N
165	25	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
166	25	6	Email	\N
167	25	7	Address	\N
168	25	8	Subscribe	\N
169	25	9	Powered by Convert	\N
170	25	10	Kit	\N
171	26	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
172	26	2	minutes, or until dough is fluffy and golden brown.	\N
173	26	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
174	26	4	When on Social Media, the Pink	\N
175	26	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
176	26	6	Email	\N
177	26	7	Address	\N
178	26	8	Subscribe	\N
179	26	9	Powered by Convert	\N
181	27	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
182	27	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
183	27	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
184	27	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
185	27	5	Pile on the steak and vegetables.	\N
186	27	6	Roll up, making sure the ends are sealed.	\N
187	27	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
188	27	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
189	27	9	Enjoy the happy faces around you :)	\N
190	28	1	Preheat oven to 375	\N
191	28	2	Combine all ingredients in a medium bowl.	\N
192	28	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
193	28	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
194	28	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
195	29	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
196	29	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
197	29	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
198	29	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
199	29	5	Pile on the steak and vegetables.	\N
200	29	6	Roll up, making sure the ends are sealed.	\N
201	29	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
202	29	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
203	29	9	Enjoy the happy faces around you :)	\N
204	30	1	Preheat oven to 375	\N
205	30	2	Combine all ingredients in a medium bowl.	\N
206	30	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
207	30	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
208	30	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
209	31	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
210	31	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
211	31	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
212	31	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
213	31	5	Pile on the steak and vegetables.	\N
214	31	6	Roll up, making sure the ends are sealed.	\N
215	31	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
216	31	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
217	31	9	Enjoy the happy faces around you :)	\N
218	32	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
219	32	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
220	32	3	Add another layer of cheese, and then sprinkle with pepper.	\N
221	32	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
222	33	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
223	33	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
224	33	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
225	33	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
226	33	5	Pile on the steak and vegetables.	\N
227	33	6	Roll up, making sure the ends are sealed.	\N
228	33	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
229	33	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
230	33	9	Enjoy the happy faces around you :)	\N
231	34	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
232	34	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
233	34	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
234	34	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
235	35	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
236	35	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
237	35	3	Add another layer of cheese, and then sprinkle with pepper.	\N
238	35	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
239	36	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
240	36	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
241	36	3	Add another layer of cheese, and then sprinkle with pepper.	\N
242	36	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
243	37	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
244	37	2	minutes, or until dough is fluffy and golden brown.	\N
245	37	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
246	37	4	When on Social Media, the Pink	\N
247	37	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
248	37	6	Email	\N
249	37	7	Address	\N
250	37	8	Subscribe	\N
251	37	9	Powered by Convert	\N
252	37	10	Kit	\N
253	38	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
254	38	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
255	38	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
256	38	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
257	38	5	Pile on the steak and vegetables.	\N
258	38	6	Roll up, making sure the ends are sealed.	\N
259	38	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
260	38	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
261	38	9	Enjoy the happy faces around you :)	\N
262	39	1	Preheat oven to 375	\N
263	39	2	Combine all ingredients in a medium bowl.	\N
264	39	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
265	39	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
266	39	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
267	40	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
268	40	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
269	40	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
270	40	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.users (user_id, fname, lname, email, password, profile_picture) FROM stdin;
1	Kenneth	Rush	KRush@email.com	test	/static/img/chef_hat.png
2	Tina	Cook	TCook@email.com	test	/static/img/chef_hat.png
3	Brandi	Clark	BClark@email.com	test	/static/img/chef_hat.png
4	Kelsey	Dawson	KDawson@email.com	test	/static/img/chef_hat.png
5	Timothy	Sherman	TSherman@email.com	test	/static/img/chef_hat.png
6	Emily	Silva	ESilva@email.com	test	/static/img/chef_hat.png
7	James	Lee	JLee@email.com	test	/static/img/chef_hat.png
8	James	Gonzalez	JGonzalez@email.com	test	/static/img/chef_hat.png
9	Steven	Mcdonald	SMcdonald@email.com	test	/static/img/chef_hat.png
10	Michael	Edwards	MEdwards@email.com	test	/static/img/chef_hat.png
\.


--
-- Name: connections_connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.connections_connection_id_seq', 10, true);


--
-- Name: cookbooks_cookbook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.cookbooks_cookbook_id_seq', 20, true);


--
-- Name: recipes_recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.recipes_recipe_id_seq', 40, true);


--
-- Name: steps_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.steps_step_id_seq', 270, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


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

