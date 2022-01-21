class CreateFavoriteGamers < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_gamers do |t|
      t.references :user
      t.references :company

      t.timestamps
    end
  end
end
