require "spec"
require "../src/cr-graphql-client"

def create_test_client()
    gqlobject = Cr::Graphql::Client::GraphQLClient.new "https://graphql.org/swapi-graphql"
    
end
