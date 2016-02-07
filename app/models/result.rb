class Result < ActiveRecord::Base
  belongs_to :act

  validates :date, :act_id, presence: true

  scope :for, ->(date) { where(date: date) }

  def as_json(options = nil)
    super.merge(act.as_json.slice('title', 'points')) if act
  end
end
