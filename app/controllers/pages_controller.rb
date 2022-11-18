class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  before_action :api_connect, only: %i[live_market]

  def home
  end

  def live_market
    crypto_parser(@coins)
    @symbol = params['text']
    @symbol.upcase! if @symbol.present?
  end

  def crypto_parser(coins)
    @parsed_coins = []
    coins['data'].each do |coin|
      @parsed_coins << CryptosHelper.coinmarket_struct(coin) if Constants::CRYPTO_LIST.include?(coin['symbol'])
    end
  end
end
