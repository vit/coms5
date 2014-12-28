class RenameColumnSubmittedFilesFileId < ActiveRecord::Migration
	def self.up
    rename_column :journal_submission_files, :file_id, :file_data
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
