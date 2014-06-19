class Announcement < ActiveRecord::Base
  acts_as_mappable  default_units: :kms
                    ## Default values
                    # default_formula: :sphere,
                    # distance_field_name: :distance,
                    # lat_column_name: :lat,
                    # lng_column_name: :lng

  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
  validates :description, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true
  validates :lat, presence: true
  validates :lng, presence: true

  def self.near(from_user_id, lat, lng, distance = 50)
    self.within(distance, origin: [lat, lng])
        .where.not(user_id: from_user_id)
  end
end
