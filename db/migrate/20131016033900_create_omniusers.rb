class CreateOmniusers < ActiveRecord::Migration
  def up
    create_table :omniusers do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: false
    end

    add_index :omniusers, [:provider, :uid], name: "provider_uid_key", unique: true
  end

  def down
    drop_table :omniusers
  end
end
