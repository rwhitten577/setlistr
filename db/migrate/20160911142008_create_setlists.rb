class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|
      t.belongs_to :band
      t.string :venue, null: false
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end
