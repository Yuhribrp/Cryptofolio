class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  before_action :api_connect, only: %i[live_market]

  require 'net/http'
  require 'json'

  def home
  end

  def live_market
    @cryptos_list = %w[BTC ETH USDT BNB USDC BUSD XRP ADA DOGE MATIC]
    @symbol = params['sym']
    @symbol.upcase! if @symbol.present?
    @symbol = "You need to enter a currency" if @symbol.blank?
  end

  private

  def api_connect
    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=b318389a-fdb6-4fc1-b6a1-25ca8a38e3d2&start=1&limit=10&convert=USD'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins = JSON.parse(@response)
  end
end
