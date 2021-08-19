require 'rails_helper'

RSpec.describe 'Admin::MenuItems', type: :request do
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }

  context 'when logged in admin tries to' do
    login_admin

    describe 'GET /admin/restaurants/:id/menu_item/:id' do
      context 'access existing menu item page' do
        before do
          get admin_restaurant_menu_item_path(restaurant, menu_item)
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns name of the menu item' do
          expect(response.body).to include(menu_item.name)
        end

        it 'returns description of the menu item' do
          expect(response.body).to include(menu_item.description)
        end

        it 'returns ingredients of the menu item' do
          expect(response.body).to include(menu_item.ingredients)
        end

        it 'returns price of the menu item' do
          expect(response.body).to include("$#{menu_item.price}")
        end
      end
    end

    describe 'POST /admin/restaurants/:id/menu_items' do
      context 'create menu item with valid attributes' do
        let(:params) { { menu_item: attributes_for(:menu_item) } }

        before do
          post admin_restaurant_menu_items_path(restaurant), params: params
        end

        it 'returns 302 code' do
          expect(response).to have_http_status(:found)
        end

        it 'adds menu_item to database' do
          expect(MenuItem.count).to eq(1)
        end

        it 'redirects to restaurant page' do
          expect(response).to redirect_to(admin_restaurant_path(restaurant))
        end

        it 'tells admin that menu item was successfully created' do
          expect(flash[:notice]).to be_present
        end

        it 'returns menu item attributes' do
          follow_redirect!
          expect(response.body).to include(MenuItem.first.name)
        end
      end

      context 'create menu item with invalid attributes' do
        let(:params) { { menu_item: { name: '' } } }

        before do
          post admin_restaurant_menu_items_path(restaurant), params: params
        end

        it 'renders :new template' do
          expect(response.body).to include('Add New Dish!')
        end

        it 'does not add menu item to database' do
          expect(MenuItem.count).to eq(0)
        end
      end
    end

    describe 'PATCH /admin/restaurants/:id/menu_item/:id' do
      context 'update menu item with valid attributes' do
        let(:params) { { menu_item: { name: 'Borsch' } } }

        before do
          patch admin_restaurant_menu_item_path(restaurant, menu_item), params: params
        end

        it 'redirects to restaurant page' do
          expect(response).to redirect_to(admin_restaurant_path(restaurant))
        end

        it 'notifies admin about successful update of menu items' do
          expect(flash[:notice]).to be_present
        end

        it 'returns updated menu item attributes' do
          follow_redirect!
          expect(response.body).to include('Borsch')
        end
      end

      context 'update menu item with invalid attributes' do
        let(:params) { { menu_item: { name: '' } } }

        before do
          patch admin_restaurant_menu_item_path(restaurant, menu_item), params: params
        end

        it 'renders :edit template' do
          expect(response.body).to include('Edit Details')
        end

        it 'does not update menu item attributes' do
          expect(MenuItem.first.name).not_to eq('')
        end
      end
    end

    describe 'DELETE /admin/restaurants/:id/menu_item/:id' do
      context 'delete menu_item' do
        before do
          delete admin_restaurant_menu_item_path(restaurant, menu_item)
        end

        it 'deletes menu item from database' do
          expect(MenuItem.count).to eq(0)
        end

        it 'redirects to restaurant page' do
          expect(response).to redirect_to(admin_restaurant_path(restaurant))
        end

        it 'notifies admin about successful removal of menu item' do
          expect(flash[:notice]).to be_present
        end
      end
    end
  end

  context 'when simple user tries to acces menu items from admin section' do
    login_user

    describe 'GET /admin/restaurants/:id/menu_items/:id' do
      before do
        get admin_restaurant_menu_item_path(restaurant, menu_item)
      end

      it 'redirects user to home page' do
        expect(response).to redirect_to(root_path)
      end

      it 'notifies user about restrictions' do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
