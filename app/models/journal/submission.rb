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
    state :draft
    state :revised_draft
    state :under_review
    state :need_rework
    state :rejected
    state :accepted
    state :nonexistent

    event :sm_init do
      after do
        create_new_revision
      end
      transitions :from => :just_created, :to => :draft
    end

#    event :sm_update, :after_commit => (-> {JournalMailer.author_submission_update(self)}) do
    event :sm_update do
      after do |data|
        self.update data
        self.save
#        logger.debug "in model author_submission_update begin"
#        logger.debug "in model author_submission_update begin"
#        puts "======= in model before"
#        throw "QQQQQQQQQQQQQQQ"
        JournalMailer.author_submission_update(self).deliver_now
#        puts "======= in model after"
#        logger.debug "in model author_submission_update end"
      end
      transitions :from => :draft, :to => :draft
      transitions :from => :revised_draft, :to => :revised_draft
#      after_commit do
#        JournalMailer.author_submission_update(self)
#      end
    end

    event :sm_submit do
#      after do |data|
      after do
        self.last_created_revision.sm_submit!
        self.last_submitted_revision = self.last_created_revision
        save!
        JournalMailer.author_submission_submit(self).deliver_now
        JournalMailer.ce_submission_submit(self).deliver_now
      end
      transitions :from => :draft, :to => :under_review
      transitions :from => :revised_draft, :to => :under_review
    end

    event :sm_rework do
      after do
        create_new_revision
      end
      transitions :from => :need_rework, :to => :revised_draft
    end

=begin
    event :sm_unsubmit do
      after do
        self.last_created_revision.sm_unsubmit!
      end
      transitions :from => :under_review, :to => :draft
    end
=end

    event :sm_destroy do
      after do
        last_created_revision.sm_destroy! if last_created_revision
        self.destroy!
      end
      error do |e|
        puts "AASM: state: #{aasm.current_state} event: #{aasm.current_event} error: #{e.inspect}"
      end
      transitions :from => :just_created, :to => :nonexistent
      transitions :from => :draft, :to => :nonexistent
      transitions :from => :nonexistent, :to => :nonexistent
    end

    event :sm_apply_decision do
      after do
        JournalMailer.author_submission_apply_decision(self).deliver_now
      end
      transitions :from => :under_review, :to => :rejected, :if => (-> {last_submitted_revision.rejected?})
      transitions :from => :under_review, :to => :accepted, :if => (-> {last_submitted_revision.accepted?})
      transitions :from => :under_review, :to => :need_rework, :if => (-> {last_submitted_revision.need_rework?})
    end


=begin
    event :sm_rework do
      transitions :from => :under_review, :to => :need_rework
    end
    event :sm_reject do
      transitions :from => :under_review, :to => :rejected
    end
    event :sm_accept do
      transitions :from => :under_review, :to => :accepted
    end
=end

#    event :sm_revert_to_review do
#      transitions :from => [:under_review, :need_rework, :rejected, :accepted], :to => :under_review
#    end


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

end
