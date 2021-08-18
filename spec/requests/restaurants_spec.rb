RSpec.describe 'Restaurants', type: :request do
  context 'when logged in user tries to' do
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
          expect(response.body).to include(Restaurant.first.name)
          expect(response.body).to include(Restaurant.first.description)
        end
      end
    end

    describe 'GET /restaurants/:id' do
      context 'access active restaurant page' do
        before do
          get "/restaurants/#{restaurant.id}"
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:success)
        end

        it 'returns valid restaurant details' do
          expect(response.body).to include(restaurant.name)
          expect(response.body).to include(restaurant.description)
        end
      end
    end
  end
end
