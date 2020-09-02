import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  Redirect,
  useParams,
  useHistory
} from "react-router-dom";
import Homepage from './user-profile';
import Login from './login';
import Recipes from './recipes';
import { ProfilePicture, UserProfileModal } from './user-profile';
import Explore from './explore';
// import logo from './logo.svg';
// import './App.css';

function SearchBar(props) {

  const [searchTerm, setSearchTerm] = React.useState('');

  let history = useHistory();

  const handleSearch = () => {

      let data = {'searchTerm': searchTerm}

      fetch('/api/search', {
          method: 'POST',
          body: JSON.stringify(data),
          headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json'
          }
      })
      .then((res) => res.json())
      .then((data) => {
          props.setSearchResults(data)
          history.push('/search')
      })
  }

  return (
      <form>
          <input type='text'
              placeholder='Search...'
              value={searchTerm}
              onChange={(evt) => setSearchTerm(evt.target.value)}>
          </input>
          <input type='button'
              value='Search!'
              onClick={handleSearch} />
      </form>
  );
}

function UserCard(props) {
  return (
    <p>
      <h2>{props.fname} {props.lname}</h2>
      <img src={props.profilePicture} />
      email : {props.email}
    </p>
  )
}

function SearchResults(props) {

  console.log(props.searchResults)

  const results = []
  for (const user of props.searchResults) {
    results.push(
      <UserCard fname={user.fname}
                lname={user.lname}
                profilePicture={user.profile_picture}
                email={user.email}
      />
    )
  }


  return(<div>
          <h1>Search Results</h1>
          <div>{results}</div>
        </div>)
}


const ProtectedRoute = ({ component: Component, loggedIn, path, ...rest }) => {
    console.log(loggedIn);
    return (
        <Route path={path} {...rest} render={
          (props) => {
            if (loggedIn) {
              return <Component {...props} />
            } else {
              return <Redirect to='/login' />
            }
          }
        } />
      )
    }

function App() {

  const [loggedIn, setLoggedIn] = React.useState(false)
  const [userData, setUserData] = React.useState({})
  const [showUserModal, setShowUserModal] = React.useState(false);
  const [searchResults, setSearchResults] = React.useState('');

  const handleLogout = () => {
      setLoggedIn(false)
  }


  return <React.Fragment>
      <Router>
      <div>
        {loggedIn ? <ProfilePicture userData={userData} 
                                    setShowUserModal={setShowUserModal} /> : null}
        {showUserModal ? <UserProfileModal userData={userData}
                                            setShowUserModal={setShowUserModal}
                                            setUserData={setUserData} /> : null}
      <nav>
          <ul>
          <li>
              <Link to={`/user/${userData.user_id}`}> Home </Link>
          </li>
          <li>
              <Link to='/login' onClick={handleLogout}> Logout </Link>
          </li>
          <li>
            <Link to='/'> Explore </Link>
          </li>
          <li>
            <SearchBar setSearchResults={setSearchResults} />
          </li>
          </ul>
      </nav>
      <Switch>
          <ProtectedRoute exact path='/user/:userId' loggedIn={loggedIn}
                                          component={() => (<Homepage userName={userData.name} /> )} />
          <ProtectedRoute exact path='/recipes' loggedIn={loggedIn} component={Recipes} />
          <ProtectedRoute exact path='/search' loggedIn={loggedIn}
                                               component={() => (<SearchResults searchResults={searchResults}/> )} />
         <Route exact path='/login' 
                render={(props) => (<Login {...props} setLoggedIn={setLoggedIn}
                                                      setUserData={setUserData} /> )} />
         <Route exact path='/' component={Explore} />
      </Switch> 
      </div>
  </Router>
</React.Fragment>
}

export default App;
