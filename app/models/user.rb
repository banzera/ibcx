class User < ApplicationRecord
  devise :omniauthable,
         :database_authenticatable,
         # :confirmable,
         # :rememberable,
         # :trackable,
         # :validatable,
         omniauth_providers: %i[facebook google_oauth2 developer]

  SYSTEM_USER_ID = 0

  has_many :accounts

  def to_s
    "#{first_name} #{last_name}"
  end

  def self.system_user
    find_or_create_by(id: SYSTEM_USER_ID) do |user|
      user.first_name      = 'System'
      user.last_name       = 'User'
      user.email           = 'system_user@company.com'
      user.password        = ENV.fetch('INITIAL_ADMIN_PASSWORD','')
      user.confirmed_at    = Time.current
      user.created_by_id   = 0
      user.is_admin        = true
    end
  end

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email) do |user|

      user.password   = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name  = auth.info.last_name
      # user.image      = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # binding.pry

      # user.skip_confirmation!

    end
  end

  def account!
    a = self.accounts.find_or_initialize_by(provider: :mtl)
    a.username = 'bryan.banz'
    a.password = "a&WMDH@6eOeB27o"
    a
  end
end
