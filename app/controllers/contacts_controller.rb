class ContactsController < ApplicationController

  def create
    @contact, @success = GetContactService.new(params[:object_keys][0][:id]).check_status
    if @success == 200
      first_name = @contact["given_name"]
      last_name = @contact["family_name"]
      email = @contact["email_addresses"][0]["email"]
      postal_code = @contact["addresses"][0]["postal_code"]
      phone_number = @contact["phone_numbers"][0]["number"]
      Rails.logger.info "===================================================First Name: #{first_name}=======Last Name: #{last_name}===========Email: #{email}=========Postal Code: #{postal_code}================Phone Number: #{phone_number}"
      
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
    # response.set_header("X-Hook-Secret", request.env["HTTP_X_HOOK_SECRET"]) if request.env["HTTP_X_HOOK_SECRET"].present?
    # render json: 200
  end

  def index
  end
end
