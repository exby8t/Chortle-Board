module TodosHelper
  def todo_checkbox(todo, data={:action => 'assignment', :owned => false})

  	disabled_html = ""
	status_html = ""

	if data[:action] == 'assignment'
	
		if todo.assigned?		
			status_html = "checked='true'"
		end

	else
		if todo.completed?	
			status_html = "checked='true'"
		end
	end

	unless data[:owned] || todo.assigned? == false
		disabled_html = "disabled='true'"
		disabled_class = ""
	else
		disabled_html = ""
		disabled_class = "include"
	end     

	html = "
	<!-- 
		#{data[:action]}:: owned: #{data[:owned]} assigned: #{todo.assigned?}
	-->
	<input  
            class='#{data[:action]}-checkbox fat-checkbox #{disabled_class}'
            type='checkbox' 
            name='todo[id]' 
            value='#{todo.id}' 
            points='#{todo.task.points}'
            #{status_html}
            #{disabled_html}
            >


          <input  type='hidden' 
            name='member[id]' 
            value='#{ session[:member][:id] }'>
		"
	return html 

	end


end
