module Admin
	class HomeController < ApplicationController
		def index
			unless manager_signed_in?
				return redirect_to new_manager_session_path
			end
		end
	end
end