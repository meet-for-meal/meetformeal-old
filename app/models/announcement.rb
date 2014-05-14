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
end
