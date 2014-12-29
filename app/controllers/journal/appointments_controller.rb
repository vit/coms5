class Journal::AppointmentsController < Journal::BaseController

#	respond_to :html, :js

	def create
		a_params = appointment_create_params
		user = User.find(a_params[:user_id])
		journal = Journal::Journal.find(a_params[:journal_id])
		role_name = a_params[:role_name]
		a = Journal::Appointment.new({journal: journal, user: user, role_name: role_name})
		if user && journal && journal.owned_or_managed_by?(current_user) && Journal::Appointment::RoleNames.include?(role_name)
			a.save rescue nil
		end
#        respond_with(a, location: profile_path(user))
		redirect_to profile_url(user)
	end

	def destroy
		@appointment = Journal::Appointment.find(params[:id])
		journal = @appointment.journal
		user = @appointment.user
		if user && journal && journal.owned_or_managed_by?(current_user)
			@appointment.destroy
		end
#		respond_with(@appointment) do |format|
#			format.html { redirect_to user }
#		end
#        respond_with(@appointment, location: profile_path(user))
		redirect_to profile_url(user)
	end

private

    def appointment_create_params
      params.require(:journal_appointment).permit(:user_id, :journal_id, :role_name)
    end

end
