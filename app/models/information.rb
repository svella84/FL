class Information < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image_url, :styles => { :large => "980x980#", :medium => "300x196#", :thumb => "100x100#", :small => "30x30#" }, :default_url => "user.jpg"
  validates_attachment_content_type :image_url, :content_type => /\Aimage\/.*\Z/

  ONLY_LETTERS_REGEX = /\A[a-zA-Z]+\Z/
  ONLY_NUMBERS_REGEX = /\A[0-9]+\Z/
  CREDIT_REGEX = /\A[0-9]+((.|,)[0-9][0-9])?\Z/

  validates :name, :presence => true,
            :format => { :with => ONLY_LETTERS_REGEX }
  validates_length_of :name, minimum: 2, maximum: 30, :allow_blank => true
  
  validates :surname, :presence => true,
            :format => { :with => ONLY_LETTERS_REGEX }
  validates_length_of :surname, minimum: 2, maximum: 30, :allow_blank => true

  validates :city, format: { with: ONLY_LETTERS_REGEX }, :allow_blank => true

  validates :country, format: { with: ONLY_LETTERS_REGEX }, :allow_blank => true

  validates_length_of :post_code, is: 5, allow_blank: true
  validates :post_code, format: { with: ONLY_NUMBERS_REGEX }, :allow_blank => true

  validates_length_of :phone, minimum: 8, maximum: 15, :allow_blank => true
  validates :phone, format: { with: ONLY_NUMBERS_REGEX }, :allow_blank => true

  validates :credit, numericality: { greater_than_or_equal_to: 0.0 }, :allow_blank => true


  def add_credit(value) 
    decimal = true

    if value.is_a?(String)
      value.gsub!(",", ".")
      decimal = check_credit(value)
    end

    if decimal
      update(credit: credit + value.to_f)
      return true
    else
      return false
    end
  end

  private 
    
    def check_credit(value)
      code = (value =~ CREDIT_REGEX) 
      if code != 0
        errors.add(:credit, 'non valido')
        return false
      end
      return true
    end

end
