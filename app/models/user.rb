require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :books_readings, dependent: :destroy
  has_many :books_reads, dependent: :destroy
  has_many :books_wishlists, dependent: :destroy
  before_save { self.gravitarhash = Digest::MD5.hexdigest(self.email)}
end
