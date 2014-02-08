class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.references :user, index: true
      t.string :name
      t.string :surname
      t.date :date_of_birth
      t.string :andress
      t.string :city
      t.string :country
      t.string :post_code
      t.string :phone
      t.decimal :credit, :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.attachment :image_url

      t.timestamps
    end
  end
end
