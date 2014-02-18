class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :product_id
      t.integer :qnt, :default => 1

      t.timestamps
    end
  end
end
