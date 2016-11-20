class CreateVolunteers < ActiveRecord::Migration[5.0]
  def change
    create_table :volunteers do |t|
      t.belongs_to :user, null: false
      t.belongs_to :organization, null: false 
    end
  end
end
