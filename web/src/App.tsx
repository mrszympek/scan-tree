// import { AppBar } from '@material-ui/core';
// import Button from '@material-ui/core/Button';
// import Divider from '@material-ui/core/Divider';
// import Drawer from '@material-ui/core/Drawer';
// import Grid from '@material-ui/core/Grid';
// import List from '@material-ui/core/List';
// import ListItem from '@material-ui/core/ListItem';
// import ListItemIcon from '@material-ui/core/ListItemIcon';
// import ListItemText from '@material-ui/core/ListItemText';
// import makeStyles from '@material-ui/core/styles/makeStyles';
// import Toolbar from '@material-ui/core/Toolbar';
// import Typography from '@material-ui/core/Typography';
// import React from 'react';
// import { ApolloProvider } from 'react-apollo';
// import { BrowserRouter as Router, Link } from 'react-router-dom';
// import { client } from './lib/apollo/client';
// import { RoutingComponent } from './lib/routing/routing';
// import './App.scss';
//
//
// export const App = () => {
//   const classes = useStyles();
//
//   return (
//     <ApolloProvider client={client}>
//       <Router>
//         <div className="App">
//           <AppBar position="fixed" className={classes.appBar}>
//             <Toolbar>
//               <Typography variant="h6" className={classes.title}>
//                 <Button component={Link} to="/" color="inherit">Home</Button>
//               </Typography>
//
//               <Button component={Link} to="/products" color="inherit">Produkty</Button>
//               <Button component={Link} to="/add-product" color="inherit">Dodaj produkt</Button>
//               <Button component={Link} to="/dashboard" color="inherit">Login</Button>
//             </Toolbar>
//           </AppBar>
//         </div>
//
//         <Grid container>
//           <Grid item xs={2}>
//             <Drawer
//               className={classes.drawer}
//               variant="permanent"
//               classes={{
//                 paper: classes.drawerPaper,
//               }}
//             >
//               <div className={classes.toolbar} />
//               <List>
//                 {['Inbox', 'Starred', 'Send email', 'Drafts'].map((text, index) => (
//                   <ListItem button key={text}>
//                     <ListItemText primary={text} />
//                   </ListItem>
//                 ))}
//               </List>
//               <Divider />
//               <List>
//                 {['All mail', 'Trash', 'Spam'].map((text, index) => (
//                   <ListItem button key={text}>
//                     <ListItemText primary={text} />
//                   </ListItem>
//                 ))}
//               </List>
//             </Drawer>
//           </Grid>
//
//           <Grid item xs={10} className={classes.content}>
//         <RoutingComponent />
//           </Grid>
//         </Grid>
//
//
//
//       </Router>
//     </ApolloProvider>
//   );
// };


import { Button } from '@material-ui/core';
import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Drawer from '@material-ui/core/Drawer';
import AppBar from '@material-ui/core/AppBar';
import CssBaseline from '@material-ui/core/CssBaseline';
import Toolbar from '@material-ui/core/Toolbar';
import List from '@material-ui/core/List';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import ApolloProvider from 'react-apollo/ApolloProvider';
import { BrowserRouter as Router, Link } from 'react-router-dom';
import { Dashboard } from './app/dashboard/Dashbaord';
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
            <List>
              { ['Inbox', 'Starred', 'Send email', 'Drafts'].map((text, index) => (
                <ListItem button key={ text }>
                  <ListItemText primary={ text } />
                </ListItem>
              )) }
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