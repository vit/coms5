class Journal::Revision < ActiveRecord::Base
	include AASM

  belongs_to :submission
  has_many :submission_files
  has_one :revision_decision

	aasm do
		state :draft, initial: true
		state :round_draft
		state :review
		state :rework
		state :rejected
		state :accepted

		event :sm_submit do
			transitions :from => :draft, :to => :review
			transitions :from => :round_draft, :to => :round_review
		end
		event :sm_unsubmit do
			transitions :from => :review, :to => :draft
			transitions :from => :round_review, :to => :round_draft
		end

		event(:sm_rework,
			after: (-> {
				submission.sm_rework!
				puts "!!!!! revision/sm_rework"
			})
		) do
			transitions :from => :review, :to => :rework
			transitions :from => :round_review, :to => :rework
		end
#		event :sm_reject do
		event(:sm_reject,
			after: (-> {
				submission.sm_reject!
			})
		) do
			transitions :from => :review, :to => :rejected
			transitions :from => :round_review, :to => :rejected
		end
#		event :sm_accept do
		event(:sm_accept,
			after: (-> {
				submission.sm_accept!
			})
		) do
			transitions :from => :review, :to => :accepted
			transitions :from => :round_review, :to => :accepted
		end
#		event :sm_revert_to_review do
		event(:sm_revert_to_review,
			after: (-> {
				submission.sm_revert_to_review!
			})
		) do
			transitions :from => [:review, :rework, :rejected, :accepted], :to => :review
		end


	end

=begin
	def rework_revision
      do_if_may :sm_rework do
#      	submission.rework_submission
      	submission.sm_rework!
      end
	end
	def reject_revision
      do_if_may :sm_reject do
#      	submission.reject_submission
      	submission.sm_reject!
      end
	end
	def accept_revision
      do_if_may :sm_accept do
#      	submission.accept_submission
      	submission.sm_accept!
      end
	end
=end

#	def revert_to_review_revision
#      do_if_may :sm_revert_to_review do
#      	submission.sm_revert_to_review!
#      end
#	end


	def get_file_by_type(file_type = 'author_file')
		submission_files.find_by_file_type file_type
	end
	def get_or_new_file_by_type(file_type = 'author_file')
		get_file_by_type(file_type) || submission_files.new(file_type: file_type)
	end


#    def do_if_may op, *args, &block
#      if self.send( ('may_'+op.to_s+'?').to_sym )
#        block.call(*args)
#        self.send( (op.to_s+'!').to_sym ) rescue nil
#      end
#    end


end
