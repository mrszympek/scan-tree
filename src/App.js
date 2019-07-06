import React from 'react';
import './App.css';
import {BrowserRouter as Router, Route, Link} from "react-router-dom";
import {Dashboard} from "./app/dashboard/Dashbaord";
import {ApolloProvider, Query} from "react-apollo";
import {client} from "./lib/apollo/client";
import gql from "graphql-tag";

export const GET_USERS = gql`
  query {
      users {
          name
          id
      }
  }
`;

export const Users = () => (
  <Query
    query={GET_USERS}
  >
    {({loading, error, data}) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;

      return data.users.map(({id, name}) => (
        <div key={id}>
          <p>{name}: {id}</p>
        </div>
      ));
    }}
  </Query>
);

export const App = () => {
  return (
    <ApolloProvider client={client}>
      <Router>
        <div className="App">
          <Link to="/dashboard">
            Zaloguj
          </Link>
          <h2>App Inint <span role="img" aria-label="rocket">🚀</span></h2>
          <Users/>
        </div>

        <Route path="/dashboard" component={Dashboard}/>
      </Router>
    </ApolloProvider>
  );
};

export default App;
