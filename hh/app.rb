# app.rb
require "sinatra"
require 'sinatra/activerecord'
require 'docusign_esign'

class App < Sinatra::Base
  get "/" do
    p "hihihi"
    host = 'https://demo.docusign.net/restapi'
  	integrator_key = 'f0cc7d1b-4d2d-4db2-96c3-5cd1d39c5e38'
  	user_id = 'f107a1bc-3284-4690-84a8-b939c1be06b5'
  	expires_in_seconds = 3600 #1 hour
  	auth_server = 'account-d.docusign.com'
  	private_key_filename = '[REQUIRED]'
    account_id = '6038291'

    configuration = DocuSign_eSign::Configuration.new
  	configuration.host = host

  	api_client = DocuSign_eSign::ApiClient.new(configuration)
    template_id = 'c783fa52-1236-4f7b-9844-2106f4cdc594'
    api_client.update_custom_fields(account_id, template_id, )
    p "done"
    erb :index
  end
end
