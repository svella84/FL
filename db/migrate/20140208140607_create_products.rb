class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category, index: true
      t.string :title
      t.string :description
      t.integer :qnt
      t.decimal :price, :precision => 10, :scale => 2, :default => 0.0, :null => false
      t.attachment :image_url

      t.timestamps
    end
  end
end
