class CountryGuessController < ApplicationController
  def index
    @service = CountryGuessService.new(sanitized_name)
    @service.call

    render json: @service
  end

  private

  # to avoid the possibilty to pass any extra data except name i sanitize it,
  # f.e. extra parameters or xss
  def sanitized_name
    params[:name].gsub(/[^A-Za-z ]/i, '')
  end
end
