class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category, index: true
      t.string :title
      t.text :description
      t.decimal :qnt, :precision => 7, :scale => 3
      t.decimal :price, :precision => 10, :scale => 2
      t.boolean :active, :null => true, :default => true
      t.boolean :push, :null => false, :default => false
      t.attachment :image_url

      t.timestamps
    end
  end
end
