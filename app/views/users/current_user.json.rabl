object @user

attributes :id,
           :display_name,
           :email,
           :username

node(:has_currency) do |user|
  currencies = {}

  Address::CURRENCIES.each do |currency|
    name = currency.currency_name.downcase
    currencies[name] = user.addresses.send(name).any?
  end

  currencies
end

node(:balances) do |user|
  balances = {}

  Address::CURRENCIES.each do |currency|
    balances[currency.short_name.downcase] = {}

    balance = user.addresses.send(currency.currency_name.downcase).inject(0) { |sum, address| sum + address.get_currency.send("to_#{currency.short_name.downcase}", address.balance) }
    rounded = ActiveSupport::NumberHelper.number_to_rounded(balance, precision: 8, strip_insignificant_zeros: true)
    balances[currency.short_name.downcase]['balance'] = ActiveSupport::NumberHelper.number_to_delimited(rounded)

    ['usd', 'eur', 'gbp', 'jpy'].each do |fiat_currency|
      balance = user.addresses.send(currency.currency_name.downcase).inject(0) { |sum, address| sum + address.get_currency.send("to_#{fiat_currency}", address.balance) }
      rounded = ActiveSupport::NumberHelper.number_to_rounded(balance, precision: 2)
      balances[currency.short_name.downcase]["balance_#{fiat_currency}"] = ActiveSupport::NumberHelper.number_to_delimited(rounded)
    end
  end

  balances
end

node(:totals) do |user|
  totals = {}

  Address::CURRENCIES.each do |currency|
    total = user.addresses.inject(0) { |sum, address| sum + address.get_currency.send("to_#{currency.short_name.downcase}", address.balance) }
    rounded = ActiveSupport::NumberHelper.number_to_rounded(total, precision: 8, strip_insignificant_zeros: true)
    totals[currency.short_name.downcase] = ActiveSupport::NumberHelper.number_to_delimited(rounded)
  end

  ['usd', 'eur', 'gbp', 'jpy'].each do |fiat_currency|
    total = user.addresses.inject(0) { |sum, address| sum + address.get_currency.send("to_#{fiat_currency}", address.balance) }
    rounded = ActiveSupport::NumberHelper.number_to_rounded(total, precision: 2)
    totals[fiat_currency] = ActiveSupport::NumberHelper.number_to_delimited(rounded)
  end

  totals
end
