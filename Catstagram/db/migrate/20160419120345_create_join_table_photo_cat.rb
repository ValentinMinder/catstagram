class CreateJoinTablePhotoCat < ActiveRecord::Migration
  def change
    create_join_table :photos, :cats do |t|
      t.index [:photo_id, :cat_id]
    end
  end
end
