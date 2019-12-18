class User <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates_numericality_of :zip, { only_integer: true }

  validates :email, case_sensitive: false
  validates_uniqueness_of :email

  validates_confirmation_of :password

  has_secure_password

  enum role: %w(user merchant_employee merchant_admin admin_user)
end
