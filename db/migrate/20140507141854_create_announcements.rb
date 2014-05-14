class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.belongs_to :user
      t.float      :lat
      t.float      :lng

      t.timestamps
    end
  end
end
