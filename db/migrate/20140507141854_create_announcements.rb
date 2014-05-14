class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.belongs_to :user
      t.float      :longitude
      t.float      :latitude

      t.timestamps
    end
  end
end
