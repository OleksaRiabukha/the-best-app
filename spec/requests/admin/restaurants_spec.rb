require 'rails_helper'

RSpec.describe 'Restaurant', type: :request do
  context 'when logged in admin tries to' do
    login_admin

    describe 'GET /admin/restaurants/:id' do
      context 'access restaurant page' do
        let(:restaurant) { create(:restaurant) }

        before do
          get admin_restaurant_path(restaurant)
        end

        it 'returns a 200 success code' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns a name of the restaurant' do
          expect(response.body).to include(restaurant.name)
        end

        it 'returns a description of the restaurant' do
          expect(response.body).to include(restaurant.description)
        end

        it 'returns a phone number of the restaurant' do
          expect(response.body).to include(restaurant.phone_number)
        end

        it 'returns a website url of the restaurant' do
          expect(response.body).to include(restaurant.website_url)
        end
      end
    end

    describe 'POST /admin/restaurants' do
      context 'create new restaurant with valid attributes' do
        let(:category) { create(:category) }
        let(:params) { { restaurant: attributes_for(:restaurant, category_id: category.id) } }

        before do
          post admin_restaurants_path, params: params
        end

        it 'returns a 302 success code' do
          p response.body
          expect(response).to have_http_status(:found)
        end

        it 'adds new restaurant to database' do
          expect(Restaurant.count).to eq(1)
        end

        it 'redirects user to newly created restaurant page' do
          expect(response).to redirect_to(admin_restaurant_path(Restaurant.first))
        end
      end

      context 'create new restaurant with invalid attributes' do
        let(:category) { create(:category) }
        let(:params) { { restaurant: { name: '', category: category } } }

        before do
          post admin_restaurants_path, params: params
        end

        it 'does not add restaurant object to database' do
          expect(Restaurant.count).to eq(0)
        end

        it 'renders new template' do
          expect(response.body).to include('Add new restaurant')
        end
      end
    end

    describe 'PATCH /admin/restaurants/:id' do
      context 'update restaurant details' do
        let(:name) { 'new name' }
        let(:restaurant_id) { (create(:restaurant)).id }
        let(:params) { { restaurant: { id: restaurant_id, name: name } } }

        before do
          patch "/admin/restaurants/#{restaurant_id}", params: params
        end

        it 'updates restaurant attributes' do
          expect(Restaurant.first.name).to eq(name)
        end

        it 'redirects user to restaurant page' do
          expect(response).to redirect_to(admin_restaurant_path(Restaurant.first))
        end
      end
    end

    describe 'DELETE /admin/restaurants/:id' do
      context 'delete restaurant' do
        let(:restaurant_id) { (create(:restaurant)).id }

        before do
          delete "/admin/restaurants/#{restaurant_id}"
        end

        it 'delete restaurant from database' do
          expect(Restaurant.count).to eq(0)
        end

        it 'redirects admin to dashboard' do
          expect(response).to redirect_to(admin_dashboard_path)
        end
      end
    end
  end

  context 'when simple logged in user tries to' do
    login_user

    describe 'GET /admin/restaurants/:id' do
      context 'access admin restaurant page' do
        let(:restaurant) { create(:restaurant) }

        before do
          get "/admin/restaurants/#{restaurant.id}"
        end

        it 'redirects to home page' do
          expect(response).to redirect_to('/')
        end
      end
    end
  end
end
