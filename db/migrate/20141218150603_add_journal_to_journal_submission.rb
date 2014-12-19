class AddJournalToJournalSubmission < ActiveRecord::Migration
  def change
    add_reference :journal_submissions, :journal, index: true
    add_foreign_key :journal_submissions, :journals
  end
end
