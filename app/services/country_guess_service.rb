require 'gender_api/client'

class CountryGuessService
  attr_reader :full_name, :guessed_country, :time_processed

  def initialize(full_name)
    @full_name = sanitized_name(full_name)
  end

  def call
    response = GenderApi::Client.countries_of_origin(full_name)

    @guessed_country = formated_countries(response)
    @time_processed = response.response_time

    true
  end

  private

  def formated_countries(response)
    response.countries.map { |c| c['country'] }
  end

  # to avoid the possibilty to pass any extra data except name i sanitize it,
  # f.e. extra parameters or xss
  def sanitized_name(full_name)
    full_name.gsub(/[^A-Za-z ]/i, '')
  end
end
