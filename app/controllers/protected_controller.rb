class ProtectedController < ApplicationController

	before_filter :require_member_login, :get_family

	def get_family
		#@family = Family.find(session[:member][:family_id])
		@family = Family.first
	end

	def require_member_login
		unless session[:member]
			redirect_to login_path
		end
	end

	def require_admin_login
		unless session[:admin]
			redirect_to login_path
		end
	end
end
