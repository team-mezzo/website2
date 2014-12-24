class DonationsController < ApplicationController
  before_action :set_donation,   only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :donor_user,     only: [:new, :create, :edit, :update, :destroy]

  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.all

    # return json object
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @donations.each do |donation|
          # TODO: ONLY RETURNS FIRST DONATION. IF REMOVE AND RETURN, GET DOUBLE RENDER ERROR
          render json: donation.to_json and return 
        end
      }
    end
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @donation = Donation.find(params[:id])

    # return json object
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donation.to_json }
    end
  end

  # GET /donations/new
  def new
    @donation = Donation.new
    @recipients = Stakeholder.recipients # load all possible recipients
  end

  # GET /donations/1/edit
  def edit
  end

  # POST /donations
  # POST /donations.json
  def create
    @donation = Donation.new(donation_params)
    @donation.donor_id = current_user.id # automatically set donor to current user

    respond_to do |format|
      if @donation.save
        format.html { redirect_to @donation, notice: 'Donation was successfully created.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Donation.find(params[:id])
    end

    # Only donors are allowed to create and edit donations.
    def donor_user
      unless current_user.isDonor?
        flash[:danger] = "Organizations cannot create or edit donations."
        redirect_to(donations_path)
      end
    end

    # Only logged in users are allowed to create and edit donations.
    def logged_in_user
      unless logged_in?
        store_location # store where the user was going to go (redirects them to it after they log in)
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit(:pickup_start, :pickup_end, :status, :donor_id, :recipient_id,
                                       food_portion_attributes: [:raw_amount, :processed_amount, :description, :image_url])
    end
end
