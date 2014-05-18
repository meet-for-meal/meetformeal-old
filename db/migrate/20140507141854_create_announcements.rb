class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.belongs_to :user
      t.string     :title
      t.float      :lat
      t.float      :lng

      t.timestamps
    end
  end
end
