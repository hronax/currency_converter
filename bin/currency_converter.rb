# frozen_string_literal: true

require_relative '../lib/currency_converter'

if ARGV.length < 3
  puts 'Usage: ruby bin/currency_converter.rb FROM_CURRENCY AMOUNT TO_CURRENCY'
else
  from_currency = ARGV[0].upcase
  amount = ARGV[1].to_f
  to_currency = ARGV[2].upcase

  begin
    converted_amount = CurrencyConverter.convert(from_currency, amount, to_currency)
    puts "#{amount} #{from_currency} = #{converted_amount} #{to_currency}"
  rescue ApiConnectionError, WrongTypeError => e
    puts e.message
  end
end
