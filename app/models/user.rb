require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  before_save { self.gravitarhash = Digest::MD5.hexdigest(self.email)}
end
