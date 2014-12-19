class Journal::Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal
  has_many :revisions
end
