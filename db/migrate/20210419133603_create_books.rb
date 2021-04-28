class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.integer :price
      t.string :isbn

      t.timestamps
    end
  end
end
