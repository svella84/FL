class Product < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :wishlists

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :image_url, :styles => { :large => "980x640#", :medium => "300x196#", :thumb => "100x100#", :small => "30x30#" }, :default_url => "user.jpg"
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

  # It returns the articles whose titles contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end

end
