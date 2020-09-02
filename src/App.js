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
import { ProfilePicture, UserProfileModal } from './user-profile';
import Explore from './explore';
import { SearchBar, SearchResults } from './explore';
// import logo from './logo.svg';
// import './App.css';




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
              <Link to='/login' onClick={handleLogout}> {loggedIn ? "Logout" : "Login"} </Link>
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
          <ProtectedRoute path='/recipes' loggedIn={loggedIn} component={Recipes} />
          <Route exact path='/' component={Explore} />
          <Route path='/search' component={() => (<SearchResults searchResults={searchResults}/> )} />
          <Route path='/login' 
                render={(props) => (<Login {...props} setLoggedIn={setLoggedIn}
                                                      setUserData={setUserData} /> )} />
      </Switch> 
      </div>
  </Router>
</React.Fragment>
}

export default App;
