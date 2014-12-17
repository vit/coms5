class User < ActiveRecord::Base
def full_name
	self.email
end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         def is_admin?
         	self.is_admin
#         	false
         end

end
