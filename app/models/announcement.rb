class Announcement < ActiveRecord::Base
  acts_as_mappable  default_units: :kms
                    ## Default values
                    # default_formula: :sphere,
                    # distance_field_name: :distance,
                    # lat_column_name: :lat,
                    # lng_column_name: :lng

  belongs_to :user

  validates :lat, presence: true
  validates :lng, presence: true

  def self.near(from_user_id, lat, lng, distance = 50)
    self.within(distance, origin: [lat, lng])
        .where.not(user_id: from_user_id)
        .to_json({
          :include => [{ user: { only: [:name] } }],
          :only    => [:id, :lat, :lng]
        })
  end
end
