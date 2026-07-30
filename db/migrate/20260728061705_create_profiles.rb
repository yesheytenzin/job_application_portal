class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
