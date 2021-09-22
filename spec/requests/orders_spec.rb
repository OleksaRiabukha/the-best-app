require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:menu_item) { create(:menu_item) }
  let(:cart_item_params) { attributes_for(:cart_item, menu_item_id: menu_item.id) }
  let(:card_params) { { order: attributes_for(:order, pay_type: 'Card') } }
  let(:cash_params) { { order: attributes_for(:order, pay_type: 'Cash') } }

  context 'when authenticated user tries to' do
    login_user

    describe 'POST /users/orders' do
      context 'create new order with valid attributes and card payment' do

        before do
          post cart_items_path, params: cart_item_params, xhr: true
          post user_orders_path(user_id: User.last.id), params: card_params, xhr: true
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'adds order to database' do
          expect(Order.count).to eq(1)
        end

        it 'adds address and payment type to order' do
          expect(Order.last.city).to be_present
          expect(Order.last.street).to be_present
          expect(Order.last.pay_type).to eq('Card')
        end

        it 'sets orders payment status to "pending_card_payment"' do
          expect(Order.last.payment_status).to eq('pending_card_payment')
        end
      end

      context 'create order with valid attributes and cash payment' do
        before do
          post cart_items_path, params: cart_item_params, xhr: true
          post user_orders_path(user_id: User.last.id), params: cash_params, xhr: true
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'creates an order with "pending_cash_payment"' do
          expect(Order.count).to eq(1)
          expect(Order.last.payment_status).to eq('pending_cash_payment')
        end

        it 'copies cart items and total price from cart to order' do
          expect(Order.last.cart_items.last.menu_item.id).to eq(menu_item.id)
        end

        it 'destroys cart' do
          expect(Cart.count).to eq(0)
        end

        it 'redirects user to restaurants page' do
          expect(response).to redirect_to(restaurants_path)
        end

        it 'notifies user about successful creation of the order' do
          expect(flash[:notice]).to be_present
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
          post user_orders_path(user.id), params: cash_params
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
