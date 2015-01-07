class Journal::Submission < ActiveRecord::Base
	include AASM

  belongs_to :user
  belongs_to :journal
  has_many :revisions

  belongs_to :last_created_revision, class_name: 'Journal::Revision'
  belongs_to :last_submitted_revision, class_name: 'Journal::Revision'

  validates :title, :abstract, presence: true

  scope :all_submitted, -> { where.not(aasm_state: 'draft') }

  aasm do
    state :just_created, initial: true
    state :draft #, initial: true
    state :under_review
#    state :revised_draft
#    state :revised_under_review
    state :need_rework
    state :rejected
    state :accepted
    state :nonexistent

    event :sm_update, :after => (-> data {
        self.update data
        self.save
    }) do
      transitions :from => :draft, :to => :draft
#      transitions :from => :need_rework, :to => :need_rework
#		  transitions :from => :editorial_draft, :to => :editorial_draft
    end

    event :sm_init, :after => :create_new_revision do
      transitions :from => :just_created, :to => :draft
    end

    event(:sm_submit,
      :after => (-> data=nil {
        self.last_created_revision.sm_submit!
        self.last_submitted_revision = self.last_created_revision
        save!
      }) 
    ) do
      transitions :from => :draft, :to => :under_review
#      transitions :from => :review, :to => :review
    end
    event(:sm_unsubmit,
      :after => (-> {self.last_created_revision.sm_unsubmit!}) 
    ) do
      transitions :from => :under_review, :to => :draft
    end
    event(:sm_destroy, after: (-> {self.destroy!}) ) do
      transitions :from => :draft, :to => :nonexistent
    end


    event :sm_rework do
      transitions :from => :under_review, :to => :need_rework
    end
    event :sm_reject do
      transitions :from => :under_review, :to => :rejected
    end
    event :sm_accept do
      transitions :from => :under_review, :to => :accepted
    end
    event :sm_revert_to_review do
      transitions :from => [:under_review, :need_rework, :rejected, :accepted], :to => :under_review
    end


  end

private
    def create_new_revision
        self.revision_seq += 1
        r = self.revisions.build(revision_n: self.revision_seq)
        self.last_created_revision = r
        r.save
        self.save
        r
    end

#    def update_draft data
#      do_if_may :sm_update do
#        self.update data
#      end
#    end
#    def destroy_draft
#      do_if_may :sm_destroy do
#        self.destroy
#      end
#    end

#    def submit_paper
#      do_if_may :sm_submit do
#        self.last_created_revision.sm_submit!
#        self.last_submitted_revision = self.last_created_revision
#      end
#    end
#    def unsubmit_paper
#      do_if_may :sm_unsubmit do
#        self.last_created_revision.sm_unsubmit!
#      end
#    end


#    def get_last_created_revision
#      self.last_created_revision
#    end


#    def do_if_may op, *args, &block
#      if self.send( ('may_'+op.to_s+'?').to_sym )
#        block.call(*args)
#        self.send( (op.to_s+'!').to_sym ) #rescue nil
#      end
#    end


end
