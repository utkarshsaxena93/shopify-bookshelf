class BooksReading < ActiveRecord::Base
  belongs_to :user

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          title: Proc.new { |controller, model| model.title }
end
