class CreateInclusions < ActiveRecord::Migration[5.0]
  def change
    create_table :deck_inclusions do |t|
      t.integer :deck_id
      t.integer :card_id
      t.integer :quantity
      t.boolean :sideboard

      t.timestamps
    end
  end
end
