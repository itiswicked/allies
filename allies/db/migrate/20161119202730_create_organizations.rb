class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :street_address, null: false
      t.string :state, null: false
      t.string :zip, null: false 
    end
  end
end
