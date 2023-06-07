class IspsController < ApplicationController
    before_action :isp_auth, only: [:plans]

    def create
        isp = Isp.new(isp_params)
        respond_to do |format|
            if isp.save 
                format.json {render status: 200, json: isp}
            else
                format.json {render status: 400, json: isp.errors.full_messages}
            end
        end
    end

    def plans
        respond_to do |format|
            format.json {render status: 200, json: @current_isp.plans} #planes del isp
        end 
    end

    private
    def isp_params
        params.permit(:name, :username, :password)
    end
end
