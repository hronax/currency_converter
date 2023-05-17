# frozen_string_literal: true

require 'currency_converter'

RSpec.describe CurrencyConverter do
  let(:from_currency) { 'USD' }
  let(:amount) { 100 }
  let(:to_currency) { 'EUR' }
  let(:exchange_rate) { 0.85 }

  subject { described_class.convert(from_currency, amount, to_currency) }

  describe '#convert' do
    context 'when the conversion is successful' do
      before do
        response = double(success?: true,
                          parsed_response: { 'result' => 'success' },
                          body: { 'rates' => { to_currency => exchange_rate } }.to_json)
        allow(described_class).to receive(:get).and_return(response)
      end

      it 'returns the converted amount' do
        converted_amount = subject
        expected_amount = (amount * exchange_rate).round(2)
        expect(converted_amount).to eq(expected_amount)
      end
    end

    context 'when the conversion fails' do
      before do
        response = double(success?: false, parsed_response: { 'result' => 'error', 'error-type' => 'wrong-code' })
        allow(described_class).to receive(:get).and_return(response)
      end

      it 'raises an error with the specific error message' do
        expect do
          subject
        end.to raise_error(CurrencyConverter::WrongTypeError, 'Error converting currency. Error type: wrong-code. Please try again.')
      end
    end

    context 'when api does not respond' do
      before do
        allow(described_class).to receive(:get).and_raise(SocketError.new('Timeout Error'))
      end

      it 'raises an error with the specific error message' do
        expect do
          subject
        end.to raise_error(CurrencyConverter::ApiConnectionError, 'Problem with connection to an API. Timeout Error')
      end
    end
  end
end
