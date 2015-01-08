class JournalMailer < ApplicationMailer
# 	default from: 'robot@comsep.ru'
 
	# sm_update
	def author_submission_update(submission)
		user = submission.user
		to_author user.email, "Dear #{submission.user.full_name}, your paper text was updated successfully"
	end

	# sm_submit
	def author_submission_submit(submission)
		user = submission.user
		to_author user.email, "Dear #{user.full_name}, your paper was submitted successfully"
	end
	def ce_submission_submit(submission)
		submission.journal.chief_editors.each do |user|
			to_ce user.email, "Dear #{user.full_name}, the paper (#{submission.id}:#{submission.title}) was submitted by #{submission.user.full_name}, revision \##{submission.last_submitted_revision.revision_n}"
		end
	end

	# sm_apply_decision
	def author_submission_apply_decision(submission)
		user = submission.user
		revision = submission.last_submitted_revision
		decision = revision.revision_decision
		to_author user.email, "Dear #{user.full_name}, chief editor decision for your paper has been submitted.\n\nThe decision is as follow:\n\nDecision: #{decision.decision}\nComment: #{decision.comment}\n\n"
	end

	# sm_destroy


private
	def to_author email, text
		mail(to: email, subject: 'Author paper notification') do |format|
			format.text { render text: text }
		end
	end
	def to_ce email, text
		mail(to: email, subject: 'Chief editor paper notification') do |format|
			format.text { render text: text }
		end
	end

end