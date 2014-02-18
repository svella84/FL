class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  def check_sum(credit)
    if (credit-expense) >= 0
      return true
    else
      return false
    end
  end
end
