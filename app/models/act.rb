class Act < ActiveRecord::Base
  belongs_to :user
  has_many :results

  validates :title, :points, presence: true
end
