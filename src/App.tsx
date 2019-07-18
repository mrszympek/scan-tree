import React, {useEffect} from 'react';
import './App.css';
import {BrowserRouter as Router, Route, Link} from "react-router-dom";
import {Dashboard} from "./app/dashboard/Dashbaord";
import {ApolloProvider} from "react-apollo";
import {client} from "./lib/apollo/client";
import gql from "graphql-tag";

export const DUPA = gql`
 query {
   products {
     name
     description
     price
   }
 }
`;

export const xxx = async () => {
  const { data } = await client.query({query: DUPA});

  if(data) {
    console.log(data)
  }
};

export const App = () => {
  useEffect( () => {
    xxx()
  }, []);

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
      </Router>
    </ApolloProvider>
  );
};
