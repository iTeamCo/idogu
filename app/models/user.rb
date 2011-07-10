class User < ActiveRecord::Base

  has_one   :profile
  has_many  :groups
  has_many  :walls
  has_many  :attachments

  attr_accessor :password, :password_confirmation

  validates     :user_name,
                :presence     => true,
                :uniqueness   => true
  validates     :password,
                :presence     => true,
                :length       => 6..30,
                :on           => :create,
                :confirmation => true

  before_create   :downcase_username, :encrypt_password

  def downcase_username
    self.user_name.downcase!
  end

  def self.authenticate(user_name, password)
    user = find_by_user_name(user_name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
