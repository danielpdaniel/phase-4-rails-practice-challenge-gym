class MembershipsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

    def create
        membership = Membership.create!(permitted_params)
        render json: membership, status: :ok
    end

    private

    def render_record_invalid(invalid)
        render json: { errors: [invalid.record.errors]}, status: :unprocessable_entity
    end

    def permitted_params
        params.permit(:gym_id, :client_id, :charge)
    end
end
