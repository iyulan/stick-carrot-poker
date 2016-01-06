class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email_format: { message: 'has invalid format' }
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
end
