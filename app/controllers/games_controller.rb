class GamesController < ApplicationController
  # GET /games
  # GET /games.xml
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end
  
  def list
	#@games = Game.all
	@games = Game.find(:all, :order => "name")
	render :xml => @games.to_xml
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(@game) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
  
  def getUserGames
    @user = User.find(params[:id])
    @games = @user.games

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end
  
  def addGameToUser
	logger.info('Metodo addGameToUser')
	@user = User.find(params[:game][:userid])
	@game = Game.find_by_name(params[:game][:name])
	if @user.games.find_by_name(params[:game][:name])
		respond_to do |format|
			format.xml { render :text => "error" }
		end
	else
		@user.games << @game
		respond_to do |format|
			#format.html # index.html.erb
			format.xml  { render :xml => @user.games }
		end
	end
  end
  
  def deleteGameToUser
	logger.info('Metodo deleteGameToUser')
	@user = User.find(params[:game][:userid])
	@game = Game.find_by_name(params[:game][:name])
	if @user.games.find_by_name(params[:game][:name])
		@user.games.delete(@game)
		respond_to do |format|
			#format.html # index.html.erb
			format.xml  { render :text => "ok" }
		end
	else
		respond_to do |format|
			format.xml { render :text => "error" }
		end
		
	end
  end
  
  
  
  
  def getPlayers
  	@game = Game.find_by_name(params[:id])
    @users = @game.users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  
end
