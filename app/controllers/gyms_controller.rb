class GymsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def show
        gym = Gym.find(params[:id])
        render json: gym, status: :ok
    end

    def index
        gyms = Gym.all
        render json: gyms, status: :ok
    end

    def update
        gym = Gym.find(params[:id])
        gym.update!(permitted_params)
        render json: gym, status: :accepted
    end
    
    def destroy
        gym = Gym.find(params[:id])
        gym.destroy!
        render json: [], status: :no_content
    end

    private
    
    def render_record_not_found
        render json: { error: "Gym not found" }, status: :not_found
    end

    def render_record_invalid(invalid)
        render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
    end

    def permitted_params
        params.permit(:name, :address)
    end
end
