class ClientsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def show
        client = Client.find(params[:id])

        render json: client, status: :ok
    end

    def index
        clients = Client.all
        render json: clients, status: :ok
    end

    def update
        client = Client.find(params[:id])
        client.update!(permitted_params)
        render json: client, status: :accepted
    end

    

    private
    def render_record_not_found
        render json: { error: "Client not found" }, status: :not_found
    end

    def render_record_invalid(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def permitted_params
        params.permit(:name, :age)
    end
end
