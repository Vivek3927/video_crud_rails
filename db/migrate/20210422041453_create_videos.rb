class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :yt_url
      t.text :description

      t.timestamps
    end
  end
end
