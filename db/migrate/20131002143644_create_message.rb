class CreateMessage < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.integer :content_id, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.string :user_name
      t.string :ip, null: false
      t.string :sid, null: false
      t.integer :status, null: false, default: 0
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  end

  def down
    drop_table :messages
  end
end
