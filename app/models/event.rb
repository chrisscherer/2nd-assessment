class Event < ActiveRecord::Base
  has_many :users, through: :event_attendance
  has_many :event_attendances
  has_one :author, :class_name => "User"

end
