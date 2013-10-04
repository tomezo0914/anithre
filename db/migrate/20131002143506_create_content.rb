class CreateContent < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.string :ip, null: false
      t.integer :status, null: false, default: 0
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end
  end

  def down
    drop_table :contents
  end
end
