require 'rails_helper'
require 'gender_api/client'

RSpec.describe 'Country guess', type: :request do
  before do
    allow(GenderApi::Client).to receive(:authentication_token).and_return('token')
  end

  context 'with successful request' do
    it 'renders the result' do
      VCR.use_cassette('successful_country_guess') do
        get '/country_guess', params: { name: 'Oleh Cherednichenko' }

        expect(response.body).to include('Oleh Cherednichenko')
        expect(response.body).to include('time_processed')
        expect(response.body).to include('guessed_country')
      end
    end
  end

  context 'when passing invalid characters' do
    it 'filters the name from non characters' do
      VCR.use_cassette('successful_country_guess_asdf') do
        get '/country_guess', params: { name: 'Oleh Cherednichenko&q=asdf' }

        expect(response.body).to include('Oleh Cherednichenkoqasdf')
      end
    end
  end

  context 'with unsuccessful request' do
    before do
      allow(GenderApi::Client).to receive(:authentication_token).and_return('wrong_token')
    end

    it 'raises exeption with respective code' do
      VCR.use_cassette('unsuccessful_country_guess') do
        expect {
          get '/country_guess', params: { name: 'Oleh Cherednichenko' }
        }.to raise_error(GenderApi::Client::GenderApiError)
      end
    end
  end
end
