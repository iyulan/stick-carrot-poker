class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :acts
  has_many :results, through: :acts

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    email_format: { message: I18n.t('activerecord.errors.models.user.attributes.email.email_format') }
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
end
