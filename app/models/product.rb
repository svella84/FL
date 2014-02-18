class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :image_url, :styles => { :large => "980x980>", :medium => "300x300>", :thumb => "100x100>", :small => "30x30>" }, :default_url => "user.jpg"
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

  # non ci sono elementi che fanno riferimento a questo prodotto
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present' )
      return false
    end
  end

end
