class Journal::Submission < ActiveRecord::Base
	include AASM

  belongs_to :user
  belongs_to :journal
  has_many :revisions

  validates :title, :abstract, presence: true



  aasm do
    state :draft, initial: true, before_enter: (-> data{
    	}), enter: (-> data{
    	}), after_enter: (-> data{
    	})
    state :review
    state :next_round
    state :revised_draft

    state :editorial
    state :editorial_next_round
    state :editorial_draft
    state :final_review

    state :published
    state :rejected


    event :sm_update_draft, :before => (-> data {
      	self.update data
	}) do
		transitions :from => :draft, :to => :draft
		transitions :from => :editorial_draft, :to => :editorial_draft
    end

    event :sm_create_new_revision, :guards => [
    		-> {
    			puts self.last_created_revision
    			self.last_created_revision == 0
    		}
#    	], :before => (-> {
#    		puts "before"
#    	], :success => (-> {
    	], :after => (-> {
    		puts "success"
	    	rn = self.last_created_revision + 1
    	  	r = self.revisions.build(revision_n: rn)
      		self.last_created_revision = rn
	      	r.save
    	  	self.save
		}) do
			transitions :from => :draft, :to => :draft
			transitions :from => :editorial_draft, :to => :editorial_draft
    	end

#    event :sleep do
#      transitions :from => [:running, :cleaning], :to => :sleeping
#    end
  end

    def get_last_created_revision
    	self.revisions.find_by_revision_n(self.last_created_revision)
    end

end
