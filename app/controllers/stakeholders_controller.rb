class StakeholdersController < ApplicationController
  before_action :set_stakeholder, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy] # can't do these if not logged in
  before_action :correct_user,    only: [:edit, :update] # can't edit other people's profiles

  # GET /stakeholders
  # GET /stakeholders.json
  def index
    @stakeholders = Stakeholder.all
  end

  # GET /stakeholders/1
  # GET /stakeholders/1.json
  def show
  end

  # GET /stakeholders/new
  def new
    @stakeholder = Stakeholder.new
  end

  # GET /stakeholders/1/edit
  def edit
  end

  # POST /stakeholders
  # POST /stakeholders.json
  def create
    @stakeholder = Stakeholder.new(stakeholder_params)

    respond_to do |format|
      if @stakeholder.save
        log_in @stakeholder # logs in new user
        format.html { redirect_to @stakeholder, notice: 'You signed up successfully' }
        format.json { render :show, status: :created, location: @stakeholder }
      else
        format.html { render :new }
        format.json { render json: @stakeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stakeholders/1
  # PATCH/PUT /stakeholders/1.json
  def update
    respond_to do |format|
      if @stakeholder.update(stakeholder_params)
        format.html { redirect_to @stakeholder, notice: 'Profile updated.' }
        format.json { render :show, status: :ok, location: @stakeholder }
      else
        format.html { render :edit }
        format.json { render json: @stakeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stakeholders/1
  # DELETE /stakeholders/1.json
  def destroy
    @stakeholder.destroy
    respond_to do |format|
      format.html { redirect_to stakeholders_url, notice: 'User deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stakeholder
      @stakeholder = Stakeholder.find(params[:id])
    end

    # Confirms a logged-in user. If not, redirects to login page.
    def logged_in_user
      unless logged_in?
        store_location # store where the user was going to go (redirects them to it after they log in)
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Prevents logged in users from editing other users' profiles. Redirects to donations.
    def correct_user
      @stakeholder = Stakeholder.find(params[:id])
      redirect_to(donations_path) unless current_user?(@stakeholder)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stakeholder_params
      params.require(:stakeholder).permit(:email, :password, :password_confirmation)
    end
end
