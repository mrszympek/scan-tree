import { TextField } from '@material-ui/core';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import { gql } from 'apollo-boost';
import { Field, FieldProps, Form, Formik, FormikProps } from 'formik';
import * as React from 'react';
import { client } from '../../lib/apollo/client';
import { Product } from '../../lib/prisma/generated/prisma-client/index';
import { GET_PRODUCTS } from '../productsList/productsList';

export type ProductValues = Omit<Product, 'id'>;

export const productInitialValues: ProductValues= {
  name: '',
  latinName: '',
  category: '',
  createDate: '',
  height: 0,
  description: '',
  price: 0,
  variety: '',
  destinationCountry: '',
};

export const ADD_PRODUCT = gql`
    mutation addProduct(
        $name: String!, 
        $description: String!, 
        $price: Float!, 
        $category: String!,
        $destinationCountry: String!,
        $height: Float!,
        $latinName: String!,
        $variety: String!
    ) {
        createProduct(data: {
            name: $name,
            description: $description,
            price: $price,
            category: $category,
            createDate: "2015-11-22T13:57:31.123Z",
            destinationCountry: $destinationCountry,
            height: $height,
            latinName: $latinName,
            variety: $variety,
             
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
      price: values.price,
      category: values.category,
      createDate: "2015-11-22T13:57:31.123Z",
      destinationCountry: values.destinationCountry,
      height: values.height,
      latinName: values.latinName,
      variety: values.variety,
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
    margin="normal"
    fullWidth={true}
    { ...field }
  />);

export const TextComponent: React.FC<FieldProps<ProductValues>> = ({
  field
}) => (
  <div>
    <TextField
      required
      id="standard-required"
      label={field.name}
      margin="normal"
      fullWidth={true}
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
              <Grid container spacing={3}>
                <Grid item xs={4}>
                  <Field
                    name="name"
                    component={ TextComponent }
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="description"
                    component={ TextComponent }
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="price"
                    component={ PriceComponent }
                    type="number"
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="latinName"
                    component={ TextComponent }
                    type="number"
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="category"
                    component={ TextComponent }
                    type="number"
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="variety"
                    component={ TextComponent }
                    type="number"
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="height"
                    component={ PriceComponent }
                    type="number"
                  />
                </Grid>
                <Grid item xs={4}>
                  <Field
                    name="destinationCountry"
                    component={ TextComponent }
                    type="number"
                  />
                </Grid>
              </Grid>

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