module TodosHelper
  def todo_checkbox(todo, data={:action => 'assignment'})

if data[:action] == 'assignment'
	
	if todo.assigned?
		status_html = "checked='true'"
	else     
		status_html = ""
	end
else
	puts data[:action]
	if todo.completed?
		puts "Yes: #{todo.completed?}"	
		status_html = "checked='true'"
	else     
		status_html = ""
	end
end
	html = "
	<input  
            class='#{data[:action]}-checkbox'
            type='checkbox' 
            name='todo[id]' 
            value='#{todo.id}' 
            points='#{todo.task.points}'
            #{status_html}
            >


          <input  type='hidden' 
            name='member[id]' 
            value='#{ session[:member][:id] }'>
		"
	return html 

	end


end
