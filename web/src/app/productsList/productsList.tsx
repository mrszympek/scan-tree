import { Table } from '@material-ui/core';
import Container from '@material-ui/core/Container';
import Paper from '@material-ui/core/Paper';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import gql from 'graphql-tag';
import * as React from 'react';
import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { client } from '../../lib/apollo/client';
import { Product } from '../../lib/prisma/generated/prisma-client/index';

export const GET_PRODUCTS = gql`
    query {
        products {
            name
            id
            price
            description
        }
    }
`;

export const getProducts = async (
  setProductsData: React.Dispatch<React.SetStateAction<Product[]>>
) => {
  const { data } = await client.query({
    query: GET_PRODUCTS
  });

  if (data) {
    setProductsData(data.products);
  } else {
    console.warn('brak danych');
  }
};

export const ProductsList = () => {
  const [products, setProductsData] = useState<Product[]>([]);

  useEffect(() => {
    getProducts(setProductsData);
  }, [products]);

  return (
    <div>
      <Container maxWidth={'xl'}>
        <Paper>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Nazwa Produktu</TableCell>
                <TableCell>Data dodania</TableCell>
                <TableCell>Cena</TableCell>
                <TableCell>Dział</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {
                products.map(row => (
                  <TableRow key={ row.id }>
                    <TableCell>
                      <Link to={ `/product/${ row.id }` }>{ row.name }</Link>
                    </TableCell>
                    <TableCell>12.11.2019</TableCell>
                    <TableCell>{ row.price }</TableCell>
                    <TableCell>Wrzosy</TableCell>
                  </TableRow>
                ))
              }
            </TableBody>
          </Table>
        </Paper>
      </Container>
    </div>
  );
};