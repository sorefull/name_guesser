module GenderApi
  class Client
    class GenderApiError < StandardError; end

    ClientResponse = Struct.new(:countries, :response_time)

    class << self
      def countries_of_origin(full_name)
        response = client.post('/v2/country-of-origin', full_name: full_name)

        raise GenderApiError.new(response.status) unless response.success?

        ClientResponse.new.tap do |client_response|
          client_response.countries = JSON.parse(response.body)['country_of_origin']
          client_response.response_time = response.env[:duration]
        end
      end

      private

      def client
        Faraday.new(
          url: 'https://gender-api.com',
          headers: {'Authorization' => "Bearer #{ENV['GENDER_API_AUTHENTICATION_TOKEN']}"}
        ).tap do |connection|
          connection.request :timer
          connection.adapter Faraday.default_adapter
        end
      end
    end
  end
end
