require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  context 'when logged in user tries to' do
    # let(:stripe_helper) { StripeMock.create_test_helper }
    # before { StripeMock.start }
    # after { StripeMock.stop }
    # let(:customer) { Stripe::Customer.create() }
    login_user
    let!(:restaurant) { create(:restaurant, active: true) }

    describe 'GET /restaurants' do
      context 'access restaurants list ' do
        before do
          get restaurants_path
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:success)
        end

        it 'returns a list with active restaurants' do
          expect(CGI.unescapeHTML(response.body)).to include(Restaurant.first.name)
          expect(CGI.unescapeHTML(response.body)).to include(Restaurant.first.description.truncate(180, separator: '.'))
        end
      end
    end

    describe 'GET /restaurants/:id' do
      let!(:menu_item) { create(:menu_item, available: true, restaurant: restaurant) }

      context 'access active restaurant page' do
        before do
          get restaurant_path(restaurant)
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:success)
        end

        it 'returns valid restaurant details' do
          expect(CGI.unescapeHTML(response.body)).to include(restaurant.name)
        end

        it 'returns menu items of the restaurant' do
          expect(response.body).to include(restaurant.menu_items.first.name)
        end
      end
    end
  end
end
