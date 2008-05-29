require 'rubygems'
require 'net/http'
require 'hpricot'

module TermExtractor
  
  # Interface to the {Yahoo Term Extractor API}[http://developer.yahoo.com/search/content/V1/termExtraction.html].

  class Yahoo

    HOST = "search.yahooapis.com"
    PATH = "/ContentAnalysisService/V1/termExtraction"

    # Create a new Yahoo Term Extractor instance. A valid API key must be provided.

    def initialize(api_key)
      @api_key = api_key
    end
    
    # Extracts terms from content provided. Provide an optional query to provide context for your terms.

    def get_terms(content, query = nil)
      response = Net::HTTP.post_form(uri, query_hash(content, query))
      raise RemoteServerError unless response.code == "200"
      terms = parse_for_terms(response.body)
    end
    
    private
    
    # Parse XML from a string for terms.
    
    def parse_for_terms(xml_string)
      doc = Hpricot(xml_string)
      terms = doc.search("//result").map { |r| r.inner_html }
    end
    
    def uri
      URI::HTTP.build({ :host => HOST, :path => PATH })
    end
    
    def query_hash(content, query)
      post_arguments = {
        'appid' => @api_key,
        'context' => content,
        'query' => query
      }
    end
    
  end

end