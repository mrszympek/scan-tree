"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var prisma_lib_1 = require("prisma-client-lib");
var typeDefs = require("./prisma-schema.graphql").typeDefs;

var models = [
  {
    name: "User",
    embedded: false
  },
  {
    name: "Product",
    embedded: false
  }
];
exports.Prisma = prisma_lib_1.makePrismaClientClass({
  typeDefs,
  models,
  endpoint: `https://eu1.prisma.sh/bartek-piela-09119b/scantree/dev`
});
exports.prisma = new exports.Prisma();
