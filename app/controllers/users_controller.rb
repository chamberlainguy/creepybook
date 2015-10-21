class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def wall
    @user = User.find(params[:id])
  end

  def search
  end  

  def unfriend
    @user = User.find(params[:id])
    @current_user.friends.delete(@user)
    @user.friends.delete(@current_user)
    redirect_to :back
  end

  def befriend
    @user = User.find(params[:id])
    @current_user.friends << @user
    @user.friends << @current_user
    redirect_to :back
  end

  def news
    if @current_user.present?
        # Get all the statuses on on current users wall
        @statuses = @current_user.ownedby_statuses
        # Also get all the statuses that current user posted on other peoples walls
        @statuses += @current_user.postedby_statuses
        # Also include any status update that current user has commented on
        @current_user.comments.each do |c|
          @statuses << c.status
        end  

        @current_user.friends.each do |friend|
            # Get all the statuses on their walls
            @statuses += friend.ownedby_statuses
            # Also get all the statuses that they posted on other peoples walls
            @statuses += friend.postedby_statuses
            # Also get any statuses that friends have comented on
            friend.comments.each do |c|
              @statuses << c.status
            end
        end 
        @statuses = @statuses.sort_by { |s| s[:created_at] }.reverse

        @statuses = @statuses.uniq   # uniq, my favorite method

    else
      redirect_to login_path
    end
  end

  # GET /users
  # GET /users.json
  def index
    
    if params[:search].present? 
      
      # Read based on the search param
      s = '%' + params[:search] + '%'
      @users = User.where('lower(firstname) LIKE ?', s.downcase).all
      
      # Also search through descriptions
      @users += User.where('lower(surname) LIKE ?', s.downcase).all
      
      # Make sure users are unique in the array
      @users = @users.uniq         # The coolest statement yet!!
      @search_desc = "Search results"
    else 
      @users = User.all
      @search_desc = "Showing all People"
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # Login this newly created user
        session[:user_id] = @user.id

        format.html { redirect_to user_wall_path(id: @user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_wall_path(id: @user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # Make sure they can only :show, :edit, :update, :destroy current user 
      # @user = User.find(params[:id])
      @user = @current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :surname, :email, :password, :password_confirmation)
    end
end
