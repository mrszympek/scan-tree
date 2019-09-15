import { TextField } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import { gql } from 'apollo-boost';
import { Field, FieldProps, Form, Formik, FormikProps } from 'formik';
import * as React from 'react';
import { client } from '../../lib/apollo/client';
import { GET_PRODUCTS } from '../productsList/productsList';

export type ProductValues = {
  name: string,
  description: string,
  price: number,
}

export const productInitialValues: ProductValues = {
  name: '',
  description: '',
  price: 0,
};

export const ADD_PRODUCT = gql`
    mutation addProduct($name: String!, $description: String!, $price: Int!) {
        createProduct(data: {
            name: $name,
            description: $description,
            price: $price
        })
        {
            name
            id
        }
    }
`;

export const handleFormSubmit = async (values: ProductValues) => {

  const { data } = await client.mutate<ProductValues>({
    mutation: ADD_PRODUCT,
    refetchQueries: GET_PRODUCTS,
    variables: {
      name: values.name,
      description: values.description,
      price: values.price
    }
  });

  console.log(typeof values.price, data);
};

export const PriceComponent = ({ field }: FieldProps<ProductValues>) => (
  <TextField
    required
    type="number"
    id="standard-required"
    label="Required"
    defaultValue="Hello World"
    margin="normal"
    { ...field }
  />);

export const TextComponent: React.FC<FieldProps<ProductValues>> = ({
  field
}) => (
  <div>
    <TextField
      required
      id="standard-required"
      label="Required"
      defaultValue="Hello World"
      margin="normal"
      { ...field }
    />
  </div>
);

export const AddProduct = () => {
  return (
    <div>
      <h4>Dodaj nowy produkt</h4>

      <Formik
        initialValues={ productInitialValues }
        onSubmit={ (values) => handleFormSubmit(values) }
        render={ (formikBag: FormikProps<ProductValues>) => (
          <Form>
						<pre>
							{
                JSON.stringify(formikBag, null, 2)
              }
						</pre>
            <Field
              name="name"
              component={ TextComponent }
            />
            <Field
              name="description"
              component={ TextComponent }
            />
            <Field
              name="price"
              component={ PriceComponent }
              type="number"
            />

            <div>
              <Button
                color="primary"
                variant="contained"
                type="submit"
              >
                Dodaj produkt
              </Button>
            </div>
          </Form>
        ) }
      />
    </div>
  );
};