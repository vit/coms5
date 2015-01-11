class CreateReviewerInvite < ActiveRecord::Migration
  def change
    create_table :journal_reviewer_invites do |t|
      t.references :submission, index: true
      t.references :user, index: true
      t.string :aasm_state

      t.timestamps null: false
    end
    add_foreign_key :journal_reviewer_invites, :users
    add_foreign_key :journal_reviewer_invites, :journal_submissions
  end
end
