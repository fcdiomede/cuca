import React from "react";
import { useHistory } from "react-router-dom";
import { CookbookCover } from "./cookbook";

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
                id="search-bar"
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
        <div class="media m-5 cb-cover-img" onClick={goToUserPage}>
            <img class="d-flex mr-3 large-profile-pic" src={props.profilePicture} alt="User Icon"></img>
            <div class="media-body align-self-center">
                <h5 class="mt-0 font-weight-bold">{props.fname} {props.lname}</h5>
                <p>{props.email}</p>
            </div>
        </div>
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
        <h1 class="modal-text m-3">User Search Results</h1>
        <div>{results}</div>
    </div>);
}


function RecipeCard(props) {
    let history = useHistory();

    const goToRecipePage = () => {
        history.push(`/recipes/${props.recipeId}`);
    };

    return (
        <div class="media m-5 cb-cover-img" onClick={goToRecipePage}>
            <img class="d-flex mr-3" src={props.coverPhoto} alt="Search Image"></img>
            <div class="media-body">
                <h5 class="mt-0 font-weight-bold">{props.title}</h5>
                <p>time required:{props.timeReq}</p>
                <p>ingredients:{props.ingredients}</p>
            </div>
        </div>
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
        <h1 class="modal-text m-3">Recipe Search Results</h1>
        <div>{results}</div>
    </div>);
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
                creator_id={cookbook.creator_id}
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
            <h1 class="modal-text m-3">What's cooking?</h1>
            <div class="m-3">
            <CookbookContainer />
            </div>
        </React.Fragment>
    );
}

export default Explore;
