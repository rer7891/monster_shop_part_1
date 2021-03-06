class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id, quantity|
      Item.find(item_id).price * quantity
    end
  end

  def discounted_total(coupon)
    @contents.sum do |item_id, quantity|
      item = Item.find(item_id)
      if coupon && item.merchant_id == coupon.merchant_id
        (discount(item, coupon) * quantity).round(2)
      else
        ((item.price * quantity)/100.to_f).round(2)
      end
    end
  end

  def discount(item, coupon)
  return 0 if coupon == nil || item.merchant != coupon.merchant
  savings = item.price * coupon.percent
  ((item.price - savings)/100).round(2)
  end

  def add_quantity(item_id)
    @contents[item_id] += 1
  end

  def subtract_quantity(item_id)
    @contents[item_id] -= 1
  end

  def limit_reached?(item_id)
    @contents[item_id] == Item.find(item_id).inventory
  end

  def quantity_zero?(item_id)
    @contents[item_id] == 0
  end
end
