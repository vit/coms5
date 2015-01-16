#class Journal::CeSubmissionsController < Journal::BaseController
class Journal::CeSubmissionsController < Journal::OfficeSubmissionsController
#	before_action -> { @section_journal_journals = true }
	before_action -> { @section_journal_chief_editor_office = true }

#  before_action :set_journal_only, only: [:index, :new]
#  before_action :authenticate_user!

#  respond_to :html, :js

=begin
	def show
		@submission = Journal::Submission.find(params[:id])
		@journal = @submission.journal
		@revision = @submission.last_submitted_revision
		@decision = @revision.revision_decision || @revision.build_revision_decision({user: current_user})
	end
=end

=begin
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
		when 'add_reviewer_invites'
			r_ids = params[:reviewer_invites]
			r_ids.each do |r_id|
				puts r_id
				u = User.find(r_id)
				#@submission.reviewer_invites.find(user: u)
				inv = @submission.reviewer_invites.build(user: u)
				inv.save! rescue nil
			end if r_ids and r_ids.is_a?(Array)
		when 'activate_reviewer_invite'
			r_id = params[:reviewer_id]
			u = User.find(r_id)
			inv = @submission.reviewer_invites.find_by(user: u)
			inv.sm_activate! if inv.may_sm_activate?
		when 'drop_reviewer_invite'
			r_id = params[:reviewer_id]
			u = User.find(r_id)
			inv = @submission.reviewer_invites.find_by(user: u)
			inv.sm_destroy! if inv.may_sm_destroy?
		end

		@decision.reload if @decision
		@revision.reload
		@submission.reload

		respond_to do |format|
			format.js
		end
	end
=end

private

    def set_journal_only
      #@journal = Journal::Journal.find(params[:journal_id])
    end

end
