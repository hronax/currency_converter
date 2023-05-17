# frozen_string_literal: true

require 'httparty'
require 'json'

# CurrencyConverter class allow to convert currencies
class CurrencyConverter
  include HTTParty

  class ApiConnectionError < StandardError
  end

  class WrongTypeError < StandardError
  end

  base_uri 'https://open.er-api.com/v6/latest'

  def self.convert(from_currency, amount, to_currency)
    begin
      response = get("/#{from_currency}")

      unless response.success? && response.parsed_response['result'] == 'success'
        raise WrongTypeError,
              "Error converting currency. Error type: #{response.parsed_response["error-type"]}. Please try again."
      end

      exchange_rate = JSON.parse(response.body)['rates'][to_currency]
      (amount.to_f * exchange_rate).round(2)
    rescue SocketError => e
      raise ApiConnectionError, "Problem with connection to an API. #{e.message}"
    end
  end
end
