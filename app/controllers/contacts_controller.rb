class ContactsController < ApplicationController

  def create
    @contact, @success = GetContactService.new(params[:object_keys][0][:id]).check_status
    Rails.logger.info "======================@contact: #{@contact}===============================@success: #{@success}"
    if @success == 200
      first_name = @contact["given_name"] if @contact["given_name"].present?
      last_name = @contact["family_name"] if @contact["family_name"].present?
      email = @contact["email_addresses"][0]["email"] if @contact["email_addresses"].any?
      postal_code = @contact["addresses"][0]["postal_code"] if @contact["addresses"].any? 
      phone_number = @contact["phone_numbers"][0]["number"] if @contact["phone_numbers"].any?
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
          dataSource:          "Final Choices",
          contact: {
            ContactID: @contact["id"],
            FirstName:    first_name,
            Surname:      last_name,
            EmailAddress: email,
            TelephoneNumber: phone_number,
            PostCode:        postal_code
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
