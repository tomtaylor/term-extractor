# $Id$

require File.join(File.dirname(__FILE__), %w[spec_helper])

describe TermExtractor::Yahoo, "which is extracting the terms from some text" do
  
  def mock_valid_response
    mock(Net::HTTPOK, :code => "200", :body => asset_as_string("yahoo_valid_response.xml"))
  end
  
  def mock_invalid_response
    mock(Net::HTTPInternalServerError, :code => "500", :body => "")
  end
  
  describe "and the server responses as expected" do
    before(:each) do
      Net::HTTP.should_receive(:post_form).and_return(mock_valid_response)
      @te = TermExtractor::Yahoo.new("waffles")
    end

    it "should return the correct set of terms" do
      content = asset_as_string("content.sample")
      @te.get_terms(content).should == ["english", "waffles", "stuff like that"]
    end
  end
  
  describe "and the server responds badly" do
    before(:each) do
      Net::HTTP.should_receive(:post_form).and_return(mock_invalid_response)
      @te = TermExtractor::Yahoo.new("waffles")
    end

    it "should raise an error" do
      content = asset_as_string("content.sample")
      lambda {@te.get_terms(content)}.should raise_error(TermExtractor::RemoteServerError)
    end
    
  end
  
  
end

# EOF
