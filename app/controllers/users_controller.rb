class UsersController < ApplicationController

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end


  def getUsers
    @me = User.find(params[:id])
    @user = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  
  def getOnline
    @me = User.find(params[:id])
    @user = User.find(:all, :conditions => "online = true")
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @user}
    end
  end
    
  
  def logout
    @user = User.find(params[:id])
    @user.update_attribute(:online,"false")
    
    respond_to do |format|
      format.html { redirect_to(users_url)}
      format.xml { head :ok}
    end
  end
    

  def online?
    @user.online
  end

  



  # GET /users/new
  # GET /users/new.xml
  # render new.rhtml
  def new
  end
  
	
	# POST /users
	# POST /users.xml
	def create
		cookies.delete :auth_token
		# protects against session fixation attacks, wreaks havoc
		# wreaks request forgery protection.
		# uncomment at your own risk
		# reset_session
		@user = User.new(params[:user])
		@user.save!
		self.current_user = @user
		respond_to do |format|
			format.html do
				redirect_back_or_default('/')
				flash[:notice] = "Thanks for signing up!"
			end
			format.xml { render :xml => @user.to_xml }
			end
			rescue ActiveRecord::RecordInvalid
			respond_to do |format|
			format.html { render :action => 'new' }
			format.xml { render :text => "error" }
		end
	end
	
	
	
	
	
end