class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  has_many :line_items, :dependent => :destroy

  ONLY_LETTERS_REGEX = /\A[a-zA-Z]+\Z/
  ONLY_NUMBERS_REGEX = /\A[0-9]+\Z/
  CREDIT_REGEX = /\A[0-9]+((.|,)[0-9][0-9])?\Z/

  validates :name, :presence => true,
            :format => { :with => ONLY_LETTERS_REGEX }
  validates_length_of :name, minimum: 2, maximum: 30
  
  validates :surname, :presence => true,
            :format => { :with => ONLY_LETTERS_REGEX }
  validates_length_of :surname, minimum: 2, maximum: 30

  validates :andress, :presence => true

  validates :city, :presence => true,
            :format => { with: ONLY_LETTERS_REGEX }

  validates :country, :presence => true,
            :format => { with: ONLY_LETTERS_REGEX }
  validates_length_of :country, is: 2

  validates :post_code, :presence => true,
            :format => { with: ONLY_NUMBERS_REGEX }
  validates_length_of :post_code, is: 5

  def check_sum(credit)
    if (credit-expense) >= 0
      return true
    else
      return false
    end
  end

  def add_line_items_from_cart(cart) #RIMOZIONE DELL'ID DEL CARRELLO 
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
