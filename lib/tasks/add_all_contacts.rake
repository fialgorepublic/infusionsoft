desc 'Add Contacts'
task add_token: :environment do
  response = HTTParty.get("https://api.infusionsoft.com/crm/rest/v1/contacts/?access_token=#{Token.first.access_token}")
  response = HTTParty.get("https://api.infusionsoft.com/crm/rest/v1/contacts/?access_token=YATkHRdu27XfA0xKQDX5fGEFsXHn")
  response["contacts"].last(3).each do |contact|
    first_name = contact["given_name"]
    last_name = contact["family_name"]
    email = contact["email_addresses"][0]["email"] if contact["email_addresses"].any?
    postal_code = contact["addresses"][0]["postal_code"] if contact["addresses"].any?
    phone_number = contact["phone_numbers"][0]["number"] if contact["phone_numbers"].any?

    client = Savon.client(
      wsdl:        "https://integration.greenlightcrm.com/GLIntegrationAPI.asmx?wsdl",
      logger:      Rails.logger,
      log_level:   :debug,
      log:         true,
    )

    data = {
       secKey: "616FFBF7-8398-431D-A234-BB56BE49DF9B",
       destKey: "3FFB2ED4-0CEB-4F49-B3BB-85E3F7CBD265", 
       FirstName:    first_name,
       Surname:      last_name,
       EmailAddress: email,
       TelephoneNumber: phone_number,
       PostCode:        postal_code,
       dataSource:          "Final Choices",
       contact: {
        ContactID: @contact["id"]
       }
    }
    response = client.call(
      :add_contact,
      message: data,
    )
    Rails.logger.info "========================================================================= Response: #{response.body}"
  end
end