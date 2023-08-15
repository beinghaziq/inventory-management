# frozen_string_literal: true

require 'rspec'
require_relative '../inventory'
require_relative '../item'

# rubocop:disable Metrics/BlockLength
describe Inventory do
  context 'when gold coins' do
    it 'does not allow gold coin price to exceed 80' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:gold], 10, 80)
      expect(updated_item.price).to eq(80)
    end

    it 'does not reduce sell_by time for gold coins' do
      updated_item1 = add_item_and_update_price(described_class::SPECIAL_ITEM[:gold], 10, 80)
      expect(updated_item1.sell_by).to eq(10)
    end
  end

  context 'when fine art' do
    it 'does not allow price of appreciating items to exceed 50' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:fine_art], 10, 50)
      expect(updated_item.price).to eq(50)
    end

    it 'increases price for Fine Art' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:fine_art], 10, 20)
      expect(updated_item.price).to eq(21)
    end
  end

  context 'when concert ticket' do
    it 'increases price for Concert Tickets by 1 when more than 10 days before sell_by' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:concert], 12, 20)
      expect(updated_item.price).to eq(21)
    end

    it 'increases price for Concert Tickets by 2 when between 6 and 10 days before sell_by' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:concert], 7, 20)
      expect(updated_item.price).to eq(22)
    end

    it 'increases price for Concert Tickets by 3 when less than 6 days before sell_by' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:concert], 5, 20)
      expect(updated_item.price).to eq(23)
    end

    it 'reduces price to 0 when sell_by for Concert Tickets is zero' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:concert], 0, 20)
      expect(updated_item.price).to eq(0)
    end

    it 'does not allow price of appreciating items to exceed 50' do
      updated_item = add_item_and_update_price(described_class::SPECIAL_ITEM[:concert], 10, 50)
      expect(updated_item.price).to eq(50)
    end
  end

  context 'when normal item' do
    it 'reduces price and sell_by for' do
      updated_item = add_item_and_update_price('Normal Item', 10, 20)

      expect(updated_item.sell_by).to eq(9)
      expect(updated_item.price).to eq(19)
    end

    it 'reduces price twice as fast for past sell_by' do
      updated_item = add_item_and_update_price('Normal Item', -1, 20)
      expect(updated_item.price).to eq(18)
    end

    it 'does not allow price to go negative' do
      updated_item = add_item_and_update_price('Normal Item', 10, 0)
      expect(updated_item.price).to eq(0)
    end
  end
  # rubocop:enable Metrics/BlockLength

  private

  def add_item_and_update_price(name, sell_by, price)
    item = Item.new(name, sell_by, price)
    described_class.new([item]).update_price
    item
  end
end
