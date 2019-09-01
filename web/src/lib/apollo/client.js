import { ApolloClient } from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import { HttpLink } from 'apollo-link-http';

const cache = new InMemoryCache();

const link = new HttpLink({
  uri: 'https://eu1.prisma.sh/bartek-piela-09119b/scantree/dev'
});

export const client = new ApolloClient({
  cache,
  link
});