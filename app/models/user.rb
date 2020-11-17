class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  before_validation :strip_whitespace
  before_save :downcase

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
  def strip_whitespace
    self.email = self.email.strip unless self.email.nil?
  end

  def downcase
    self.email = self.email.downcase unless self.email.nil?
  end

  def self.find_by_lower_email(email)
    User.find_by_email(email.downcase)
  end

end
