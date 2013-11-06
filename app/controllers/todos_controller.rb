class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json

  def assign
    @todo = Todo.find(params[:id])
    @todo.member_id = params[:member_id]
    puts @todo
    puts "~~~~~~~~~~ save!"
    @todo.save
    render json: @todo
  end

  def unassign
    @todo = Todo.find(params[:id])
    @todo.member_id = nil
    @todo.save

    puts "unsassigned user"

    render json: @todo
      
  end


def complete
    @todo = Todo.find_by_id_and_member_id(params[:id], params[:member_id])
    puts @todo
    @todo.is_completed = true
    @todo.save

    render json: @todo
end

def incomplete
    @todo = Todo.find_by_id_and_member_id(params[:id], params[:member_id])
    @todo.is_completed = nil
    @todo.save

    render json: @todo
  end


  def list
   @todos = Todo.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end


  def index

    #generate missing todos from tasks
    @family = Family.find(session[:member][:family][:id])
    #@scheduler = Scheduler.new(@family)
    #@scheduler.generate_todos(Date.today)
    @week = Date.today.cweek


    @todos = {
     :week => Todo.where(:year => Date.today.year, :month => Date.today.mon, :week => Date.today.cweek, :day => nil ),
     :day => Todo.where(:year => Date.today.year, :month => Date.today.mon).where('day IS NOT NULL'),
     :month => Todo.where(:year => Date.today.year, :month => Date.today.mon, :week => nil, :day => nil )
 
    }


    if params[:list] 
      @todos = Todo.all
      render "list"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end
end
