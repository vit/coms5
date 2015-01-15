#class Journal::RSubmissionsController < Journal::BaseController
class Journal::RSubmissionsController < Journal::OfficeSubmissionsController
#	before_action -> { @section_journal_journals = true }
	before_action -> { @section_journal_reviewer_office = true }

#  before_action :authenticate_user!

#  respond_to :html, :js

=begin
	def show
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
#		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
	end
=end

end