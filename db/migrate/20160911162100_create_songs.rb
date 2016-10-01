class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title, null: false
      t.belongs_to :band

      t.timestamps null: false
    end
  end
end
