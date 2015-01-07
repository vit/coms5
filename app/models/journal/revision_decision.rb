class Journal::RevisionDecision < ActiveRecord::Base
	include AASM

	Decisions = %w[rework accept reject]

#	validates :decision, :inclusion=> { :in => Decisions }
	validates_inclusion_of :decision, :in => Decisions

	belongs_to :user
	belongs_to :revision

	aasm do
		state :draft, initial: true
		state :submitted

		event :sm_update, :after => (-> data {
			self.update data
			self.save
		}) do
			transitions :from => :draft, :to => :draft
		end

#		event :sm_submit, guard: (-> {revision.review?}) do
		event(:sm_submit,
#			after: (-> {self.revision.send((decision+'_revision').to_sym)})
			after: (-> {self.revision.send(('sm_'+decision+'!').to_sym)})
		) do
			transitions :from => :draft, :to => :submitted
		end

		event(:sm_cancel,
#			after: (-> {self.revision.revert_to_review_revision})
			after: (-> {self.revision.sm_revert_to_review!})
		) do
			transitions :from => :submitted, :to => :draft
		end

	end

#    def submit_decision
#      do_if_may :sm_submit do
#        self.revision.send((decision+'_revision').to_sym)
#      end
#    end
#    def cancel_decision
#      do_if_may :sm_cancel do
##        self.revision.sm_revert_to_review!
#        self.revision.revert_to_review_revision
#      end
#    end


#    def do_if_may op, *args, &block
#      if self.send( ('may_'+op.to_s+'?').to_sym )
#        block.call(*args)
#        self.send( (op.to_s+'!').to_sym ) rescue nil
#      end
#    end

end
