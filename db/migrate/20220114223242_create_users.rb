class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.text :location
      t.string :email
      t.string :password
      t.text :description
      t.string :user_type

      t.timestamps
    end
  end
end
