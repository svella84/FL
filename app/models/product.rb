class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :wishlists

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :image_url, :styles => { :large => "980x640#", :medium => "300x196#", :thumb => "100x100#", :small => "30x30#" }, :default_url => "user.jpg"
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

  validates :title, :category_id, :description, :qnt, :price, presence: true

  validates :title, uniqueness: { case_sensitive: false }
  validates_length_of :title, minimum: 4, maximum: 255

  validates :qnt, :price, numericality: { greater_than_or_equal_to: 0.01 }


  # NON CI SONO ELEMENTI CHE FANNO RIFERIMENTO A QUESTO PRODOTTO
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  # RICERCA PER TITLE DEL PRODOTTO
  def self.search(query)
    # where(:title, query)
    where("title like ?", "%#{query}%") 
  end

end
