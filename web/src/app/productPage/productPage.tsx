import gql from 'graphql-tag';
import * as React from 'react';
import { useEffect, useState } from 'react';
import { client } from '../../lib/apollo/client';
import { Product } from '../../lib/prisma/generated/prisma-client/index';
import QRCode from 'qrcode.react';

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

export const GeneratedQRCode:React.FC<{id: any}> = ({id}) => <QRCode value={id} />;

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
  const [productId, setProductId] = useState<string>('');

  useEffect(() => {
    const id = match && match.params && match.params.id;

    setProductId(id);
    fetchExactProductData(setProduct, id);
  }, [productId]);


  if(!product.name) {
    return <></>
  }

  return (
    <>
      <h3>Nazwa produktu: {product.name} </h3>
      <h3>Opis: {product.description} </h3>
      <h3>Cena: {product.price} </h3>
      <GeneratedQRCode id={productId} />
    </>
  )
};