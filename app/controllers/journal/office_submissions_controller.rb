class Journal::OfficeSubmissionsController < Journal::BaseController
	before_action -> { @section_journal_journals = true }
#	before_action -> { @section_journal_chief_editor_office = true }

#  before_action :set_journal_only, only: [:index, :new]
  before_action :authenticate_user!

#  respond_to :html, :js

	def show
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
	end


end
