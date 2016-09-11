class Recommendation < ActiveRecord::Base
  belongs_to :books
  before_destroy :pause_tracking
  after_destroy :resume_activities

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.book_id }

  def pause_tracking
    Story.public_activity_off
    return true
  end

  def resume_activities
    Story.public_activity_on
  end
end
