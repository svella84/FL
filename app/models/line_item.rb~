class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  validates :qnt, :presence => true,
            :numericality => { greater_than_or_equal_to: 0.01 }

  def total_price
    product.price * qnt
  end
end
