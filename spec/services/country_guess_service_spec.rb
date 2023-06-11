require 'rails_helper'
require 'gender_api/client'

RSpec.describe CountryGuessService, type: :service do
  subject(:service) { described_class.new(full_name) }

  let(:full_name) { 'Oleh Cherednichenko' }

  before do
    allow(GenderApi::Client)
      .to receive(:countries_of_origin).with(full_name).and_call_original
  end

  it 'calls GenderApi::Client' do
    VCR.use_cassette('successful_country_guess') do
      service.call

      expect(GenderApi::Client).to have_received(:countries_of_origin).with(full_name)
    end
  end

  it 'returns formated data' do
    VCR.use_cassette('successful_country_guess') do
      service.call

      expect(service.guessed_country).to be_present
      expect(service.time_processed).to be_present
    end
  end
end
