class CreateJournalSubmissions < ActiveRecord::Migration
  def change
    create_table :journal_submissions do |t|
      t.string :title
      t.text :abstract
      t.references :user, index: true

      t.integer :revision_seq, default: 0
      t.integer :last_created_revision, default: 0
      t.integer :last_submitted_revision, default: 0

      t.string :aasm_state

      t.timestamps null: false
    end
    add_foreign_key :journal_submissions, :users

    create_table :journal_revisions do |t|
      t.references :journal_submissions, index: true
      t.integer :revision_n, default: 0

      t.string :aasm_state

      t.timestamps null: false
    end
    add_foreign_key :journal_revisions, :journal_sumbisions



  end
end

