import React from 'react';
import './App.css';
import {BrowserRouter as Router, Route, Link} from "react-router-dom";
import { AddProduct } from './app/addProcuct/AddProduct';
import {Dashboard} from "./app/dashboard/Dashbaord";
import {ApolloProvider} from "react-apollo";
import {client} from "./lib/apollo/client";

export const App = () => {

  return (
    <ApolloProvider client={client}>
      <Router>
        <div className="App">
          <Link to="/dashboard">
            Zaloguj
          </Link>
          <h2>App Inint <span role="img" aria-label="rocket">🚀</span></h2>
        </div>

        <Route path="/dashboard" component={Dashboard}/>
        <Route path="/add-product" component={AddProduct}/>
      </Router>
    </ApolloProvider>
  );
};
