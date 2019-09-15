import { AppBar } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import makeStyles from '@material-ui/core/styles/makeStyles';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import React from 'react';
import { ApolloProvider } from 'react-apollo';
import { BrowserRouter as Router, Link } from 'react-router-dom';
import { client } from './lib/apollo/client';
import { RoutingComponent } from './lib/routing/routing';

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
}));

export const App = () => {
  const classes = useStyles();

  return (
    <ApolloProvider client={client}>
      <Router>
        <div className="App">

          <AppBar position="static">
            <Toolbar>
              <Typography variant="h6" className={classes.title}>
                <Button component={Link} to="/" color="inherit">Home</Button>
              </Typography>

              <Button component={Link} to="/products" color="inherit">Produkty</Button>
              <Button component={Link} to="/add-product" color="inherit">Dodaj produkt</Button>
              <Button component={Link} to="/dashboard" color="inherit">Login</Button>
            </Toolbar>
          </AppBar>
        </div>

        <RoutingComponent />
      </Router>
    </ApolloProvider>
  );
};
