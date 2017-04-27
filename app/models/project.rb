# Main Project Class
class Project < ActiveRecord::Base
  validates :name, presence: true
end
