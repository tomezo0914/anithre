class CreateMessage < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.integer :content_id, null: false
      t.text :body, null: false
      t.string :user_hash, null: false
      t.string :user_name
      t.string :ip_address, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
