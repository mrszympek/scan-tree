import gql from 'graphql-tag';
import { useEffect, useState } from 'react';
import * as React from 'react';
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
      {
        products &&
        products.map(  (e: Product, index) => (
          <div key={index}>
            <Link to={`/product/${e.id}`}>{e.name}</Link>
          </div>
        ) )
      }
    </div>
  );
};