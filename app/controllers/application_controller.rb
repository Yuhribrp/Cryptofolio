class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  require 'net/http'
  require 'json'

  private

  def api_connect
    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=b318389a-fdb6-4fc1-b6a1-25ca8a38e3d2&start=1&limit=10&convert=USD'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @coins = JSON.parse(@response)
  end
end
