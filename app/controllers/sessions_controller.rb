# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

     # 1 minuto de tiempo de inactividad antes de que se cierre la sesión
     SESSION_TIMEOUT = 60

     before_filter :session_expiry

     def session_expiry
          if session[:expiry_time] and session[:expiry_time] < Time.now
               self.destroy
          end
          session[:expiry_time] = SESSION_TIMEOUT.seconds.from_now
          return true
     end


  # GET /sessions
  # GET /sessions.xml
  def index
    @sessions = Session.all

    respond_to do |format|
      format.html # session.html.erb
      format.xml  { render :xml => @sessions }
    end
  end



  # GET /session/new
  # GET /session/new.xml
  # render new.rhtml
  def new
  end
  
     # POST /session
     # POST /session.xml
     def create
          self.current_user =
          User.authenticate(params[:login], params[:password])
          self.current_user.update_attribute(:online,"true")
          if logged_in?
               if params[:remember_me] == "1"
                    self.current_user.remember_me
                    cookies[:auth_token] = {
                    :value => self.current_user.remember_token ,
                    :expires =>
                    self.current_user.remember_token_expires_at }
               end
               respond_to do |format|
               format.html do
               redirect_back_or_default('/')
               flash[:notice] = "Logged in successfully"
          end
          format.xml { render :xml => self.current_user.to_xml }
          end
          else
          respond_to do |format|
          format.html { render :action => 'new' }
          format.xml { render :text => "badlogin" }
          end
          end
     end  
   # DELETE /session
   # DELETE /session.xml
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
end
