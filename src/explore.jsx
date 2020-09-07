import React from "react";
import { useHistory } from "react-router-dom";

export function SearchBar(props) {

    const [searchTerm, setSearchTerm] = React.useState('');
    const [searchItem, setSearchItem] = React.useState('users');

    let history = useHistory();

    const handleSearch = (evt) => {
        evt.preventDefault();

        const search = { 'searchTerm': searchTerm };

        fetch(`/api/search/${searchItem}`, {
            method: 'POST',
            body: JSON.stringify(search),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then((res) => res.json())
            .then((data) => {
                console.log(data);
                props.setSearchResults(data);
                setSearchTerm('');
                history.push(`/search/${searchItem}`);
            });
    };

    return (
        <form class="form-inline d-flex justify-content-center md-form form-sm active-green mt-0">
            <div class="col">
            <i class="fas fa-search" aria-hidden="true"></i>
            <input class="form-control form-control-sm ml-3 w-75 cuca-white-text"
                type='text'
                aria-label="Search"
                placeholder='Search...'
                value={searchTerm}
                onChange={(evt) => setSearchTerm(evt.target.value)}>
            </input>
            </div>
            <div class="col">
            <select name="search for" onChange={(evt) => setSearchItem(evt.target.value)}
                    class="custom-select">
                <option value="users" selected>Users</option>
                <option value="recipes">Recipes</option>
            </select>
            </div>
            <input type='submit'
                id="search-button"
                value='Search'
                onClick={handleSearch}
                class="btn btn-success btn-sm" />
        </form>
    );
}

function UserCard(props) {

    let history = useHistory();

    const goToUserPage = () => {
        history.push(`/user/${props.userId}`);
    };

    return (
        <p onClick={goToUserPage}>
            <h2>{props.fname} {props.lname}</h2>
            <img src={props.profilePicture} />
        email : {props.email}
        </p>
    );
}

export function UserSearchResults(props) {


    const results = [];
    for (const user of props.searchResults) {
        results.push(
            <UserCard userId={user.user_id}
                fname={user.fname}
                lname={user.lname}
                profilePicture={user.profile_picture}
                email={user.email}
            />
        );
    }

    console.log(results);

    return (<div>
        <h1>Search Results</h1>
        <div>{results}</div>
    </div>);
}


function RecipeCard(props) {
    let history = useHistory();

    const goToRecipePage = () => {
        history.push(`/recipes/${props.recipeId}`);
    };

    return (
        <p onClick={goToRecipePage}>
            <h2>{props.title}</h2>
            <img src={props.coverPhoto} />
        time required:{props.timeReq}
        ingredients:{props.ingredients}
        </p>
    );
}

export function RecipeSearchResults(props) {

    const results = [];
    for (const recipe of props.searchResults) {
        results.push(
            <RecipeCard recipeId={recipe.recipe_id}
                title={recipe.title}
                coverPhoto={recipe.cover_photo}
                timeReq={recipe.time_req}
                ingredients={recipe.ingredients}
            />
        );
    }

    return (<div>
        <h1>Search Results</h1>
        <div>{results}</div>
    </div>);
}

function CookbookCover(props) {

    let history = useHistory();

    const data = { 'cookbookId': props.cookbookId };

    const goToCookbook = () => {
        fetch('/api/set-cookbook', {
            method: 'POST',
            body: JSON.stringify(data),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
            .then(() => history.push('/recipes'));
    };

    return (
        <div className="cookbook" onClick={goToCookbook}>
            <p>Name: {props.title}</p>
            <img src={props.imgUrl} />
        </div>
    );
}

//component to hold all cookbook cards
export function CookbookContainer(props) {

    // make a call to the server to ask for information
    //user's personal cookbooks to appear

    const [randomCookbooks, updateCookbooks] = React.useState([]);
    // const [randomRecipes, updateRecipes] = React.useState([]);

    React.useEffect(() => {
        fetch('/api/random-data')
            .then((res) => res.json())
            .then((data) => {
                updateCookbooks(data.cookbooks);
            });
    }, []);

    const cookbooks = [];
    for (const cookbook of randomCookbooks) {
        cookbooks.push(
            <CookbookCover
                key={cookbook.key}
                cookbookId={cookbook.key}
                title={cookbook.title}
                imgUrl={cookbook.imgUrl}
            />
        );

    }

    return (
        <div>
            {cookbooks}
        </div>
    );
}


function Explore() {


    return (
        <React.Fragment>
            <h1>What's cooking?</h1>
            <CookbookContainer />
        </React.Fragment>
    );
}

export default Explore;
