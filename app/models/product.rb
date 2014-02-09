class Product < ActiveRecord::Base
  belongs_to :category

  has_attached_file :image_url, :styles => { :large => "980x980>", :medium => "300x300>", :thumb => "100x100>", :small => "30x30>" }, :default_url => "user.jpg"
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

end
