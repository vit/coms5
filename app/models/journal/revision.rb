class Journal::Revision < ActiveRecord::Base
  belongs_to :submission
end
