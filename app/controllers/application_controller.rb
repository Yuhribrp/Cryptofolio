class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  require 'faraday'

  private

  def api_connect
    url = Constants::BASE_URL
    conn = Faraday.new("#{url}CMC_PRO_API_KEY=#{ENV.fetch('MKT_API_KEY')}&start=1&limit=15&convert=USD") do |f|
      f.response :json
    end
    @coins = conn.get.body
  end
end
