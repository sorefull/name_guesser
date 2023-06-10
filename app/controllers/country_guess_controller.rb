class CountryGuessController < ApplicationController
  def index
    @service = CountryGuessService.new(params[:name])
    @service.call

    render json: @service
  end
end
