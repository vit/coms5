class Journal::ChiefEditorOfficeController < Journal::OfficeController
	before_action -> { @section_journal_chief_editor_office = true }

	def index
		#@journal_submissions = @journal.submissions
		@journal_submissions = @journal.submissions.all_submitted
		respond_with(@journal_submissions)
	end
end
