class PlansController < ApplicationController
    before_action :isp_auth, only: [:create]
    before_action :client_auth,:set_plan, only: [:create_request, :change_request]

    def index
        respond_to do |format|
            format.json {render status:200, json: Isp.all.as_json(only: [:name], include: { plans: {only: [:name, :speed, :price]}})}
        end
    end

    def create
        plan = Plan.new(plan_params)
        plan.isp_id = @current_isp.id
        respond_to do |format|
            if plan.save 
                format.json {render status: 200, json: plan}
            else
                format.json {render status: 400, json: plan.errors.full_messages}
            end 
        end
    end

    def create_request 
        respond_to do |format|
            request = Request.new(plan: @plan, client: @current_client, isp_id: @plan.isp_id )
            if request.save
                format.json {render status: 200, json: request} 
            else
                format.json {render status: 400, json: request.errors.full_messages}
            end
        end 
    end
    
    def change_request 
        respond_to do |format|
            request = Request.new(plan: @plan, client: @current_client, isp_id: @plan.isp_id, type_request: 1 )
            if request.save
                format.json {render status: 200, json: request} 
            else
                format.json {render status: 400, json: request.errors.full_messages}
            end
        end 
    end

    private 
    def plan_params
        params.permit(:name, :speed, :price)
    end

    def set_plan 
        @plan = Plan.find_by(id: params[:id])
        return if @plan.present?
        respond_to do |format|
            format.json {render status: 400, json: { message: "El plan no existe" }}
        end
    end
end
