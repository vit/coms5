class CreateJournalRevisionDecisions < ActiveRecord::Migration
  def change
    create_table :journal_revision_decisions do |t|
      t.string :decision
      t.text :comment
      t.references :revision, index: true
      t.references :user, index: true
      t.string :aasm_state

      t.timestamps null: false
    end
    add_foreign_key :journal_revision_decisions, :users
    add_foreign_key :journal_revision_decisions, :journal_revisions
  end
end
