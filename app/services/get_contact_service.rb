class GetContactService
  attr_reader :contact_id, :base_url
  require 'faraday'
  require 'uri'
  CLIENT_ID = "zj4a8rq2auuc66zyu2npefdt"
  CLIENT_SECRET = "Pf4Q3yxMRy"

  def initialize(contact_id)
    @base_url = "https://api.infusionsoft.com/crm/rest/v1/contacts"
    @contact_id = contact_id

  end

  def check_status
    response = HTTParty.get("#{base_url}/#{contact_id}?access_token=#{Token.first.access_token}")
    [response, response.code] 
  end

    
end
