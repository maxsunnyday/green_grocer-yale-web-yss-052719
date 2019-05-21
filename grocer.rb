require "pry"
def consolidate_cart(cart)
  new_cart = {}
  cart.each do |big_hash|
    big_hash.each do |item, hash|
      new_hash = hash
      if new_cart.keys.include?(item)
        new_cart[item][:count] += 1
      else
        new_hash[:count] = 1
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
      keys = new_cart.keys
      if item == coupon[:item]
        if new_hash[:count] >= coupon[:num]
          if keys.include?("#{item} W/COUPON")
            new_cart["#{item} W/COUPON"][:count] += 1
            new_hash[:count] -= coupon[:num]
          else
            new_cart["#{item} W/COUPON"] = {
              price: coupon[:cost],
              clearance: new_hash[:clearance],
              count: 1
            }
            new_hash[:count] -= coupon[:num]
          end
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
      hash[:price] = hash[:price] * 4 / 5
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupons_cart)
  total = 0
  clearance_cart.each do |item, hash|
    total += hash[:price] * hash[:count]
  end
  if total > 100
    new_total = total * 0.9
  else
    new_total = total
  end
  new_total
end
