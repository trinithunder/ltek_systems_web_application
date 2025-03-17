module PayPalInvoiceConcern
  extend ActiveSupport::Concern

  require 'faraday'
  require 'json'

  class PayPalInvoiceService
    PAYPAL_API_BASE = "https://api-m.paypal.com/v2/invoicing/invoices"

    def initialize(client_id:, client_secret:)
      @client_id = client_id
      @client_secret = client_secret
      @access_token = authenticate
    end

    def create_invoice(recipient_email:, items:, currency: "USD")
      invoice_data = build_invoice_data(recipient_email, items, currency)
      response = send_request(PAYPAL_API_BASE, invoice_data)
      response.body
    end

    def send_invoice(invoice_id)
      response = send_request("#{PAYPAL_API_BASE}/#{invoice_id}/send", {}, :post)
      response.body
    end

    private

    def authenticate
      conn = Faraday.new(url: "https://api-m.paypal.com") do |faraday|
        faraday.basic_auth(@client_id, @client_secret)
        faraday.adapter Faraday.default_adapter
      end
      response = conn.post("/v1/oauth2/token", { grant_type: "client_credentials" })
      JSON.parse(response.body)["access_token"]
    end

    def build_invoice_data(recipient_email, items, currency)
      {
        detail: {
          currency_code: currency,
          note: "Thank you for your business!",
          terms_and_conditions: "Payment due upon receipt."
        },
        invoicer: {
          email_address: "your-business@example.com"
        },
        primary_recipients: [
          {
            billing_info: {
              email_address: recipient_email
            }
          }
        ],
        items: items.map do |item|
          {
            name: item[:name],
            quantity: item[:quantity],
            unit_amount: {
              currency_code: currency,
              value: item[:price]
            }
          }
        end
      }.to_json
    end

    def send_request(url, data, method = :post)
      conn = Faraday.new(url: url) do |faraday|
        faraday.headers["Authorization"] = "Bearer #{@access_token}"
        faraday.headers["Content-Type"] = "application/json"
        faraday.adapter Faraday.default_adapter
      end
      conn.send(method, url, data)
    end
  end

  included do
    def paypal_invoice_service(client_id:, client_secret:)
      PayPalInvoiceService.new(client_id: client_id, client_secret: client_secret)
    end
  end
end
