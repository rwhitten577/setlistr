class Setlist < ActiveRecord::Base
  validates :venue, presence: true
  validates :date, presence: true
  belongs_to :band
end
