class Journal::ReviewerOfficeController < Journal::OfficeController
	before_action -> { @section_journal_reviewer_office = true }

	def index
	end
end
