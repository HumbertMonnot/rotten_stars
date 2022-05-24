class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :prestation, null: false, foreign_key: true
      t.timestamp :start_date
      t.timestamp :end_date
      t.integer :price
      t.integer :total
      t.string :state

      t.timestamps
    end
  end
end
