class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :user_id
      t.string :integer
      t.string :longitude
      t.string :float
      t.string :latitude
      t.string :float

      t.timestamps
    end
  end
end
