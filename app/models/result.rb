class Result < ActiveRecord::Base
  belongs_to :act

  validates :date, presence: true

  def as_json(options = nil)
    super.merge(act.as_json.slice('title'))
  end
end
