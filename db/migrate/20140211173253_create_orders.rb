class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.references :status, index: true, :default => 1
      t.string :name
      t.string :surname
      t.string :andress
      t.string :city
      t.string :country
      t.string :post_code
      t.decimal :expense, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
