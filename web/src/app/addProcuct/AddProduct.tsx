import { gql } from 'apollo-boost';
import { Field, FieldProps, Form, Formik, FormikProps } from 'formik';
import * as React from 'react';
import { client } from '../../lib/apollo/client';

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

  const {data} = await client.mutate<ProductValues>({
    mutation: ADD_PRODUCT,
    variables: {
      name: values.name,
      description: values.description,
      price: values.price
    }});

  console.log(typeof values.price, data);
};

export const PriceComponent = ({ field }: FieldProps<ProductValues>) => (
  <input type="number" { ...field } />
);

export const TextComponent: React.FC<FieldProps<ProductValues>> = ({
  field
}) => (
  <div>
    <input type="text" { ...field } />
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
              component={TextComponent}
            />
            <Field
              name="description"
              component={TextComponent}
            />
            <Field
              name="price"
              component={ PriceComponent }
              type="number"
            />

            <button type="submit">Dodaj</button>
          </Form>
        ) }
      />
    </div>
  );
};