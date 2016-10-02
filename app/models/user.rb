require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]
  before_destroy :delete_activities

  validates :name, presence: true, on: :create
  validates :position, presence: true, on: :create
  has_many :books
  has_many :books_readings, dependent: :destroy
  has_many :books_reads, dependent: :destroy
  has_many :books_wishlists, dependent: :destroy
  has_many :stories, dependent: :destroy
  before_save { self.gravitarhash = Digest::MD5.hexdigest(self.email)}

  def delete_activities
    activities = PublicActivity::Activity.where(owner_id: self.id, owner_type: "User")
    activities.delete_all
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.new(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20],
           position: "A fellow Shopifolk"
        )
        user.save!
    end
    user
  end
end
