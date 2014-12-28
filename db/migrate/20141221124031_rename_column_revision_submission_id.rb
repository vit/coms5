class RenameColumnRevisionSubmissionId < ActiveRecord::Migration
def self.up
    rename_column :journal_revisions, :journal_submissions_id, :submissions_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
