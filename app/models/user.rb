class User < ActiveRecord::Base
  has_one :information, dependent: :destroy

  accepts_nested_attributes_for :information, update_only: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :lockable
end
