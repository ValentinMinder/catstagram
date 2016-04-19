class CreateJoinTablePhotoHashtag < ActiveRecord::Migration
  def change
    create_join_table :photos, :hashtags do |t|
      t.index [:photo_id, :hashtag_id]
    end
  end
end
