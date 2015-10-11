class Auth < ActiveRecord::Base

  before_destroy{ DeleteSonAuth(:id) }



  private
  def DeleteSonAuth(column)
    #删除权限之前 删除子权限
    Auth.where("auth_pid=#{self[column]}").each do |a|
      a.destroy
    end
  end
end
