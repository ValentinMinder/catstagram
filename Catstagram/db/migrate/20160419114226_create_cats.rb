class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :catname, null: false
      t.text :description
      t.string :city
      t.date :birth_time

      t.timestamps null: false
    end
  end
end
