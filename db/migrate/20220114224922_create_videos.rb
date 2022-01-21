class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :user
      t.text :link
      t.string :video_type
      t.timestamps
    end
  end
end
