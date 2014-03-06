class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, format: {with: /\A.+@.+\..+\z/, on: :create }
  validates :first_name, presence: true

  has_many :created_events, :class_name => "Event"

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event


  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
