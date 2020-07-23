class GetContactService
  attr_reader :contact_id, :base_url
  require 'faraday'
  require 'uri'
  CLIENT_ID = "zj4a8rq2auuc66zyu2npefdt"
  CLIENTsECRET = "Pf4Q3yxMRy"

  def initialize(contact_id)
    @base_url = "https://api.infusionsoft.com/crm/rest/v1/contacts"
    @contact_id = contact_id

  end

  def check_status
    if Token.first.updated_at < 23.hour.ago
      data = {
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        grant_type: "refresh_token",
        refresh_token: Token.first.refresh_token
      }
      url = "https://api.infusionsoft.com/token"
      response = Faraday.post(url) do |req|
        req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        req.body = URI.encode_www_form(data)
      end
      response_body = JSON.parse(response.body)
      token = Token.first
      token.update_attributes(access_token: body["access_token"], refresh_token: body["refresh_token"])
    end
    response = HTTParty.get("#{base_url}/#{contact_id}?access_token=#{Token.first.access_token}")
    [response, response.code] 
  end

    
end
