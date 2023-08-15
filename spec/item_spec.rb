# frozen_string_literal: true

require 'rspec'
require_relative '../item'

describe Item do
  describe 'to_s' do
    context 'when gold coins' do
      subject(:item) { described_class.new(Inventory::SPECIAL_ITEM[:gold], 12, 33) }

      it 'returns the attributes concatenated as string' do
        expect(item.to_s).to eq('Gold Coins, 12, 33')
      end
    end
  end
end
