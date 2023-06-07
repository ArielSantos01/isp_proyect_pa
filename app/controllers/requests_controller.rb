class RequestsController < ApplicationController
    before_action :isp_auth, only: [:index, :approve, :rejected]
    before_action :client_auth, only: [:rejected_request]
    before_action :set_request, only: [:approve, :rejected]

    def index
        respond_to do |format|
            format.json {render status: 200, json: @current_isp.requests.where(status:'pending')} #solicitudes pendientes 
        end 
    end

    def rejected_request
        respond_to do |format|
            @req = @current_client.requests.where(created_at: 1.month.ago..Time.now, status:'rejected')
            response = @req.map do |request|
                {
                    status: request.status,
                    isp_id: request.isp_id,
                    plan_id: request.plan_id,
                    created_at: request.created_at
                }
            end
            format.json {render status: 200, json: response}
        end
    end

    def approve
        respond_to do |format|
            begin
            if  @request.change?
                #busco la ultima solicitud aprovada, la cancelo y apruebo la solicitud de cambio
                @client = @request.client
                @last_req = @client.requests.find_by(status: 'approved')
                @last_req.canceled!
                @request.approved!
                format.json {render status: 200, json: @request}
            else
                @request.approved!
                format.json {render status: 200, json: @request}

            end
            rescue StandardError => exception 
                format.json {render status: 400, json: exception.message}
            end
        end
    end

    def rejected
        respond_to do  |format|
            begin
            @request.rejected!
            format.json {render status: 200, json: { message: "Se ha rechazado la solicitud" }}
            rescue StandardError => exception 
                format.json {render status: 400, json: exception.message}
            end
        end
    end

    private
    def set_request 
        @request = @current_isp.requests.find_by(id: params[:id])
        return if @request.present?
        respond_to do |format|
            format.json {render status: 404, json: { message: "No se ha encontrado la request con ese id" }}
        end
    end


end
