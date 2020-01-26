require "http/client"
require "uri"
# A simple, low level graphql client for crystal
module GraphQLClient
  extend self
  VERSION = "0.1.0"

  class GraphQLClient
    @host : URI
    @endpoint : String
    @client : HTTP::Client

    #Create a new client with 
    #```GraphQLClient.new endpoint```
    #for example
    #```qqlclient = GraphQLClient.new "https://graphql.org/swapi-graphql/" ```
    def initialize (host : String, endpoint : String)
      @host = URI.parse(host)
      @endpoint = endpoint
      @client = HTTP::Client.new(@host) 
    end 

    def fetch (query : String , headers : HTTP::Headers)
      begin 
        response = @client.post @endpoint , headers , query
      rescue ex
        "GraphQL Error #{ex}"
      else 
        response.body
      end 
    end 
  end 


  # TODO: Put your code here
end
