class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[show edit update destroy]
  before_action :api_connect, only: %i[index]
  before_action :news_api, only: %i[index]

  require 'news-api'

  def index
    @cryptos = Crypto.all
    crypto_parser
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
      format.html { redirect_to cryptos_url, notice: "#{@crypto['symbol'].upcase!} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def news_api
    newsapi = News.new(ENV.fetch('NEWS_API_KEY'))
    @top_headlines = newsapi.get_top_headlines(q: 'crypto',
                                               category: 'business',
                                               language: 'en',
                                               country: 'us')

    # @top_headlines = newsapi.get_everything(q: 'crypto',
    #                                         from: CryptosHelper.from_to_news('from'),
    #                                         to: CryptosHelper.from_to_news('to'),
    #                                         language: 'en',
    #                                         sortBy: 'relevancy',
    #                                         page: 1)
  end

  def crypto_parser
    @parsed_cryptos = []
    @user_cryptos = Crypto.where(user_id: current_user.id)
    @coins_data = @coins&.dig('data')
    @user_cryptos.each do |crypto|
      @coins_data.each do |coin|
        @parsed_cryptos << CryptosHelper.cryptofolio_struct(coin, crypto) if crypto.symbol.upcase.eql?(coin&.dig('symbol'))
      end
    end
  end

  def set_crypto
    @crypto = Crypto.find(params[:id])
  end

  def crypto_params
    params.require(:crypto).permit(:symbol, :unit_price, :amount_owned)
  end
end
