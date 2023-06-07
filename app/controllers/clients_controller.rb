class ClientsController < ApplicationController
    
    def create
        client = Client.new(client_params)
        respond_to do |format|
            if client.save #true/false si se guardo o no
                format.json {render status: 200, json: client}
            else
                format.json {render status: 400, json: client.errors.full_messages}
            end
        end
    end
    
    private
    
    def client_params
        params.permit(:name, :email, :password, :address)
    end

end
