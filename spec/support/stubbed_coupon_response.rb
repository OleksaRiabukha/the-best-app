require 'webmock/rspec'

module StubbedCouponResponse
  URL = Rails.application.credentials.dig(:coupon, :url)

  def self.response(params)
    stubbed_coupon_response =
      {
        "data": {
          "id": Faker::Number.number,
          "type": 'coupon',
          "attributes": {
            "id": Faker::Number.number,
            "coupon_number": params[:coupon_number],
            "amount": params[:amount],
            "used": false,
            "for_present": params[:for_present]
          }
        }
      }

    WebMock.stub_request(:post, URL).to_return(status: 200,
                                               body: stubbed_coupon_response.to_json)
  end
end
