class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  QNT_REGEX = /\A[0-9]+((.|,)[0-9])?((.|,)[0-9][0-9])?((.|,)[0-9][0-9][0-9])?\Z/

  def add_product(product_id, qnt)  #INSERIMENTO NEL CARRELLO CON CONTROLLO DEL PRODOTTO
    product = Product.find(product_id)
    current_item = line_items.where(:product_id => product_id).first
  
    if qnt_valid(qnt) # SE LA QUANTITA' E' VALIDA
      qnt.gsub!(",", ".")
      qnt = qnt.to_f
      if current_item  # SE PRODOTTO PRESENTE
	if (product.qnt - current_item.qnt - qnt) >= 0  # VERIFICA NEL MAGAZZINO
          current_item.qnt += qnt
        else
          return 'Quantità desiderata non disponibile in Magazzino'
        end
      else  # SE PRODOTTO NON PRESENTE
        if (product.qnt - qnt) >= 0 # VERIFICA NEL MAGAZZINO
          current_item = line_items.build(:product_id => product_id, :qnt => qnt)
        else
          return 'Quantità desiderata non disponibile in Magazzino'
        end
      end
      current_item
    else # SE LA QUANTITA' E' ERRATA
      return 'Quantità non valida'
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  private

    def qnt_valid(qnt)
      code = (qnt =~ QNT_REGEX)
      code == 0
    end

end
