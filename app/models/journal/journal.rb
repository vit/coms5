class Journal::Journal < ActiveRecord::Base
  belongs_to :user
  has_many :submissions
  has_many :appointments #, class_name: 'Journal::Appointment'

  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: true

#  def create_submission data
#  end

	def owned_or_managed_by? user
		user and (self.user==user or !self.appointments.where(user: user, role_name: 'chief_editor').empty?)
#		!self.appointments.where(user: user, role_name: 'chief_editor').empty?
	end

end
