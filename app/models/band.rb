class Band < ActiveRecord::Base
  validates :name, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
