class AddUserToPrestations < ActiveRecord::Migration[6.1]
  def change
    add_reference :prestations, :user, null: false, foreign_key: true
  end
end
