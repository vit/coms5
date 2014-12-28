class ChangeColumnsLastRevisions < ActiveRecord::Migration
  def self.up
    rename_column :journal_submissions, :last_created_submitted_id, :last_submitted_revision_id
  end

  def self.down
  end
end
