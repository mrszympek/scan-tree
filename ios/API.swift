//  This file was automatically generated and should not be edited.

import Apollo

public final class AllProductsQuery: GraphQLQuery {
  /// query AllProducts {
  ///   products {
  ///     __typename
  ///     ...ProductDetails
  ///   }
  /// }
  public let operationDefinition =
    "query AllProducts { products { __typename ...ProductDetails } }"

  public let operationName = "AllProducts"

  public var queryDocument: String { return operationDefinition.appending(ProductDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("products", type: .nonNull(.list(.object(Product.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(products: [Product?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "products": products.map { (value: Product?) -> ResultMap? in value.flatMap { (value: Product) -> ResultMap in value.resultMap } }])
    }

    public var products: [Product?] {
      get {
        return (resultMap["products"] as! [ResultMap?]).map { (value: ResultMap?) -> Product? in value.flatMap { (value: ResultMap) -> Product in Product(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Product?) -> ResultMap? in value.flatMap { (value: Product) -> ResultMap in value.resultMap } }, forKey: "products")
      }
    }

    public struct Product: GraphQLSelectionSet {
      public static let possibleTypes = ["Product"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(ProductDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, description: String, price: Int) {
        self.init(unsafeResultMap: ["__typename": "Product", "id": id, "name": name, "description": description, "price": price])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var productDetails: ProductDetails {
          get {
            return ProductDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct ProductDetails: GraphQLFragment {
  /// fragment ProductDetails on Product {
  ///   __typename
  ///   id
  ///   name
  ///   description
  ///   price
  /// }
  public static let fragmentDefinition =
    "fragment ProductDetails on Product { __typename id name description price }"

  public static let possibleTypes = ["Product"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .nonNull(.scalar(String.self))),
    GraphQLField("price", type: .nonNull(.scalar(Int.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, description: String, price: Int) {
    self.init(unsafeResultMap: ["__typename": "Product", "id": id, "name": name, "description": description, "price": price])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var description: String {
    get {
      return resultMap["description"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  public var price: Int {
    get {
      return resultMap["price"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "price")
    }
  }
}
