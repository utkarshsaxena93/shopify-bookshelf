class Like < ActiveRecord::Base
  belongs_to :story

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.story_id }
end
