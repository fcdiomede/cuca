import React from "react";
import { useHistory } from "react-router-dom";

export function SearchBar(props) {

    const [searchTerm, setSearchTerm] = React.useState('');
  
    let history = useHistory();
  
    const handleSearch = (evt) => {
        evt.preventDefault();

        const search = {'searchTerm': searchTerm}
  
        fetch('/api/search', {
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
            history.push('/search');
        })
    }
  
    return (
        <form>
            <input type='text'
                placeholder='Search...'
                value={searchTerm}
                onChange={(evt) => setSearchTerm(evt.target.value)}>
            </input>
            <input type='submit'
                value='Search!'
                onClick={handleSearch} />
        </form>
    );
  }
  
  function UserCard(props) {
  
    let history = useHistory();
  
    const goToUserPage = () => {
      history.push(`/user/${props.userId}`)
    }
  
    return (
      <p onClick={goToUserPage}>
        <h2>{props.fname} {props.lname}</h2>
        <img src={props.profilePicture} />
        email : {props.email}
      </p>
    )
  }
  
  export function SearchResults(props) {
  
    console.log(props.searchResults)
  
    const results = []
    for (const user of props.searchResults) {
      results.push(
        <UserCard userId={user.user_id}
                  fname={user.fname}
                  lname={user.lname}
                  profilePicture={user.profile_picture}
                  email={user.email}
        />
      )
    }
    
    console.log(results);
  
    return(<div>
            <h1>Search Results</h1>
            <div>{results}</div>
          </div>)
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
