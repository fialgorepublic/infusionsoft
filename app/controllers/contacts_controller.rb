class ContactsController < ApplicationController
  



  def create
    @contact, @success = GetContactService.new(params[:object_keys][0][:id]).check_status
    if @success == 200
      first_name = @contact["family_name"]
      last_name = @contact["given_name"]
      email = @contact["email_addresses"][0]["email"]
      postal_code = @contact["addresses"][0]["postal_code"]
      puts "===================================================First Name: #{first_name}=======Last Name: #{last_name}===========Email: #{email}=========Postal Code: #{postal_code}"
    end
    # response.set_header("X-Hook-Secret", request.env["HTTP_X_HOOK_SECRET"]) if request.env["HTTP_X_HOOK_SECRET"].present?
    # render json: 200
  end

  def index
    
  end
end
