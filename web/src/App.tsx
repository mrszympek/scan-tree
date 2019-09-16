import { Button } from '@material-ui/core';
import AppBar from '@material-ui/core/AppBar';
import CssBaseline from '@material-ui/core/CssBaseline';
import Drawer from '@material-ui/core/Drawer';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import { makeStyles } from '@material-ui/core/styles';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import React from 'react';
import ApolloProvider from 'react-apollo/ApolloProvider';
import { BrowserRouter as Router, Link } from 'react-router-dom';
import './App.scss';
import { Profile } from './components/profile/profile';
import { client } from './lib/apollo/client';
import { RoutingComponent } from './lib/routing/routing';

const drawerWidth = 240;

const useStyles = makeStyles(theme => ({
  root: {
    display: 'flex',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
  },
  drawer: {
    width: drawerWidth,
    flexShrink: 0,
  },
  drawerPaper: {
    width: drawerWidth,
  },
  content: {
    flexGrow: 1,
    padding: theme.spacing(3),
  },
  toolbar: theme.mixins.toolbar,
}));

export const App = () => {
  const classes = useStyles();

  return (
    <ApolloProvider client={ client }>
      <Router>
        <div className={ classes.root }>
          <CssBaseline />
          <AppBar position="fixed" className={ classes.appBar }>
            <Toolbar>
              <Typography variant="h6" noWrap>
                <Button component={ Link } to="/" color="inherit">Home</Button>
              </Typography>
            </Toolbar>
          </AppBar>
          <Drawer
            className={ classes.drawer }
            variant="permanent"
            classes={ {
              paper: classes.drawerPaper,
            } }
          >
            <div className={ classes.toolbar } />

            <Profile/>


            <List>
              <ListItem button key={ 'Dashboard' } component={props => <Link to="/dashboard" {...props} />}>
                <ListItemText primary={ 'Dashboard' } />
              </ListItem>
              <ListItem button key={ 'Produkty' } component={props => <Link to="/products" {...props} />}>
                <ListItemText primary={ 'Produkty' } />
              </ListItem>
              <ListItem button key={ 'Dodaj produkt' } component={props => <Link to="/add-product" {...props} />}>
                <ListItemText primary={ 'Dodaj produkt' } />
              </ListItem>
            </List>
          </Drawer>
          <main className={ classes.content }>
            <div className={ classes.toolbar } />
            <RoutingComponent />
          </main>
        </div>
      </Router>
    </ApolloProvider>
  );
};