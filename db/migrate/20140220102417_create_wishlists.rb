class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
