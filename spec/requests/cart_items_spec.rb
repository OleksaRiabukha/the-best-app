require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  login_user
  let(:restaurant) { create(:restaurant, active: true) }
  let(:menu_item) { create(:menu_item, restaurant_id: restaurant.id) }

  context 'when logged in user tries to' do
    describe 'POST /cart_items' do
      let(:params) { attributes_for(:cart_item, menu_item_id: menu_item.id) }

      before do
        post cart_items_path, params: params, xhr: true
      end

      context 'create new cart item' do
        it 'returns 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'add cart item to database' do
          expect(CartItem.count).to eq(1)
        end

        it 'creates a cart' do
          expect(Cart.count).to eq(1)
        end

        it 'returns modal window with cart item details' do
          expect(response.body).to include('#modal-window')
          expect(response.body).to include(CartItem.last.menu_item.name)
        end
      end
    end

    describe 'DELETE /cart_items/:id' do
      context 'delete existing cart item' do
        let(:cart_item) { create(:cart_item, quantity: 1, menu_item_id: menu_item.id, price: menu_item.price) }

        before do
          delete cart_item_path(cart_item)
        end

        it 'redirects user to restaurant page' do
          expect(response).to have_http_status(:found)
        end

        it 'deletes cart item from the database' do
          expect(CartItem.count).to eq(0)
        end
      end
    end
  end
end
