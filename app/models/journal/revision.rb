class Journal::Revision < ActiveRecord::Base
	include AASM

  belongs_to :submission
  has_many :submission_files

	aasm do
		state :draft, initial: true
	end

	def get_file_by_type(file_type = 'author_file')
		submission_files.find_by_file_type file_type
	end
	def get_or_new_file_by_type(file_type = 'author_file')
		get_file_by_type(file_type) || submission_files.new(file_type: file_type)
	end

end
