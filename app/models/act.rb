class Act < ActiveRecord::Base
  belongs_to :user

  validates :title, :points, presence: true
end
