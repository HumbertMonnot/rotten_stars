class AddPunchlineToPrestation < ActiveRecord::Migration[6.1]
  def change
    add_column :prestations, :punchline, :string
  end
end
