class Journal::SubmissionFilesController < Journal::BaseController

	def create
		data = params[:journal_submission_file]

		@journal_revision = Journal::Revision.find(data[:revision_id])
		@journal_submission = @journal_revision.submission
		@journal_journal = @journal_submission.journal

		file_type = data[:file_type]
		file = data[:file_data]
		if file
#			@submission_file = Journal::SubmissionFile.new(file_create_params)
#			@submission_file = Journal::SubmissionFile.new(file_create_params)
			#@submission_file = Journal::SubmissionFile.new(file_type: file_type)
			@submission_file = @journal_revision.submission_files.new(file_create_params)
			@submission_file.file_data = file
			flash[:notice] = 'File was successfully uploaded.' if @submission_file.save!
		end
		redirect_to edit_journal_submission_path(@journal_submission)
	end

	def update
		data = params[:journal_submission_file]

		@submission_file = Journal::SubmissionFile.find(params[:id])
		@journal_revision = @submission_file.revision
		@journal_submission = @journal_revision.submission
		@journal_journal = @journal_submission.journal

		file_type = data[:file_type]
		file = data[:file_data]
		if file && @submission_file
#			@submission_file.update
			@submission_file.file_data = file
			flash[:notice] = 'File was successfully uploaded.' if @submission_file.save!
		end
		redirect_to edit_journal_submission_path(@journal_submission)
	end

private

    def file_create_params
      params.require(:journal_submission_file).permit(:file_type)
    end

#    def file_update_params
#      params.require(:journal_submission_file).permit()
#    end

    def set_revision_submission_and_journal
	  @revision = Journal::Revision.find(data[:revision_id])
      @journal_submission = Journal::Submission.find_by(id: params[:id], user: current_user)
      @journal_journal = @journal_submission.journal
    end


end