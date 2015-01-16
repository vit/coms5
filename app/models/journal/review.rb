class Journal::Review < ActiveRecord::Base
	include AASM

	Decisions = %w[rework accept reject]

#	validates :decision, :inclusion=> { :in => Decisions }
	validates_inclusion_of :decision, :in => Decisions

	belongs_to :user
	belongs_to :revision

	aasm do
		state :draft, initial: true
		state :cancelled
		state :submitted
		state :nonexistent

		event :sm_update do
			after do |data|
				self.update data
				self.save
			end
			transitions :from => :draft, :to => :draft
		end

		event :sm_submit do
			after do
			end
			transitions :from => :draft, :to => :submitted
		end

		event :sm_cancel do
			after do
			end
			transitions :from => :draft, :to => :cancelled
		end

		event :sm_destroy do
			after do
				self.destroy!
			end
			transitions :to => :nonexistent
		end

	end

end
