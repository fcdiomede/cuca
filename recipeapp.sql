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
    deleted boolean
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
    deleted boolean
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
1	Dinner	/static/img/cooking_6.jpg	1	f
2	Dinner	/static/img/cooking_1.jpg	1	f
3	Dinner	/static/img/cooking_5.jpg	2	f
4	Breakfast	/static/img/cooking_2.jpg	2	f
5	Dinner	/static/img/cooking_1.jpg	3	f
6	Lunch	/static/img/cooking_3.jpg	3	f
7	Lunch	/static/img/cooking_4.jpg	4	f
8	Lunch	/static/img/cooking_6.jpg	4	f
9	Dinner	/static/img/cooking_1.jpg	5	f
10	Dinner	/static/img/cooking_7.jpg	5	f
11	Dinner	/static/img/cooking_4.jpg	6	f
12	Dinner	/static/img/cooking_4.jpg	6	f
13	Dessert	/static/img/cooking_6.jpg	7	f
14	Breakfast	/static/img/cooking_1.jpg	7	f
15	Dinner	/static/img/cooking_6.jpg	8	f
16	Breakfast	/static/img/cooking_5.jpg	8	f
17	Dinner	/static/img/cooking_2.jpg	9	f
18	Breakfast	/static/img/cooking_2.jpg	9	f
19	Breakfast	/static/img/cooking_6.jpg	10	f
20	Dessert	/static/img/cooking_7.jpg	10	f
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.recipes (recipe_id, cookbook_id, title, ingredients, time_required, servings, media, deleted) FROM stdin;
1	1	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
2	1	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
3	2	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
4	2	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
5	3	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
6	3	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
7	4	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
8	4	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
9	5	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
10	5	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
11	6	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
12	6	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
13	7	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
14	7	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
15	8	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
16	8	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
17	9	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
18	9	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
19	10	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
20	10	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
21	11	Philly Cheesesteak Grilled Wraps	2 steaks, BBQ'd and sliced as thin as possible, 1 tbsp vegetable oil, 2 onions, halved and sliced, 1 tsp Better than Bouillon Beef Base, 2 portobello mushrooms, stem and gills removed, 2 bell peppers, sliced, Mayonnaise, Hot Sauce, 4 - 10" tortillas	45 mins	4	https://spoonacular.com/recipeImages/655890-556x370.jpg	\N
22	11	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
23	12	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
24	12	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
25	13	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
26	13	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
27	14	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
28	14	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
29	15	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
30	15	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
31	16	Healthy Black Forest Baked Oatmeal	1 cup rolled oats (not instant), ½ cup applesauce, ½ cup fat free milk (or dairy free milk, to make vegan), ¾ cup pitted cherries (fresh or frozen), ½ Tsp. vanilla extract, ¼ cup chocolate chips, 1 Tbsp. chia seeds, 1 Tbsp. cocoa powder	45 mins	3	https://spoonacular.com/recipeImages/646442-556x370.jpg	\N
32	16	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
33	17	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
34	17	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
35	18	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
36	18	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
37	19	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
38	19	Turkey Tomato Cheese Pizza	green bell pepper, chopped, parsley, pepper, whole wheat crust, Roma tomato, diced, shredded Mozzarella cheese, tomato sauce, ½-3/4 cup chopped Turkey breast (cooked), white onion, chopped	15 mins	6	https://spoonacular.com/recipeImages/715495-556x370.jpg	\N
39	20	Antipasto Squares	3 eggs, 1/2 Tsp ground black pepper, 1/4 pound thinly sliced ham, 3 Tbsp grated Parmesan cheese, 1/4 pound thinly sliced pepperoni sausage, 1/4 pound thinly sliced provolone cheese, 2 (10oz) cans refrigerated crescent dinner rolls, 1 (12oz) jar roasted red peppers, drained and sliced into strips, 1/4 pound thinly sliced Genoa salami, 1/4 pound thinly sliced swiss cheese	45 mins	6	https://spoonacular.com/recipeImages/715511-556x370.jpg	\N
40	20	Fresh Apple Cake With Caramel Sauce	2 c.s sugar, 1 c. vegetable oil, 3 eggs, 3 c.s sifted flour, 1 tsp. soda, 1 tsp. salt, 1 tsp. cinnamon, 2 tsp.s vanilla, 3 c.s peeled, chopped apples, 2 c.s coconut, 1 c. chopped dates or coconut, 1 c. chopped pecans, 1 c. packed brown sugar, 1/2 c. butter, 1/2 c. milk	45 mins	1	https://spoonacular.com/recipeImages/643426-556x370.jpg	\N
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
10	2	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
11	2	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
12	2	3	Add another layer of cheese, and then sprinkle with pepper.	\N
13	2	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
14	3	1	Preheat oven to 375	\N
15	3	2	Combine all ingredients in a medium bowl.	\N
16	3	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
17	3	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
18	3	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
19	4	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
20	4	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
21	4	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
22	4	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
23	4	5	Pile on the steak and vegetables.	\N
24	4	6	Roll up, making sure the ends are sealed.	\N
25	4	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
26	4	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
27	4	9	Enjoy the happy faces around you :)	\N
28	5	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
29	5	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
30	5	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
31	5	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
32	5	5	Pile on the steak and vegetables.	\N
33	5	6	Roll up, making sure the ends are sealed.	\N
34	5	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
35	5	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
36	5	9	Enjoy the happy faces around you :)	\N
37	6	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
38	6	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
39	6	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
40	6	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
41	7	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
42	7	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
43	7	3	Add another layer of cheese, and then sprinkle with pepper.	\N
44	7	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
45	8	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
46	8	2	minutes, or until dough is fluffy and golden brown.	\N
47	8	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
48	8	4	When on Social Media, the Pink	\N
49	8	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
50	8	6	Email	\N
51	8	7	Address	\N
52	8	8	Subscribe	\N
53	8	9	Powered by Convert	\N
54	8	10	Kit	\N
55	9	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
56	9	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
57	9	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
58	9	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
59	9	5	Pile on the steak and vegetables.	\N
60	9	6	Roll up, making sure the ends are sealed.	\N
61	9	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
62	9	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
63	9	9	Enjoy the happy faces around you :)	\N
64	10	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
65	10	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
66	10	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
67	10	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
68	11	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
69	11	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
70	11	3	Add another layer of cheese, and then sprinkle with pepper.	\N
71	11	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
72	12	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
73	12	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
74	12	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
75	12	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
76	12	5	Pile on the steak and vegetables.	\N
77	12	6	Roll up, making sure the ends are sealed.	\N
78	12	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
79	12	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
80	12	9	Enjoy the happy faces around you :)	\N
81	13	1	Preheat oven to 375	\N
82	13	2	Combine all ingredients in a medium bowl.	\N
83	13	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
84	13	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
85	13	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
86	14	1	Preheat oven to 375	\N
87	14	2	Combine all ingredients in a medium bowl.	\N
88	14	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
89	14	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
90	14	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
91	15	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
92	15	2	minutes, or until dough is fluffy and golden brown.	\N
93	15	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
94	15	4	When on Social Media, the Pink	\N
95	15	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
96	15	6	Email	\N
97	15	7	Address	\N
98	15	8	Subscribe	\N
99	15	9	Powered by Convert	\N
100	15	10	Kit	\N
101	16	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
102	16	2	minutes, or until dough is fluffy and golden brown.	\N
103	16	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
104	16	4	When on Social Media, the Pink	\N
105	16	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
106	16	6	Email	\N
107	16	7	Address	\N
108	16	8	Subscribe	\N
109	16	9	Powered by Convert	\N
110	16	10	Kit	\N
111	17	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
112	17	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
113	17	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
114	17	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
115	17	5	Pile on the steak and vegetables.	\N
116	17	6	Roll up, making sure the ends are sealed.	\N
117	17	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
118	17	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
119	17	9	Enjoy the happy faces around you :)	\N
120	18	1	Preheat oven to 375	\N
121	18	2	Combine all ingredients in a medium bowl.	\N
122	18	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
123	18	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
124	18	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
125	19	1	Preheat oven to 375	\N
126	19	2	Combine all ingredients in a medium bowl.	\N
127	19	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
128	19	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
129	19	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
130	20	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
131	20	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
132	20	3	Add another layer of cheese, and then sprinkle with pepper.	\N
133	20	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
134	21	1	In frying pan over medium-low heat, add onions and cook on low until caramelized (when done properly, this takes about 30 min).	\N
135	21	2	Add in the Better than Bouillon Beef Base and a tbsp of water to make a faint gravy.	\N
136	21	3	Add in the mushrooms and bell peppers and cook until softened, about 5 minutes.	\N
137	21	4	On tortilla, spread a thin layer of mayonnaise and top with a few squirts of hot sauce.	\N
138	21	5	Pile on the steak and vegetables.	\N
139	21	6	Roll up, making sure the ends are sealed.	\N
140	21	7	On griddle or in large frying pan sprayed with cooking spray, over medium heat, add the wraps, seam side down, and put something heavy on top (like a smaller frying pan weighted down with something heatproof) and grill until toasted. Flip and repeat. This would work well in an electric grill (like the George Foreman or a panini press)	\N
141	21	8	Once finished, pull off and let sit for a minute before slicing in half.	\N
142	21	9	Enjoy the happy faces around you :)	\N
143	22	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
144	22	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
145	22	3	Add another layer of cheese, and then sprinkle with pepper.	\N
146	22	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
147	23	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
148	23	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
149	23	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
150	23	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
151	24	1	Preheat oven to 375	\N
152	24	2	Combine all ingredients in a medium bowl.	\N
153	24	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
154	24	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
155	24	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
156	25	1	Preheat oven to 375	\N
157	25	2	Combine all ingredients in a medium bowl.	\N
158	25	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
159	25	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
160	25	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
161	26	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
162	26	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
163	26	3	Add another layer of cheese, and then sprinkle with pepper.	\N
164	26	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
165	27	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
166	27	2	minutes, or until dough is fluffy and golden brown.	\N
167	27	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
168	27	4	When on Social Media, the Pink	\N
169	27	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
170	27	6	Email	\N
171	27	7	Address	\N
172	27	8	Subscribe	\N
173	27	9	Powered by Convert	\N
174	27	10	Kit	\N
175	28	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
176	28	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
177	28	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
178	28	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
179	29	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
180	29	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
181	29	3	Add another layer of cheese, and then sprinkle with pepper.	\N
182	29	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
183	30	1	Preheat oven to 375	\N
184	30	2	Combine all ingredients in a medium bowl.	\N
185	30	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
186	30	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
187	30	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
188	31	1	Preheat oven to 375	\N
189	31	2	Combine all ingredients in a medium bowl.	\N
190	31	3	Spray a muffin tin with cooking oil. Fill the tin to the top with oats. It should make about six  eight oatmeal cakes.	\N
191	31	4	Bake uncovered for 20 minutes. For a light crust, broil for an additional 3-5 minutes until lightly browned.	\N
192	31	5	Serve on its own or with fresh fruit, yogurt, or milk.	\N
193	32	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
194	32	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
195	32	3	Add another layer of cheese, and then sprinkle with pepper.	\N
196	32	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
197	33	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
198	33	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
199	33	3	Add another layer of cheese, and then sprinkle with pepper.	\N
200	33	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
201	34	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
202	34	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
203	34	3	Add another layer of cheese, and then sprinkle with pepper.	\N
204	34	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
205	35	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
206	35	2	minutes, or until dough is fluffy and golden brown.	\N
207	35	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
208	35	4	When on Social Media, the Pink	\N
209	35	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
210	35	6	Email	\N
211	35	7	Address	\N
212	35	8	Subscribe	\N
213	35	9	Powered by Convert	\N
214	35	10	Kit	\N
215	36	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
216	36	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
217	36	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
218	36	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
219	37	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
220	37	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
221	37	3	Add another layer of cheese, and then sprinkle with pepper.	\N
222	37	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
223	38	1	Heat up your grill to 450 degrees.Start off with your whole wheat crust and spread the tomato sauce evenly over the top.	\N
224	38	2	Add a little cheese, bell pepper, onion, turkey and create a layer.Top with another layer of cheese, turkey, tomato, bell pepper, onion.	\N
225	38	3	Add another layer of cheese, and then sprinkle with pepper.	\N
226	38	4	Place the pizza on a ceramic grill plate and place into the grill.Grill for 6-10 minutes, or until cooked as desired.Slice, and serve immediately.	\N
227	39	1	Bake for 25 minutes in the preheated oven, then remove foil and bake for an additional 10-20 (I bake the full 2	\N
228	39	2	minutes, or until dough is fluffy and golden brown.	\N
229	39	3	Let stand for 5 minutes, then cut into squares, and serve warm or at room temperature.You must try this one out and let me know what you think!JOIN 500,000 SUBSCRIBERS!Join over 500,000 others who follow Pink	\N
230	39	4	When on Social Media, the Pink	\N
231	39	5	When blog, and email. Sign up to receive exclusive bonuses like this FREE Simple Fit Dinners Ebook.Don't wait! You won't want to miss a thing.Success! Now check your email to confirm your subscription and download your FREE ebook.There was an error submitting your subscription. Please try again.First Name	\N
232	39	6	Email	\N
233	39	7	Address	\N
234	39	8	Subscribe	\N
235	39	9	Powered by Convert	\N
236	39	10	Kit	\N
237	40	1	Mix together sugar and oil; add eggs; beat well. blend in flour, soda and salt.	\N
238	40	2	Add cinnamon and vanilla. Stir in apples, coconut, dates and pecans. Batter will be thick. Spoon into a 9" or 10" tube pan which has been greased and floured.	\N
239	40	3	Bake at 325 degrees for 1 1/2 hours, or until toothpick inserted comes out clean.	\N
240	40	4	Remove from oven and immediately pour caramel sauce over and allow to soak in. Cool cake completely before removing from pan. For caramel sauce, heat ingredients together. Boil for 2 minutes.	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fernanda
--

COPY public.users (user_id, fname, lname, email, password, profile_picture) FROM stdin;
1	Benjamin	Guerra	BGuerra@email.com	test	/static/img/chef_hat.png
2	Sarah	Norton	SNorton@email.com	test	/static/img/chef_hat.png
3	Christine	Perez	CPerez@email.com	test	/static/img/chef_hat.png
4	Ashlee	Moore	AMoore@email.com	test	/static/img/chef_hat.png
5	Charles	Wolfe	CWolfe@email.com	test	/static/img/chef_hat.png
6	Kimberly	Taylor	KTaylor@email.com	test	/static/img/chef_hat.png
7	Kevin	Bowers	KBowers@email.com	test	/static/img/chef_hat.png
8	Angela	Porter	APorter@email.com	test	/static/img/chef_hat.png
9	Tracey	Richmond	TRichmond@email.com	test	/static/img/chef_hat.png
10	Alan	Miller	AMiller@email.com	test	/static/img/chef_hat.png
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

SELECT pg_catalog.setval('public.steps_step_id_seq', 240, true);


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

