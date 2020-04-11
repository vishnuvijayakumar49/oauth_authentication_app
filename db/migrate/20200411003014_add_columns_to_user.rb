class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table(:users) do |t|
      t.string :name, :first_name, :last_name
      t.column :images, :json
      t.column :date_of_birth, :datetime
      t.column :active, :boolean
    end
  end
end
