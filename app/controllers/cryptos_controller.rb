class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[show edit update destroy]
  before_action :api_connect, only: %i[index]

  def index
    @cryptos = Crypto.all
    @user_cryptos = Crypto.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @crypto = Crypto.new
  end

  def edit
  end

  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.user = current_user

    respond_to do |format|
      if @crypto.save
        format.html { redirect_to cryptos_path, notice: "Crypto was successfully created." }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to crypto_url(@crypto), notice: "Crypto was successfully updated." }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @crypto.destroy

    respond_to do |format|
      format.html { redirect_to cryptos_url, notice: "Crypto was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_crypto
    @crypto = Crypto.find(params[:id])
  end

  def crypto_params
    params.require(:crypto).permit(:symbol, :unit_price, :amount_owned)
  end
end
