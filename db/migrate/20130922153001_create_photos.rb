class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer     :user_id
      t.integer     :album_id
      t.string      :image
      t.string      :name
      t.text        :description
      t.string      :category
      t.string      :privacy
      t.integer     :size
      t.integer     :width
      t.integer     :height
      t.text        :tag_cache
      t.string      :camera           #相机型号
      t.integer     :focal_length     #焦距
      t.string      :exposure_time    #曝光时间
      t.float       :aperture         #光圈
      t.integer     :iso              #ISO 感光灵敏度
      t.string      :license          #版权
      t.boolean     :is_adult_content #成人内容
      t.decimal     :latitude,  :precision => 15, :scale => 6
      t.decimal     :longitude, :precision => 15, :scale => 6
      t.datetime    :taken_at         #拍摄时间
      t.string      :color_space

      t.integer     :editor_id
      t.integer     :view_count
      t.integer     :like_count
      t.integer     :favorite_count

      t.timestamps
    end
    add_index :photos, :user_id
    add_index :photos, :album_id
    add_index :photos, :name
    add_index :photos, :category
    add_index :photos, :editor_id
  end
end