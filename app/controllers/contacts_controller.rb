class ContactsController < ApplicationController
  



  def create
    @contact, @success = GetContactService.new(params[:object_keys][0][:id]).check_status
    if @success == 200
      first_name = @contact["given_name"]
      last_name = @contact["family_name"]
      email = @contact["email_addresses"][0]["email"]
      postal_code = @contact["addresses"][0]["postal_code"]
      puts "===================================================First Name: #{first_name}=======Last Name: #{last_name}===========Email: #{email}=========Postal Code: #{postal_code}"
      query = { 
        "FirstName"     => first_name,
        "Surname"      => last_name,
        "EmailAddress" => email

      }
      headers = { 
        "secKey"  => "616FFBF7-8398-431D-A234-BB56BE49DF9B",
        "destKey" => "3FFB2ED4-0CEB-4F49-B3BB-85E3F7CBD265" 
      }

      response = HTTParty.post(
        "https://integration.greenlightcrm.com/GLIntegrationAPI.asmx?op=AddContact", 
        :query => query,
        :headers => headers
      )

      puts "=========================Response==================#{response}"
    end
    # response.set_header("X-Hook-Secret", request.env["HTTP_X_HOOK_SECRET"]) if request.env["HTTP_X_HOOK_SECRET"].present?
    # render json: 200
  end

  def index
    
  end
end
