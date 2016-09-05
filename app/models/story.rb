class Story < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  before_destroy :pause_tracking
  after_destroy :resume_activities

  has_many :likes, dependent: :destroy

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.title }

  def pause_tracking
    Story.public_activity_off
    return true
  end

  def resume_activities
    Story.public_activity_on
  end
end
