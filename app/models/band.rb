class Band < ActiveRecord::Base
  validates :name, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :setlists
  has_many :songs
end
