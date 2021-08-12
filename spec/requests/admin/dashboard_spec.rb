require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /admin/dashboard' do
    context 'when authorized user tries to access dashboard' do
      login_admin

      it 'returns 200 code' do
        get admin_dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthorized user tries to access dashboard' do
      login_user

      before do
        get admin_dashboard_path
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
  end
end
