class User < ActiveRecord::Base
  include ActsAsFriendable

  has_many :subscriptions
  has_many :subscribed_announcements, through: :subscriptions, source: :announcement
  has_many :created_announcements, class_name: 'Announcement', foreign_key: 'user_id'

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: [ :male, :female ]
  acts_as_taggable_on :foods, :hobbies

  def subscribe(announcement)
    subscribed_announcements << announcement
  end

  def subscribed_to?(announcement)
    subscribed_announcements.include? announcement
  end

  def request_friendship(user)
    User::Friendship.create user_id: self.id, friend_id: user.id
  end

  def is_friend_with?(user)
    friends.include? user
  end

  def self.anwser_friend_request(friendship_id, accept)
    friendship = User::Friendship.find(friendship_id)
    if accept
      friendship.approved = accept
      friendship.save
    else
      friendship.destroy
    end
  end
end
