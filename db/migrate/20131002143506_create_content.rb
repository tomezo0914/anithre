class CreateContent < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.string :title, null: false
      t.string :subtitle
      t.integer :episode
      t.text :description
      t.integer :user_id, null: false
      t.string :ip_address, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end

  def down
    drop_table :contents
  end
end
