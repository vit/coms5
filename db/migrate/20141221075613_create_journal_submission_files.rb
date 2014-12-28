class CreateJournalSubmissionFiles < ActiveRecord::Migration
  def change
    create_table :journal_submission_files do |t|
      t.string :file_id
      t.string :file_type
      t.references :revision, index: true

      t.timestamps null: false
    end
    add_index :journal_submission_files, [:revision_id, :file_type], name: 'index_journal_submission_files_revision_type', unique: true
    add_foreign_key :journal_submission_files, :revisions
  end
end
