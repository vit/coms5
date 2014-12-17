class Journal::JournalsController < ApplicationController
  before_action :set_journal_journal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  around_action :admin_only, only: [:new, :edit, :create, :update, :destroy]

  respond_to :html, :js

  def index
    @journal_journals = Journal::Journal.all
    respond_with(@journal_journals)
  end

  def show
    respond_with(@journal_journal)
  end

  def new
    @journal_journal = Journal::Journal.new
      respond_with(@journal_journal)
  end

  def edit
    redirect_to action: 'index' unless current_user.is_admin?
  end

  def create
      @journal_journal = Journal::Journal.new(journal_params)
      @journal_journal.user = current_user
      #@journal_journal.save
      flash[:notice] = 'Journal was successfully created.' if @journal_journal.save
      respond_with(@journal_journal)
  end

  def update
      @journal_journal.update(journal_params)
      @journal_journal.user = current_user
      respond_with(@journal_journal)
  end

  def destroy
      @journal_journal.destroy
      respond_with(@journal_journal)
  end

  private

    def admin_only
      if current_user.is_admin?
        yield
      else
        flash[:error] = 'This operation is for admin only.'
        redirect_to action: 'index'
      end
    end

    def set_journal_journal
      @journal_journal = Journal::Journal.find(params[:id])
    end

#    def journal_journal_params
    def journal_params
      params.require(:journal_journal).permit(:title, :description, :slug, :user_id)
    end
end
