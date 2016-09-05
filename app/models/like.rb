class Like < ActiveRecord::Base
  belongs_to :story
  before_destroy :pause_tracking
  after_destroy :resume_activities

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.story_id }

  def pause_tracking
    Like.public_activity_off
    return true
  end

  def resume_activities
    Like.public_activity_on
  end

end
