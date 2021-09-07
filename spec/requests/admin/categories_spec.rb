require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  context 'when logged in admin tries to' do
    login_admin

    describe 'POST /admin/categories' do
      context 'create a category with valid attributes' do
        let(:params) { { category: attributes_for(:category) } }

        before do
          post admin_categories_path, params: params
        end

        it 'returns a 302 code' do
          expect(response).to have_http_status(:found)
        end

        it 'adds category to database' do
          expect(Category.count).to eq(2)
        end

        it 'redirects admin to newly created category page' do
          expect(response).to redirect_to(admin_category_path(Category.first))
        end

        it 'returns valid category details' do
          follow_redirect!
          expect(response.body).to include(Category.first.name)
          expect(response.body).to include(Category.first.description)
        end
      end

      context 'create a category with invalid attributes' do
        let(:params) { { category: { name: '' } } }

        before do
          post admin_categories_path, params: params
        end

        it 'does not add category to database' do
          expect(Category.count).to eq(1)
        end

        it 'renders new template' do
          expect(response.body).to include('Add new category')
        end
      end
    end

    let!(:category) { create(:category) }

    describe 'GET /admin/categories' do
      context 'access categories list' do
        before do
          get admin_categories_path
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns valid categories details' do
          expect(response.body).to include(Category.first.name)
          expect(response.body).to include(Category.first.description)
        end
      end
    end

    describe 'GET /admin/categories/:id' do
      context 'access existing category page' do

        before do
          get admin_category_path(category)
        end

        it 'returns 200 code' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns valid category details' do
          expect(response.body).to include(Category.first.name)
          expect(response.body).to include(Category.first.description)
        end
      end
    end

    describe 'PATCH /admin/category/:id' do
      context 'update category with valid attributes' do
        let(:params) { { category: { name: 'La Fabrique', description: 'The Best Restaurant Ever' } } }

        before do
          patch admin_category_path(category), params: params
        end

        it 'returns a 302 code' do
          expect(response).to have_http_status(:found)
        end

        it 'redirects admin to category page' do
          expect(response).to redirect_to(admin_category_path(category))
        end

        it 'update attributes and return them' do
          follow_redirect!
          expect(response.body).to include('La Fabrique')
          expect(response.body).to include('The Best Restaurant Ever')
        end
      end

      context 'update category with invalid attributes' do
        let(:params) { { category: { name: '' } } }

        before do
          patch admin_category_path(category), params: params
        end

        it 'renders an edit template' do
          expect(response.body).to include('Edit category')
        end

        it 'does not change category attributes' do
          expect(Category.first.name).not_to eq('')
        end
      end
    end

    describe 'DELETE /admin/category/:id' do
      context 'tries to delete existing category' do
        before do
          delete admin_category_path(category)
        end

        it 'returns 302 code' do
          expect(response).to have_http_status(:found)
        end

        it 'deletes category from database' do
          expect(Category.count).to eq(0)
        end

        it 'redirects admin to index page' do
          expect(response).to redirect_to(admin_categories_path)
        end
      end
    end
  end

  context 'when unauthorized user tries to' do
    login_user

    describe 'GET /admin/categories' do
      before do
        get admin_categories_path
      end

      it 'redirects to home page' do
        expect(response).to redirect_to('/')
      end

      it 'throws warning' do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
