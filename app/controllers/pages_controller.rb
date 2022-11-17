class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  before_action :api_connect, only: %i[live_market]

  def home
  end

  def live_market
    @symbol = params['text']
    @symbol.upcase! if @symbol.present?
  end
end
