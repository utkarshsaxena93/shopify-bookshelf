class Story < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.title }
end
