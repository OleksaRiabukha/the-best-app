class CouponCreator
  class << self
    URL = Rails.application.credentials.dig(:coupon, :url)
    API_KEY = Rails.application.credentials.dig(:coupon, :api_key)

    def create(amount, for_present)
      body = { coupon: { amount: amount, for_present: for_present } }.to_json
      connection = connect

      response = connection.post(URL) do |req|
        req.body = body
      end

      parsed_response = JSON.parse(response.body)

      return parsed_response if response.status == 200

      log_error(parsed_response) if parsed_response.include?('errors')
    end

    def log_error(error)
      logger = Rails.logger
      errors = error['errors'][0]
      message = %(Coupon API Errors: status: #{errors['status']},
                            model: #{errors['source']['pointer']},
                            title: #{errors['title']},
                            details: #{errors['details']}).squish

      logger.error message
    end

    private

    def connect
      Faraday.new(
        url: URL,
        headers: { 'Content-Type' => 'application/json', 'Authorization' => API_KEY }
      )
    end
  end
end
