class CreateJournalReview < ActiveRecord::Migration
  def change
    create_table :journal_reviews do |t|
      t.string :decision
      t.text :comment
      t.references :revision, index: true
      t.references :user, index: true
      t.string :aasm_state

      t.timestamps null: false
    end
    add_foreign_key :journal_reviews, :users
    add_foreign_key :journal_reviews, :journal_revisions
  end
end
