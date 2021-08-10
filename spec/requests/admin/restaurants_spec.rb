require 'rails_helper'

RSpec.describe "Restaurant", type: :request do
  describe "GET /admin/restaurants/:id" do
    context "when authorized user tries to access restaurant page" do
      login_admin
      let(:restaurant) { FactoryBot.create(:restaurant) }
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

    context "when unauthorized user tires to access restaurant page" do
      login_user
      let(:restaurant) { FactoryBot.create(:restaurant) }
      before do
        get admin_restaurant_path(restaurant)
      end

      it 'shows a flash warning to user' do
        expect(flash[:alert]).to be_present
      end

      it 'redirects to home page' do
        expect(response).to redirect_to('/')
      end

      it "returns 302 code" do
        expect(response).to have_http_status(:found) 
      end
    end
  end

  describe "POST /admin/restaurants/new" do
    context "when authorized users tries to create new restaurant with valid attributes" do
      login_admin
      let(:params) { { restaurant: FactoryBot.attributes_for(:restaurant) } }
      before do
        post admin_restaurants_path, params: params
      end

      it 'returns a 302 success code' do
        expect(response).to have_http_status(:found)
      end
 
      it "adds new restaurant to database" do
        expect(Restaurant.count).to eq(1)
      end

      it "redirects user to newly created restaurant page" do
        expect(response).to redirect_to(admin_restaurant_path(Restaurant.first))
      end
    end

    context "when authorized user tries to create new restaurant with invalid attributes" do
      login_admin
      let(:params) { { restaurant: { name: "" } } }
      before do
        post admin_restaurants_path, params: params
      end

      it "does not add restaurant object to database" do
        expect(Restaurant.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end

    context "when unauthorized user tries to create new restaurant" do
      login_user
      let(:params) { { restaurant: { name: "" } } }
      before do
        post admin_restaurants_path, params: params
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

      it 'does not add restaurant to database' do
        expect(Restaurant.count).to eq(0)
      end
    end
  end

  describe "PATCH /admin/restaurants/:id" do
    context "when authorized user tries to update restaurant details" do
      login_admin
      let(:name) { "new name" }
      let(:restaurant_id) { (FactoryBot.create(:restaurant)).id }
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

    context "when unauthorized user tries to update restaurant details" do
      login_user
      let(:name) { "new name" }
      let(:restaurant_id) { (FactoryBot.create(:restaurant)).id }
      let(:params) { { restaurant: { id: restaurant_id, name: name } } }

      before do
        patch "/admin/restaurants/#{restaurant_id}", params: params
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

      it 'does not update restaurant details' do
        expect(Restaurant.first.name).not_to eq(name)
      end
    end
  end

  describe "DELETE /admin/restaurants/:id" do
    context "when authorized user tries to delete restaurant" do
      login_admin
      let(:restaurant_id) { (FactoryBot.create(:restaurant)).id }

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

    context "when unauthorized user tries to delete restaurant" do
      login_user
      let(:restaurant_id) { (FactoryBot.create(:restaurant)).id }

      before do
        delete "/admin/restaurants/#{restaurant_id}" 
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

      it 'does not delete restaurant from database' do
        expect(Restaurant.count).to eq(1)
      end
    end
  end
end
