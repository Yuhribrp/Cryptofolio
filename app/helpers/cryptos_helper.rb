module CryptosHelper
  def self.coinmarket_struct(coin)
    {
      coin_rank: coin['cmc_rank'],
      coin_name: coin['name'],
      coin_symbol: coin['symbol'],
      coin_price: coin['quote']['USD']['price']
    }.with_indifferent_access
  end

  def self.cryptofolio_struct(coin, crypto)
    {
      name: coin['name'],
      cost_paid: crypto.unit_price,
      amount_owned: crypto.amount_owned,
      current_price: coin['quote']['USD']['price'],
      current_total_value: total_value_calc(coin, crypto),
      total_paid: total_paid_calc(crypto),
      profit_loss: profit_loss_calc(coin, crypto),
      percent_changes: coin['quote']['USD']['percent_change_1h'],
      id: crypto.id
    }.with_indifferent_access
  end

  def self.total_value_calc(coin, crypto)
    coin['quote']['USD']['price'].to_d * crypto.amount_owned
  end

  def self.total_paid_calc(crypto)
    crypto.unit_price * crypto.amount_owned
  end

  def self.profit_loss_calc(coin, crypto)
    total_value_calc(coin, crypto) - total_paid_calc(crypto)
  end
end
