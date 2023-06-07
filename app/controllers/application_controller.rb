class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    protected 

    def isp_auth
        @token = request.headers["Authorization"] #obtiene el token del isp
        @current_isp = Isp.find_by(token: @token) #busca isp con el token
        return if @current_isp.present?
        respond_to do |format|
            format.json {render status: 404, json: { message: "Isp no existe" }}
        end
    end

    def client_auth 
        @token = request.headers["Authorization"] #obtiene el token del isp
        @current_client= Client.find_by(token: @token) #busca isp con el token
        return if @current_client.present?
        respond_to do |format|
            format.json {render status: 404, json: { message: "Cliente no existe" }}
        end
    end
end
