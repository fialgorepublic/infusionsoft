class GetContactService
  attr_reader :contact_id, :base_url

  ACCESS_TOKEN = "bV7CBT3uGnFsD600bgbrbWc3AlsN"

  def initialize(contact_id)
    @base_url = "https://api.infusionsoft.com/crm/rest/v1/contacts"
    @contact_id = contact_id
  end

  def check_status
    response = HTTParty.get("#{base_url}/#{contact_id}?access_token=#{ACCESS_TOKEN}")
    [response, response.code] 
  end

    
end
