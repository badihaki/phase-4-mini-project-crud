class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    wrap_parameters format: []

    def index
        render json: Spice.all, status: :ok
    end

    def create
        new_spice = Spice.create(spice_params)
        render json: new_spice, status: :created
    end

    def update
        old_spice = find_spice
        old_spice.update(spice_params)
        render json: old_spice, status: :accepted
    end

    def destroy
        old_spice = find_spice
        old_spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found_response
        render json: {error: "Item not found"}, status: :not_found
    end
    
end
