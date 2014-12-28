class Journal::Submission < ActiveRecord::Base
	include AASM

  belongs_to :user
  belongs_to :journal
  has_many :revisions

  belongs_to :last_created_revision, class_name: 'Journal::Revision'
  belongs_to :last_submitted_revision, class_name: 'Journal::Revision'

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


#    event :sm_update_draft, :before => (-> data {
    event :sm_update_draft, :before => (-> {
#      	self.update data
    }) do
		  transitions :from => :draft, :to => :draft
		  transitions :from => :editorial_draft, :to => :editorial_draft
    end

    event :sm_create_new_revision, :guards => [
    		-> {
    			puts self.revision_seq
    			self.revision_seq == 0
    		}
    	], :after => (-> {
#    		puts "success"
   #     self.revision_seq += 1
  #  	  	r = self.revisions.build(revision_n: self.revision_seq)
 #     		self.last_created_revision = r
#	      	r.save
#    	  	self.save
		}) do
			transitions :from => :draft, :to => :draft
			transitions :from => :editorial_draft, :to => :editorial_draft
    	end

#    event :sleep do
#      transitions :from => [:running, :cleaning], :to => :sleeping
#    end
  end

    def create_new_revision
        sm_create_new_revision
        self.revision_seq += 1
        r = self.revisions.build(revision_n: self.revision_seq)
        self.last_created_revision = r
        r.save
        self.save
        r
    end

    def update_draft data
        sm_update_draft
        self.update data
    end


    def get_last_created_revision
#      self.revisions.find_by_revision_n(self.last_created_revision)
      self.last_created_revision
    end

end
