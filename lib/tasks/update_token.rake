desc 'update access token'
namespace :token do
  task update_access_token: :environment do
    require 'faraday'
    require 'uri'

    CLIENT_ID = "zj4a8rq2auuc66zyu2npefdt"
    CLIENT_SECRET = "Pf4Q3yxMRy"

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
    token.update_attributes(access_token: response_body["access_token"], refresh_token: response_body["refresh_token"])
  end
end