import React from "react";
import { useHistory } from "react-router-dom";

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
                console.log(data)
                updateCookbooks(data.cookbooks);
                console.log(randomCookbooks)
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

function SearchBar() {

    const [searchTerm, setSearchTerm] = React.useState('');

    return (
        <form>
            <input type='text'
                placeholder='Search...'
                value={searchTerm}
                onChange={(evt) => setSearchTerm(evt.target.value)}>
            </input>
            <input type='button'
                value='Search!' />
        </form>
    );
}

function Explore() {
    return (
        <React.Fragment>
            <h1>What's cooking?</h1>
            <SearchBar />
            <CookbookContainer />
        </React.Fragment>
    );
}

export default Explore;
