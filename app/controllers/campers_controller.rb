class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_find

    def index
        campers = Camper.all 
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamverActivitySerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created 
      rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    private
    def camper_params
        params.permit(:name, :age)
    end

    def rescue_invalid_record invalid
        render json: {error: invalid.record.errors}, status: :not_found
    end
    def rescue_not_find
        render json: {error: "Camper not found"}, status: :not_found
    end

end
