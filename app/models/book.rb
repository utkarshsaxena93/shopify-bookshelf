class Book < ActiveRecord::Base
  belongs_to :user
  before_destroy :pause_tracking
  after_destroy :resume_activities
  has_many :recommendation, dependent: :destroy

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.title }

  def pause_tracking
    Book.public_activity_off
    return true
  end

  def resume_activities
    Book.public_activity_on
  end

end
