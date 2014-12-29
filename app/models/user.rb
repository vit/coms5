class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :journals, class_name: 'Journal::Journal'
  has_many :submissions, class_name: 'Journal::Submission'
  has_many :journal_appointments, class_name: 'Journal::Appointment'

  validates :first_name, :first_name, presence: true


	def full_name
#		self.email + ' ' + (self.first_name || '') + ' ' + (self.last_name || '')
		self.first_name && self.last_name ? self.first_name + ' ' + self.last_name : self.email
	end
	def is_admin?
		self.is_admin
	end

	def owned_journals
		journals
	end
	def managed_journals
		journal_appointments.where(role_name: 'chief_editor').map(&:journal)
	end
	def owned_and_managed_journals
		owned_journals | managed_journals
		#managed_journals
	end

end
