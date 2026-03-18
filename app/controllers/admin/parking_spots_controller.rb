module Admin
  class ParkingSpotsController < BaseController
    before_action :set_parking_spot, only: [:edit, :update, :toggle]

    def index
      @parking_spots = ParkingSpot.order(:name)
    end

    def new
      @parking_spot = ParkingSpot.new
    end

    def create
      @parking_spot = ParkingSpot.new(parking_spot_params)
      if @parking_spot.save
        redirect_to admin_parking_spots_path, notice: "Lugar criado."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @parking_spot.update(parking_spot_params)
        redirect_to admin_parking_spots_path, notice: "Lugar atualizado."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def toggle
      @parking_spot.update!(active: !@parking_spot.active)
      redirect_to admin_parking_spots_path, notice: "Lugar #{@parking_spot.active? ? 'ativado' : 'desativado'}."
    end

    private

    def set_parking_spot
      @parking_spot = ParkingSpot.find(params[:id])
    end

    def parking_spot_params
      params.require(:parking_spot).permit(:name)
    end
  end
end
