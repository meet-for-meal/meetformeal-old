class Subscription < ActiveRecord::Base
  belongs_to :announcement
  belongs_to :user
end
