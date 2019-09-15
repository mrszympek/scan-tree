import React from 'react';
import { ApolloProvider } from 'react-apollo';
import { BrowserRouter as Router, Link } from 'react-router-dom';
import { client } from './lib/apollo/client';
import { RoutingComponent } from './lib/routing/routing';

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

        <RoutingComponent />
      </Router>
    </ApolloProvider>
  );
};
