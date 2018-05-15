class User < ApplicationRecord

  validates :session_token, :password_digest, :username, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

  attr_reader :password

  def password=(input)
    @password = input
    self.password_digest = BCrypt::Password.create(input)
  end

  def find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def is_password?(input)
    BCrypt::Password.new(self.password_digest).is_password?(input)
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

end
