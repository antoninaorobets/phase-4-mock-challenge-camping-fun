class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

    def index
        activities = Activity.all
        render json: activities
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        render json: {}, status: :no_content
    end

    private
    def rescue_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
