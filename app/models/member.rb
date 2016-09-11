class Member < ActiveRecord::Base
  validates :user, presence: true
  validates :band, presence: true

  belongs_to :user
  belongs_to :band
end
