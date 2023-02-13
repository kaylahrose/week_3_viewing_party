class User < ApplicationRecord
  include BCrypt
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_presence_of :password_digest
  has_secure_password

#   def password
#     @password ||= Password.new(password_digest)
#   end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
