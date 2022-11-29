class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_invalid_record
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_not_found
    
        def create
            tenant = Tenant.create!(create_lease)
            render json: tenant, status: :created
        end
    
        def destroy
            tenant = Tenant.find(params[:id])
            tenant.destroy
            render json: tenant, status: :not_found
        end
    
        private
        def create_lease
            params.permit(:apartment_id, :tenant_id, :rent)
        end
    
        def rescue_from_not_found
            render json: {errors: "Lease not found"}, status: :not_found
        end
    
        def rescue_from_invalid_record(e)
            render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
        end
end
