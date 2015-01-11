class Journal::CeSubmissionsController < Journal::BaseController
	before_action -> { @section_journal_journals = true }
#	before_action -> { @section_journal_ce_office = true }
	before_action -> { @section_journal_chief_editor_office = true }

#  before_action :set_journal_only, only: [:index, :new]
  before_action :authenticate_user!

#  respond_to :html, :js


	def show
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
	end

	def update
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
#		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
		@decision = @revision.revision_decision

		data = params[:journal_revision_decision]
		if data
			data = data.permit(:decision, :comment).merge user: current_user
			if @decision
		        @decision.sm_update!(data)
			else
				@revision.sm_create_decision!(data)
				@decision = @revision.revision_decision
			end
		end

		case params[:op]
		when 'submit_decision'
			@decision.sm_submit!
		when 'cancel_decision'
			@decision.sm_cancel!
		end

		@decision.reload if @decision
		@revision.reload
		@submission.reload

		respond_to do |format|
			format.js
		end
	end

private

    def set_journal_only
      #@journal = Journal::Journal.find(params[:journal_id])
    end

end
