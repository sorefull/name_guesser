# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecursiveCalculatingService, type: :service do
  it { expect(described_class.new('12+3').call.to_i).to eq(12 + 3) }
  it { expect(described_class.new('12*23-30').call.to_i).to eq(12 * 23 - 30) }
  it { expect(described_class.new('12+3/2+12').call.to_i).to eq(12 + 3 / 2 + 12) }
  it { expect(described_class.new('-1-1*3').call.to_i).to eq(-1 - 1 * 3) }
  it { expect(described_class.new('8*6/8').call.to_i).to eq(8 * 6 / 8) }
end
