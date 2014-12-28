class RenameColumnRevisionSubmissionId2 < ActiveRecord::Migration
	def self.up
    rename_column :journal_revisions, :submissions_id, :submission_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
