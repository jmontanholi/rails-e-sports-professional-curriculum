class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
        t.references :user
        t.text :link
        t.string :photo_type
      t.timestamps
    end
  end
end
