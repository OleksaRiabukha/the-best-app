require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  describe "GET /admin/dashboard" do
    context 'when authorized user tries to access dashboard' do
      login_admin

      it 'returns 200 code' do
        get admin_dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthorized user tries to access dashboard' do
      let(:call_action) { get admin_dashboard_path } 
    end
  end
end
