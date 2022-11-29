class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_not_found
rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_invalid_record
    
    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create!(create_apartment)
        render json: apartment, status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update
        render json: apartment, status: :updated
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        render json: apartment, status: :not_found
    end

    private

    def create_apartment
        params.permit(:number)
    end

    def rescue_from_not_found
        render json: {errors: "Apartment not found"}
    end

    def rescue_from_invalid_record(e)
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end
end
