# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorService, type: :service do
  subject(:service) { described_class.new(expression) }

  let(:expression) { '3-16/2' }

  it 'returns the correct response' do
    service.call

    expect(service.result).to eq(-5)
  end

  context 'when unpermitted characters' do
    let(:expression) { "system('delete .')" }

    it 'raises CalculationError' do
      expect { service.call }.to raise_error(described_class::CalculationError)
    end
  end

  context 'when syntax is wrong' do
    let(:expression) { '3*/62' }

    it 'raises CalculationError' do
      expect { service.call }.to raise_error(described_class::CalculationError)
    end
  end

  context 'when devided by zero' do
    let(:expression) { '2/0' }

    it 'raises CalculationError' do
      expect { service.call }.to raise_error(described_class::CalculationError)
    end
  end
end
