class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :avatar_url
      t.text :biography
      t.datetime :banned_until

      t.timestamps null: false
    end
  end
end
