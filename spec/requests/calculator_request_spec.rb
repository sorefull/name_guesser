require 'rails_helper'

RSpec.describe 'Calculator', type: :request do
  it 'renders the result' do
    get '/calculator', params: { expression: '2*2' }

    expect(response.body).to include('result')
    expect(response.body).to include('expression')
    expect(response.body).to include('4')
  end

  context 'when CalculationError was raised' do
    it 'renders error' do
      get '/calculator', params: { expression: '2/0' }

      expect(response.body).to include('error')
    end
  end
end
