# frozen_string_literal: true

class CountryGuessController < ApplicationController
  def index
    service = CountryGuessService.new(sanitized_name)

    begin
      service.call

      render json: service
    rescue GenderApi::Client::GenderApiError => e
      render json: { errors: e.message }, status: 422
    end
  end

  private

  # to avoid the possibilty to pass any extra data except name i sanitize it,
  # f.e. extra parameters or xss
  def sanitized_name
    params[:name].gsub(/[^\p{L} ]/i,'')
  end
end
