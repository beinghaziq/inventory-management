# frozen_string_literal: true

# Handles operations on all items in inventory
class Inventory
  SPECIAL_ITEM = {
    concert: 'Concert Tickets',
    fine_art: 'Fine Art',
    gold: 'Gold Coins'
  }.freeze

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_price
    items.each do |item|
      next if item.name == SPECIAL_ITEM[:gold]

      update_price_before_sell_by(item)
      item.sell_by = item.sell_by - 1
      next if item.sell_by.positive?

      update_price_after_sell_by(item)
    end
  end

  private

  def update_price_before_sell_by(item)
    if item.price < 50
      item.price += 1 if item.name == SPECIAL_ITEM[:fine_art]
      price_update_for_concert(item) if item.name == SPECIAL_ITEM[:concert]
    end

    price_update_for_normal_item(item)
  end

  def price_update_for_concert(item)
    item.price += 1
    item.price += 1 if item.sell_by < 11
    item.price += 1 if item.sell_by < 6
  end

  def update_price_after_sell_by(item)
    item.price += 1 if item.name == SPECIAL_ITEM[:fine_art] && item.price < 50
    item.price = 0 if item.name == SPECIAL_ITEM[:concert]

    price_update_for_normal_item(item)
  end

  def price_update_for_normal_item(item)
    return unless item.price.positive? && ![SPECIAL_ITEM[:concert], SPECIAL_ITEM[:fine_art]].include?(item.name)

    item.price -= 1
  end
end
