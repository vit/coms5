class Journal::ReviewerOfficeController < Journal::OfficeController
	before_action -> { @section_journal_reviewer_office = true }

	def index
		@journal_submissions = @journal.user_reviewer_invites(current_user)
		respond_with(@journal_submissions)
	end
end
