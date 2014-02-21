class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  has_many :line_items, :dependent => :destroy

  def check_sum(credit)
    if (credit-expense) >= 0
      return true
    else
      return false
    end
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
