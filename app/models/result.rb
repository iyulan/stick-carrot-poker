class Result < ActiveRecord::Base
  belongs_to :act

  validates :date, :act_id, presence: true

  def as_json(options = nil)
    super.merge(act.as_json.slice('title')) if act
  end
end
