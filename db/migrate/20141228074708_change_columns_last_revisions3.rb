class ChangeColumnsLastRevisions3 < ActiveRecord::Migration
  def change
    change_column :journal_submissions, :last_created_revision_id, :integer, :default => nil
    change_column :journal_submissions, :last_submitted_revision_id, :integer, :default => nil
  end
end
