class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submissions, class_name: 'Journal::Submission'

  validates :first_name, :first_name, presence: true


	def full_name
#		self.email + ' ' + (self.first_name || '') + ' ' + (self.last_name || '')
		self.first_name && self.last_name ? self.first_name + ' ' + self.last_name : self.email
	end
	def is_admin?
		self.is_admin
	end

end
