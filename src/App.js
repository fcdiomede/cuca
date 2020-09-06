import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link,
  Redirect
} from "react-router-dom";
import Homepage from './user-profile';
import Login from './login';
import Recipes from './recipes';
import { ProfilePicture, UserProfileModal, UserProfile } from './user-profile';
import Explore from './explore';
import { SearchBar, UserSearchResults, RecipeSearchResults } from './explore';
// import logo from './logo.svg';
import './App.css';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';



const ProtectedRoute = ({ component: Component, loggedIn, path, ...rest }) => {
  return (
    <Route path={path} {...rest} render={
      (props) => {
        if (loggedIn) {
          return <Component {...props} />;
        } else {
          return <Redirect to='/login' />;
        }
      }
    } />
  );
};




function App() {

  const [loggedIn, setLoggedIn] = React.useState(false);
  const [userData, setUserData] = React.useState({});
  const [showUserModal, setShowUserModal] = React.useState(false);
  const [searchResults, setSearchResults] = React.useState('');


  return <React.Fragment>

    <Router>
      <div>
        <nav class="navbar navbar-expand-lg cuca-nav">

          <img src="https://res.cloudinary.com/deglaze/image/upload/v1599416508/cuca/Cuca_jxo6ty.svg"
            alt="Cuca Logo"
            class="navbar-brand img-fluid"
            id="Cuca-Navbar-Logo" />

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item">
                <Link to={`/homepage/${userData.user_id}`} class="nav-link cuca-white-text"> Home </Link>
              </li>
              <li class="nav-item">
                <Link to='/' class="nav-link cuca-white-text"> Explore </Link>
              </li>
            </ul>
            <ul class="navbar-nav mx-auto">
              <li class="nav-item">
                <SearchBar setSearchResults={setSearchResults} />
              </li>
            </ul>
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                {loggedIn ? <ProfilePicture userData={userData}
                  setShowUserModal={setShowUserModal}
                  setLoggedIn={setLoggedIn} /> :
                  <Link to='/login' class="nav-link cuca-white-text">Login</Link>}
              </li>
            </ul>

          </div>

        </nav>
        <Switch>
          <ProtectedRoute exact path='/homepage/:userId' loggedIn={loggedIn}
            component={() => (<Homepage userId={userData.user_id} name={userData.name} />)} />
          <ProtectedRoute exact path='/user/:userId' loggedIn={loggedIn} component={() => (<UserProfile userId={userData.user_id} />)} />
          <ProtectedRoute path='/recipes' loggedIn={loggedIn} component={() => (<Recipes userId={userData.user_id} />)} />
          <Route exact path='/' component={Explore} />
          <Route exact path='/search/users' component={() => (<UserSearchResults searchResults={searchResults} />)} />
          <Route exact path='/search/recipes' component={() => (<RecipeSearchResults searchResults={searchResults} />)} />
          <Route path='/login'
            render={(props) => (<Login {...props} setLoggedIn={setLoggedIn}
              setUserData={setUserData} />)} />

        </Switch>
      </div>
    </Router>

    {showUserModal ? <UserProfileModal userData={userData}
              setShowUserModal={setShowUserModal}
              setUserData={setUserData} /> : null}

  </React.Fragment>;
}

export default App;
