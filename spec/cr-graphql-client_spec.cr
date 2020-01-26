require "./spec_helper"
require "../src/cr-graphql-client.cr"
require "http/headers"

describe GraphQLClient do
  
  # Test initialization
  describe "create client and make a query" do
    it "should not raise an error on creation of client" do
      gqlclient = GraphQLClient::GraphQLClient.new "https://api.spacex.land" , "/graphql"
      typeof(gqlclient).should eq GraphQLClient::GraphQLClient
    end

    it "should return the expected json" do 
      gqlclient = GraphQLClient::GraphQLClient.new "https://api.spacex.land", "/graphql"
      headers = HTTP::Headers{"Content-Type" => "application/json", "Accept" => "application/json"}
      response = gqlclient.fetch("{\"query\":\"{ ships {id}}\",\"variables\":null}", headers)
      response.should eq "{\"data\":{\"ships\":[{\"id\":\"GOMSTREE\"},{\"id\":\"GOPURSUIT\"},{\"id\":\"AMERICANCHAMPION\"},{\"id\":\"GOQUEST\"},{\"id\":\"GONAVIGATOR\"},{\"id\":\"JRTI-2\"},{\"id\":\"NRCQUEST\"},{\"id\":\"OCISLY\"},{\"id\":\"PACIFICWARRIOR\"},{\"id\":\"PACIFICFREEDOM\"},{\"id\":\"BETTYRGAMBARELLA\"},{\"id\":\"AMERICANISLANDER\"},{\"id\":\"GOSEARCHER\"},{\"id\":\"ELSBETH3\"},{\"id\":\"KELLYC\"},{\"id\":\"JRTI-1\"},{\"id\":\"ASOG\"},{\"id\":\"HAWK\"},{\"id\":\"RACHEL\"},{\"id\":\"AMERICANSPIRIT\"},{\"id\":\"HOLLYWOOD\"},{\"id\":\"GOMSCHIEF\"}]}}\n"
    end 

    it "secured server access" do
      gqlclient = GraphQLClient::GraphQLClient.new "https://hasura-pass.herokuapp.com", "/v1/graphql"
      headers = HTTP::Headers{"Content-Type" => "application/json" , "Accept" => "application/json", "x-hasura-admin-secret" => "cr-graphql-secret"}
      response = gqlclient.fetch %({"query":"query MyQuery {\n  test_table {\n    created_at\n    id\n    name\n    updated_at\n  }\n}\n","variables":null,"operationName":"MyQuery"}) , headers
      response.should eq %({\"data\":{\"test_table\":[{\"created_at\":\"2020-01-26T20:28:50.006041+00:00\",\"id\":1,\"name\":\"first\",\"updated_at\":\"2020-01-26T20:28:50.006041+00:00\"}]}})
    end

  end 

end 
