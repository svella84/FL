class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.decimal :qnt, :precision => 7, :scale => 3, :default => 1.000

      t.timestamps
    end
  end
end
