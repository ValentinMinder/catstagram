class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image_url, null: false
      t.text :caption
      t.integer :view_count, default: 0, null: false
      t.integer :like_count, default: 0, null: false
      t.integer :report_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
