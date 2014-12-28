#class Journal::SubmissionsController < ApplicationController
class Journal::SubmissionsController < Journal::BaseController

  before_action -> { @section_journal_journals = true }
  before_action -> { @section_journal_submissions = true }


  before_action :set_submission_and_journal, only: [:show, :edit, :update, :destroy]
#  before_action :set_journal_only, only: [:index, :new, :create]
  before_action :set_journal_only, only: [:index, :new]

  before_action :authenticate_user! #, except: [:index, :show]

  #around_action :admin_only, only: [:new, :edit, :create, :update, :destroy]

  respond_to :html, :js

  def index
#    Journal::Submission.destroy_all
    @journal_submissions = current_user.submissions.where(journal: @journal_journal)
#    @journal_submissions = Journal::Submission.all
    respond_with(@journal_submissions)
  end

  def show
    respond_with(@journal_submission)
  end

  def new
    @journal_submission = @journal_journal.submissions.new
    respond_with(@journal_submission)
  end

  def edit
    @journal_revision = @journal_submission.get_last_created_revision
    @file_records = @journal_revision ? %w[:author_file :author_expert_file].map do |type|
      @journal_revision.get_or_new_file_by_type type
    end : []

    puts @file_records.inspect

    #redirect_to action: 'index' unless current_user.is_admin?
  end

  def create
      data = submission_create_params.merge user: current_user
      journal_id = data.delete :journal_id
      @journal_journal = Journal::Journal.find journal_id
      @journal_submission = @journal_journal.submissions.new(data)
#      flash[:notice] = 'Submission was successfully created.' if @journal_submission.save

      if @journal_submission.save
        flash[:notice] = 'Submission was successfully created.'
        respond_with(@journal_submission, location: edit_journal_submission_path(@journal_submission))
        @journal_submission.sm_create_new_revision
#        @journal_submission.revisions.create
#        js = Journal::Revision.new(submission: @journal_submission)
#        js.save
      else
        respond_with(@journal_submission)
      end

#    respond_with(@journal_submission)
#    respond_with(@journal_submission, location: edit_journal_submission_path(@journal_submission), action: :new )
#    respond_with(@journal_submission, action: :new )
#    respond_with(@journal_submission, location: edit_journal_submission_path(@journal_submission))
#    respond_with(@journal_submission, location: edit_journal_submission_path)
  end

  def update
#      @journal_submission.update(submission_update_params)
#      @journal_submission.update_draft(:draft, submission_update_params)
      #unless

    @journal_revision = @journal_submission.get_last_created_revision

      @journal_submission.sm_update_draft(submission_update_params)
        @file_records = @journal_revision ? %w[:author_file :author_expert_file].map do |type|
          @journal_revision.get_or_new_file_by_type type
        end : []
        puts @file_records.inspect
      #end

      #@file_records = []

    respond_with(@journal_submission)
  end

  def destroy
    @journal_submission.destroy
    respond_with(@journal_submission) do |format|
      format.html { redirect_to journal_submissions_path(journal_id: @journal_journal.id) }
    end
  end

  private

    def set_submission_and_journal
#      @journal_submission = Journal::Submission.find(params[:id])
      @journal_submission = Journal::Submission.find_by(id: params[:id], user: current_user)
      @journal_journal = @journal_submission.journal
    end
    def set_journal_only
      @journal_journal = Journal::Journal.find(params[:journal_id])
    end

    def submission_create_params
      params.require(:journal_submission).permit(:title, :abstract, :journal_id)
    end
    def submission_update_params
      params.require(:journal_submission).permit(:title, :abstract)
    end
end
