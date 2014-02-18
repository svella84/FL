class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_product(product_id, qnt)
    product = Product.find(product_id)
    current_item = line_items.where(:product_id => product_id).first
    qnt = qnt.to_i
      if current_item
	if (product.qnt - current_item.qnt - qnt) >= 0 
          current_item.qnt += qnt
        else
          return 'Quantità desiderata non disponibile in Magazzino'
        end
      else
        if (product.qnt - qnt) >= 0
          current_item = line_items.build(:product_id => product_id, :qnt => qnt)
        else
          return 'Quantità desiderata non disponibile in Magazzino'
        end
      end
      current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
