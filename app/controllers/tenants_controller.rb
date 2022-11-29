class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_invalid_record
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_not_found

    def index
        render json: Tenant.all, status: :ok
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(create_tenant)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update
        render json: tenant, status: :updated
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        render json: tenant, status: :not_found
    end

    private
    def create_tenant
        params.permit(:name, :age)
    end

    def rescue_from_not_found
        render json: {errors: "Tenant not found"}, status: :not_found
    end

    def rescue_from_invalid_record(e)
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

end
