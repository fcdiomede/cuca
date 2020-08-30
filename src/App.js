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
import { ProfilePicture } from './user-profile';
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
  


  const handleLogout = () => {
      setLoggedIn(false)
  }

  return <React.Fragment>
      <Router>
      <div>
        {loggedIn ? <ProfilePicture picture={userData.profile_picture} /> : null}
      <nav>
          <ul>
          <li>
              <Link to='/'> Home </Link>
          </li>
          <li>
              <Link to='/login' onClick={handleLogout}> Logout </Link>
          </li>
          </ul>
      </nav>
      <Switch>
          <ProtectedRoute exact path='/' loggedIn={loggedIn}
                                          component={() => (<Homepage userName={userData.name} /> )} />
          <ProtectedRoute path='/recipes' loggedIn={loggedIn} component={Recipes} />
          <Route path='/login' 
                render={(props) => (<Login {...props} setLoggedIn={setLoggedIn}
                                                      setUserData={setUserData} /> )} />
      </Switch> 
      </div>
  </Router>
</React.Fragment>
}

export default App;
