class Journal::OfficeController < Journal::BaseController
  before_action -> { @section_journal_journals = true }

  before_action :set_journal_only, only: [:index, :new]
  before_action :authenticate_user!

  respond_to :html, :js

private

    def set_journal_only
      @journal = Journal::Journal.find(params[:journal_id])
    end

end
