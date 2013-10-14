class ProtectedController < ApplicationController


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
