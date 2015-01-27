class Journal::RevisionDecision < ActiveRecord::Base
	include AASM

	Decisions = %w[revise accept reject]

#	validates :decision, :inclusion=> { :in => Decisions }
	validates_inclusion_of :decision, :in => Decisions

	belongs_to :user
	belongs_to :revision

	aasm do
		state :draft, initial: true
		state :submitted
		state :nonexistent

		event :sm_update do
			after do |data|
				self.update data
				self.save
			end
			transitions :from => :draft, :to => :draft
		end

#		event :sm_submit, guard: (-> {revision.review?}) do
		event :sm_submit do
			after do
#				self.revision.send(('sm_'+decision+'!').to_sym)
				self.revision.sm_apply_decision!
			end
			transitions :from => :draft, :to => :submitted
		end

=begin
		event :sm_cancel do
			after do
				self.revision.sm_revert_to_review!
			end
			transitions :from => :submitted, :to => :draft
		end
=end

		event :sm_destroy do
			after do
				self.destroy!
			end
#			transitions :from => [:draft, :submitted, :nonexistent], :to => :nonexistent
			transitions :to => :nonexistent
		end


	end

end
