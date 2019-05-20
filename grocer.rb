require "pry"
def consolidate_cart(cart)
  new_cart = {}
  cart.each do |big_hash|
    big_hash.each do |item, hash|
      new_hash = hash
      count = 1
      new_hash[:count] = count
      if new_cart.keys.include?(item)
        new_cart[item][:count] += 1
      else
        new_cart[item] = new_hash
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = {}
  cart.each do |item, hash|
    new_hash = hash
    coupons.each do |coupon|
      if item == coupon[:item]
        count = 0
        if new_hash[:count] >= coupon[:num]
          count += 1
          new_cart["#{item} W/COUPON"] = {
            price: coupon[:cost],
            clearance: new_hash[:clearance],
            count: count
          }
          new_hash[:count] -= coupon[:num]
        end
      end
    end
    new_cart[item] = new_hash
  end
  new_cart
end

def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearance]
      hash[:price] = hash[:price] * 0.8
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
