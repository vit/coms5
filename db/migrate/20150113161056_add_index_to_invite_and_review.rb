class AddIndexToInviteAndReview < ActiveRecord::Migration
  def change
  	  add_index "journal_reviews", ["revision_id", "user_id"], name: "index_journal_reviews_revision_user", unique: true
  	  add_index "journal_reviewer_invites", ["submission_id", "user_id"], name: "index_journal_reviewer_invites_submission_user", unique: true
  end
end
