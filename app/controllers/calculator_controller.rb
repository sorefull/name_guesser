class CalculatorController < ApplicationController
  def index
    service = CalculatorService.new(params[:expression])

    begin
      service.call

      render json: service
    rescue CalculatorService::CalculationError => e
      render json: { errors: e.message }, status: 422
    end
  end
end
