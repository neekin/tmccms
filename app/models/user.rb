class User < ActiveRecord::Base
  has_secure_password
  validates :name ,presence: true
  validates :name , uniqueness: { case_sensitive: false}
  #mount_uploader :avatar, AvatarUploader
  #添加用户验证
  before_create { generate_token(:auth_token) }

  private
  # auth_token方法
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column =>self[column])
  end
end
