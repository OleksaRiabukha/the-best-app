require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:menu_item) { create(:menu_item) }
  let(:cart_item_params) { attributes_for(:cart_item, menu_item_id: menu_item.id) }
  let(:params) { { order: attributes_for(:order) } }

  context 'when authenticated user tries to' do
    login_user

    describe 'POST /users/orders' do
      context 'create new order with valid attributes' do

        before do
          post cart_items_path, params: cart_item_params, xhr: true
          post user_orders_path(user_id: User.last.id), params: params
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:found)
        end

        it 'notifies user about accepted user' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects user to restaurants path' do
          expect(response).to redirect_to(restaurants_path)
        end

        it 'adds order to database' do
          expect(Order.count).to eq(1)
        end

        it 'adds items from the cart to order' do
          expect(Order.last.cart_items.last.menu_item.id).to eq(menu_item.id)
        end

        it 'deletes cart from database' do
          expect(Cart.count).to eq(0)
        end
      end

      context 'create new oreder with invalid attributes' do
        let(:params) { { order: { city: '' } } }

        before do
          post cart_items_path, params: cart_item_params, xhr: true
          post user_orders_path(user_id: User.last.id), params: params
        end

        it 'does not add order to database' do
          expect(Order.count).to eq(0)
        end

        it 'does not delete cart from database' do
          expect(Cart.count).to eq(1)
        end

        it 'renders new template' do
          expect(response.body).to include('Your order')
        end
      end
    end
  end

  context 'when unauthenticated user tries do' do
    describe 'POST /users/orders' do
      context 'create new order' do
        let(:user) { create(:user) }

        before do
          post cart_items_path, params: cart_item_params, xhr: true
          post user_orders_path(user.id), params: params
        end

        it 'redirects user to sign in page' do
          expect(response).to redirect_to(new_user_session_path)
        end

        it 'asks user to sign in or sing up' do
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
