class RenameColumnsLastRevisions < ActiveRecord::Migration
  def self.up
    rename_column :journal_submissions, :last_created_revision, :last_created_revision_id
    rename_column :journal_submissions, :last_submitted_revision, :last_created_submitted_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
