class AdminPanelController < ProtectedController
  
  before_filter :require_admin_login

  def index
  	@total_todos = Todo.all.count
  	@families = Family.all
  	@members = Member.all
  end
end
