class Journal::Journal < ActiveRecord::Base
  belongs_to :user
  has_many :submissions
  has_many :appointments #, class_name: 'Journal::Appointment'

  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: true

	def owned_or_managed_by? user
		user and (self.user==user or !self.appointments.where(user: user, role_name: 'chief_editor').empty?)
#		!self.appointments.where(user: user, role_name: 'chief_editor').empty?
	end

	def user_roles user
		user ? self.appointments.where(user: user).map(&:role_name) : []
	end

	def chief_editors
		self.appointments.where(role_name: 'chief_editor').map(&:user)
	end

end
