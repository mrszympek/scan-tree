import gql from 'graphql-tag';
import * as React from 'react';
import { useEffect, useState } from 'react';
import { client } from '../../lib/apollo/client';
import { Product } from '../../lib/prisma/generated/prisma-client/index';

export const fetchExactProductData = async(
  setProduct: React.Dispatch<React.SetStateAction<Product>>,
  id: any
) => {
  const {data} = await client.query({
    query: GET_EXACT_PRODUCT,
    variables: { id: id}
  });

  if(data) {
    setProduct(data.products[0])
  }
};

export const GET_EXACT_PRODUCT = gql`
    query getExactProduct($id: ID!){
        products(where: {id: $id }) {
            name
            description
            price
        }
    }
`;

export const ProductPage = ({match}: any) => {
  const [product, setProduct] = useState<Product>({} as Product);

  useEffect(() => {
    const id = match && match.params && match.params.id;

    fetchExactProductData(setProduct, id);
  }, [product]);

  return (
    <>
      <h3>Nazwa produktu: {product.name} </h3>
      <h3>Opis: {product.description} </h3>
      <h3>Cena: {product.price} </h3>
    </>
  )
};