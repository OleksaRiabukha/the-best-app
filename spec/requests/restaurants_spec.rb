
RSpec.describe 'Restaurants', type: :request do
  context 'when logged in user tries to' do
    login_user

    describe 'GET /restaurants' do
      context 'access restaurants list ' do
        let!(:restaurants) { create_list(:restaurant, 5, hidden: false) }

        before do
          get restaurants_path
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:success)
        end

        it 'returns a list with active restaurants' do
          expect(response.body).to include(Restaurant.first.name)
          expect(response.body).to include(Restaurant.last.name)
        end
      end
    end

    describe 'GET /restaurants/:id' do
      context 'access hidden restaurant page' do
        let(:restaurant) { create(:restaurant) }

        before do
          get "/restaurants/#{restaurant.id}"
        end

        it 'shows a flash warning to user' do
          expect(flash[:alert]).to be_present
        end

        it 'redirects to home page' do
          expect(response).to redirect_to('/')
        end

        it 'returns 302 code' do
          expect(response).to have_http_status(:found)
        end
      end

      context 'access active restaurant page' do
        let(:restaurant) { create(:restaurant, hidden: false) }

        before do
          get restaurants_path(restaurant)
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

  context 'when unauthorized user tries to' do
    describe 'GET /restaurants' do
      context 'acces restaurants list' do
        before do
          get restaurants_path
        end

        it 'redirects user to sign in page' do
          expect(response).to redirect_to('/users/sign_in')
        end

        it 'shows flash warning to user' do
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
