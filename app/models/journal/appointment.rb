class Journal::Appointment < ActiveRecord::Base

  RoleNames = %w[reviewer chief_editor]

  belongs_to :user
  belongs_to :journal

  validates :role_name, presence: true

end
