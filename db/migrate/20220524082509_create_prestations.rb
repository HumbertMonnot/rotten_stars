class CreatePrestations < ActiveRecord::Migration[6.1]
  def change
    create_table :prestations do |t|
      t.string :name
      t.string :category
      t.text :description
      t.integer :price
      t.string :address
      t.integer :distance

      t.timestamps
    end
  end
end
