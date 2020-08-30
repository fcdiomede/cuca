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
-- Data for Name: cookbooks; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.cookbooks (cookbook_id, title, cover_img, user_id, deleted) FROM stdin;
1	Breakfast	/static/img/cooking_6.jpg	1	f
2	Breakfast	/static/img/cooking_4.jpg	1	f
3	Breakfast	/static/img/cooking_4.jpg	2	f
4	Lunch	/static/img/cooking_1.jpg	2	f
5	Lunch	/static/img/cooking_5.jpg	3	f
6	Breakfast	/static/img/cooking_5.jpg	3	f
7	Breakfast	/static/img/cooking_5.jpg	4	f
8	Lunch	/static/img/cooking_7.jpg	4	f
9	Breakfast	/static/img/cooking_6.jpg	5	f
10	Dinner	/static/img/cooking_6.jpg	5	f
11	Lunch	/static/img/cooking_6.jpg	6	f
12	Lunch	/static/img/cooking_3.jpg	6	f
13	Breakfast	/static/img/cooking_3.jpg	7	f
14	Dinner	/static/img/cooking_2.jpg	7	f
15	Dessert	/static/img/cooking_7.jpg	8	f
16	Dessert	/static/img/cooking_4.jpg	8	f
17	Lunch	/static/img/cooking_7.jpg	9	f
18	Dinner	/static/img/cooking_5.jpg	9	f
19	Dinner	/static/img/cooking_1.jpg	10	f
20	Breakfast	/static/img/cooking_6.jpg	10	f
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.recipes (recipe_id, cookbook_id, title, ingredients, time_required, servings, media, deleted) FROM stdin;
1	1	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
2	1	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
3	2	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
4	2	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
5	3	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
6	3	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
7	4	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
8	4	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
9	5	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
10	5	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
11	6	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
12	6	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
13	7	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
14	7	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
15	8	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
16	8	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
17	9	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
18	9	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
19	10	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
20	10	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
21	11	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
22	11	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
23	12	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
24	12	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
25	13	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
26	13	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
27	14	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
28	14	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
29	15	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
30	15	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
31	16	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	f
32	16	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
33	17	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
34	17	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
35	18	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
36	18	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	f
37	19	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	f
38	19	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
39	20	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	f
40	20	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	f
\.


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.steps (step_id, recipe_id, step_number, body, media) FROM stdin;
1	1	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
2	1	2	minutes, or until dough is fluffy and golden brown.	\N
3	1	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
4	1	4	When on Social Media, the Pink	\N
5	1	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
6	1	6	Email	\N
7	1	7	Address	\N
8	1	8	Subscribe	\N
9	1	9	Powered by Convert	\N
10	1	10	Kit	\N
11	2	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
12	2	2	minutes, or until dough is fluffy and golden brown.	\N
13	2	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
14	2	4	When on Social Media, the Pink	\N
15	2	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
16	2	6	Email	\N
17	2	7	Address	\N
18	2	8	Subscribe	\N
19	2	9	Powered by Convert	\N
20	2	10	Kit	\N
21	3	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
22	3	2	minutes, or until dough is fluffy and golden brown.	\N
23	3	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
24	3	4	When on Social Media, the Pink	\N
25	3	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
26	3	6	Email	\N
27	3	7	Address	\N
28	3	8	Subscribe	\N
29	3	9	Powered by Convert	\N
30	3	10	Kit	\N
31	4	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
32	4	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
33	4	3	Add another layer of cheese, and then sprinkle with pepper.	\N
34	4	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
35	5	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
36	5	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
37	5	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
38	5	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
39	5	5	Pile on the steak and vegetables.	\N
40	5	6	Roll up, making sure the ends are sealed.	\N
41	5	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
42	5	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
43	5	9	Enjoy the happy faces around you :)	\N
44	6	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
45	6	2	minutes, or until dough is fluffy and golden brown.	\N
46	6	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
47	6	4	When on Social Media, the Pink	\N
48	6	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
49	6	6	Email	\N
50	6	7	Address	\N
51	6	8	Subscribe	\N
52	6	9	Powered by Convert	\N
53	6	10	Kit	\N
54	7	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
55	7	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
56	7	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
57	7	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
58	7	5	Pile on the steak and vegetables.	\N
59	7	6	Roll up, making sure the ends are sealed.	\N
60	7	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
61	7	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
62	7	9	Enjoy the happy faces around you :)	\N
63	8	1	Preheat oven to 375	\N
64	8	2	Combine all ingredients in a medium bowl.	\N
65	8	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
66	8	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
67	8	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
68	9	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
69	9	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
70	9	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
71	9	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
72	9	5	Pile on the steak and vegetables.	\N
73	9	6	Roll up, making sure the ends are sealed.	\N
74	9	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
75	9	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
76	9	9	Enjoy the happy faces around you :)	\N
77	10	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
78	10	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
79	10	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
80	10	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
81	10	5	Pile on the steak and vegetables.	\N
82	10	6	Roll up, making sure the ends are sealed.	\N
83	10	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
84	10	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
85	10	9	Enjoy the happy faces around you :)	\N
86	11	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
87	11	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
88	11	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
89	11	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
90	12	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
91	12	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
92	12	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
93	12	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
94	12	5	Pile on the steak and vegetables.	\N
95	12	6	Roll up, making sure the ends are sealed.	\N
96	12	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
97	12	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
98	12	9	Enjoy the happy faces around you :)	\N
99	13	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
100	13	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
101	13	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
102	13	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
103	14	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
104	14	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
105	14	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
106	14	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
107	14	5	Pile on the steak and vegetables.	\N
108	14	6	Roll up, making sure the ends are sealed.	\N
109	14	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
110	14	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
111	14	9	Enjoy the happy faces around you :)	\N
112	15	1	Preheat oven to 375	\N
113	15	2	Combine all ingredients in a medium bowl.	\N
114	15	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
115	15	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
116	15	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
117	16	1	Preheat oven to 375	\N
118	16	2	Combine all ingredients in a medium bowl.	\N
119	16	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
120	16	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
121	16	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
122	17	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
123	17	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
124	17	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
125	17	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
126	17	5	Pile on the steak and vegetables.	\N
127	17	6	Roll up, making sure the ends are sealed.	\N
128	17	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
129	17	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
130	17	9	Enjoy the happy faces around you :)	\N
131	18	1	Preheat oven to 375	\N
132	18	2	Combine all ingredients in a medium bowl.	\N
133	18	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
134	18	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
135	18	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
136	19	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
137	19	2	minutes, or until dough is fluffy and golden brown.	\N
138	19	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
139	19	4	When on Social Media, the Pink	\N
140	19	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
141	19	6	Email	\N
142	19	7	Address	\N
143	19	8	Subscribe	\N
144	19	9	Powered by Convert	\N
145	19	10	Kit	\N
146	20	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
147	20	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
148	20	3	Add another layer of cheese, and then sprinkle with pepper.	\N
149	20	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
150	21	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
151	21	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
152	21	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
153	21	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
154	21	5	Pile on the steak and vegetables.	\N
155	21	6	Roll up, making sure the ends are sealed.	\N
156	21	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
157	21	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
158	21	9	Enjoy the happy faces around you :)	\N
159	22	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
160	22	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
161	22	3	Add another layer of cheese, and then sprinkle with pepper.	\N
162	22	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
163	23	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
164	23	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
165	23	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
166	23	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
167	23	5	Pile on the steak and vegetables.	\N
168	23	6	Roll up, making sure the ends are sealed.	\N
169	23	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
170	23	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
171	23	9	Enjoy the happy faces around you :)	\N
172	24	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
173	24	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
174	24	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
175	24	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
176	24	5	Pile on the steak and vegetables.	\N
177	24	6	Roll up, making sure the ends are sealed.	\N
178	24	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
179	24	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
180	24	9	Enjoy the happy faces around you :)	\N
181	25	1	Preheat oven to 375	\N
182	25	2	Combine all ingredients in a medium bowl.	\N
183	25	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
184	25	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
185	25	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
186	26	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
187	26	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
188	26	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
189	26	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
190	26	5	Pile on the steak and vegetables.	\N
191	26	6	Roll up, making sure the ends are sealed.	\N
192	26	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
193	26	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
194	26	9	Enjoy the happy faces around you :)	\N
195	27	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
196	27	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
197	27	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
198	27	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
199	27	5	Pile on the steak and vegetables.	\N
200	27	6	Roll up, making sure the ends are sealed.	\N
201	27	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
202	27	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
203	27	9	Enjoy the happy faces around you :)	\N
204	28	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
205	28	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
206	28	3	Add another layer of cheese, and then sprinkle with pepper.	\N
207	28	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
208	29	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
209	29	2	minutes, or until dough is fluffy and golden brown.	\N
210	29	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
211	29	4	When on Social Media, the Pink	\N
212	29	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
213	29	6	Email	\N
214	29	7	Address	\N
215	29	8	Subscribe	\N
216	29	9	Powered by Convert	\N
217	29	10	Kit	\N
218	30	1	Preheat oven to 375	\N
219	30	2	Combine all ingredients in a medium bowl.	\N
220	30	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
221	30	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
222	30	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
223	31	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
224	31	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
225	31	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
226	31	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
227	32	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
228	32	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
229	32	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
230	32	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
231	32	5	Pile on the steak and vegetables.	\N
232	32	6	Roll up, making sure the ends are sealed.	\N
233	32	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
234	32	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
235	32	9	Enjoy the happy faces around you :)	\N
236	33	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
237	33	2	minutes, or until dough is fluffy and golden brown.	\N
238	33	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
239	33	4	When on Social Media, the Pink	\N
240	33	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
241	33	6	Email	\N
242	33	7	Address	\N
243	33	8	Subscribe	\N
244	33	9	Powered by Convert	\N
245	33	10	Kit	\N
246	34	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
247	34	2	minutes, or until dough is fluffy and golden brown.	\N
248	34	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
249	34	4	When on Social Media, the Pink	\N
250	34	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
251	34	6	Email	\N
252	34	7	Address	\N
253	34	8	Subscribe	\N
254	34	9	Powered by Convert	\N
255	34	10	Kit	\N
256	35	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
257	35	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
258	35	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
259	35	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
260	35	5	Pile on the steak and vegetables.	\N
261	35	6	Roll up, making sure the ends are sealed.	\N
262	35	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
263	35	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
264	35	9	Enjoy the happy faces around you :)	\N
265	36	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
266	36	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
267	36	3	Add another layer of cheese, and then sprinkle with pepper.	\N
268	36	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
269	37	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
270	37	2	minutes, or until dough is fluffy and golden brown.	\N
271	37	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
272	37	4	When on Social Media, the Pink	\N
273	37	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
274	37	6	Email	\N
275	37	7	Address	\N
276	37	8	Subscribe	\N
277	37	9	Powered by Convert	\N
278	37	10	Kit	\N
279	38	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
280	38	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
281	38	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
282	38	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
283	38	5	Pile on the steak and vegetables.	\N
284	38	6	Roll up, making sure the ends are sealed.	\N
285	38	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
286	38	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
287	38	9	Enjoy the happy faces around you :)	\N
288	39	1	Preheat oven to 375	\N
289	39	2	Combine all ingredients in a medium bowl.	\N
290	39	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
291	39	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
292	39	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
293	40	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
294	40	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
295	40	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
296	40	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
297	40	5	Pile on the steak and vegetables.	\N
298	40	6	Roll up, making sure the ends are sealed.	\N
299	40	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
300	40	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
301	40	9	Enjoy the happy faces around you :)	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.users (user_id, fname, lname, email, password, profile_picture) FROM stdin;
1	Jacqueline	Byrd	JByrd@email.com	test	/static/img/chef_hat.png
2	Sierra	Robertson	SRobertson@email.com	test	/static/img/chef_hat.png
3	Theresa	Andersen	TAndersen@email.com	test	/static/img/chef_hat.png
4	David	Thomas	DThomas@email.com	test	/static/img/chef_hat.png
5	Misty	Rose	MRose@email.com	test	/static/img/chef_hat.png
6	Claudia	Mcconnell	CMcconnell@email.com	test	/static/img/chef_hat.png
7	Laura	Moss	LMoss@email.com	test	/static/img/chef_hat.png
8	Helen	Preston	HPreston@email.com	test	/static/img/chef_hat.png
9	Walter	Pitts	WPitts@email.com	test	/static/img/chef_hat.png
10	Courtney	Watson	CWatson@email.com	test	/static/img/chef_hat.png
\.


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

SELECT pg_catalog.setval('public.steps_step_id_seq', 301, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fernanda
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


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

