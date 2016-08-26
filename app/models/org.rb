class Org < ActiveRecord::Base
  validates :name, presence: true, length: { in: 6..50 }
  validates :description, presence: true, length: { in: 11..200 }
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
