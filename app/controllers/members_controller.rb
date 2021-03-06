class MembersController < ProtectedController
  # GET /members
  # GET /members.json
  before_filter :require_admin_login
  def index
    if params.has_key? :family_id
      @members = Family.find(params[:family_id]).members

    elsif session[:member]
      @members = Family.find(session[:member][:family][:id]).members
    
    else
      @members = Member.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new
    @family = Family.find(params[:family_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @family = Family.find(params[:member][:family_id])
    @member = Member.new(params[:member])
    @member.family_id = @family.id

    respond_to do |format|
      if @member.save
        format.html { redirect_to family_members_path, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])
    puts "!!!!!!!!! upate !!!!!!!!!!!!!"
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to "/#{@member.family.slug}/members"  , notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to family_members_path }
      format.json { head :no_content }
    end
  end
end
