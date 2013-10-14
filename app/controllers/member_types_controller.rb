class MemberTypesController < ApplicationController
  # GET /member_types
  # GET /member_types.json
  def index
    @member_types = MemberType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member_types }
    end
  end

  # GET /member_types/1
  # GET /member_types/1.json
  def show
    @member_type = MemberType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member_type }
    end
  end

  # GET /member_types/new
  # GET /member_types/new.json
  def new
    @member_type = MemberType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member_type }
    end
  end

  # GET /member_types/1/edit
  def edit
    @member_type = MemberType.find(params[:id])
  end

  # POST /member_types
  # POST /member_types.json
  def create
    @member_type = MemberType.new(params[:member_type])

    respond_to do |format|
      if @member_type.save
        format.html { redirect_to @member_type, notice: 'Member type was successfully created.' }
        format.json { render json: @member_type, status: :created, location: @member_type }
      else
        format.html { render action: "new" }
        format.json { render json: @member_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /member_types/1
  # PUT /member_types/1.json
  def update
    @member_type = MemberType.find(params[:id])

    respond_to do |format|
      if @member_type.update_attributes(params[:member_type])
        format.html { redirect_to @member_type, notice: 'Member type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_types/1
  # DELETE /member_types/1.json
  def destroy
    @member_type = MemberType.find(params[:id])
    @member_type.destroy

    respond_to do |format|
      format.html { redirect_to member_types_url }
      format.json { head :no_content }
    end
  end
end
