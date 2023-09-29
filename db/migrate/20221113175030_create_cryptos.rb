class CreateCryptos < ActiveRecord::Migration[7.0]
  def change
    create_table :cryptos do |t|
      t.string :symbol
      t.decimal :unit_price
      t.decimal :amount_owned
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
