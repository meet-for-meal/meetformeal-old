class User < ActiveRecord::Base
  # include Amistad::FriendModel

  has_many :announcements, dependent: :destroy

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: [ :male, :female ]
end
