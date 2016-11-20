class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :event_id, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.datetime :created_at, null: false
    end
  end
end
