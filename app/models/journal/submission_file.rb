class Journal::SubmissionFile < ActiveRecord::Base
  belongs_to :revision

#  mount_uploader :file, Journal::SubmissionUploader
#  mount_uploader :file, JournalSubmissionUploader
  mount_uploader :file_data, SubmissionUploader



end
