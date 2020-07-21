Infusionsoft.configure do |config|
  config.api_url = 'hz105.infusionsoft.com' # example infused.infusionsoft.com DO NOT INCLUDE https://
  config.api_key = '4bebf41fd545b982ae11f569e820cc33'
  config.api_logger = Logger.new("#{Rails.root}/log/infusionsoft_api.log") # optional logger file
end