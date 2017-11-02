class ChannsController < ApplicationController
  before_action :set_chann, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Chann.where(user_id: current_user.id).page(params[:page])
  end

  def show
  end

  def new
    @channel = Chann.new
    #@list=Category.pluck(:name,:id)
  end

  def edit
    #@list=Category.pluck(:name,:id)
  end

  def create
    @channel = Chann.new(chann_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @channel=Chann.find(params[:id])

    respond_to do |format|
      # binding.pry
      #lo
      if @channel.update( chann_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channs_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_chann
    @channel = Chann.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chann_params
    params.fetch(:category, {})
    params.require(:chann).permit(:name, :user_id)
    #category_params.merge(parent: params[:parent].to_i)
  end
end
