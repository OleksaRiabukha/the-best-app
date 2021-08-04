require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  describe "GET /admin/dashboard" do
    context 'when unauthorized user tries to access dashboard' do
      login_user

      before(:each) do
        get '/admin/dashboard'
      end

      it 'shows a flash warning to user' do
        expect(flash[:alert]).to be_present
      end

      it 'redirects to home page' do
        expect(response).to redirect_to('/')
      end

      it "it returns 302 code" do
        expect(response.status).to eq(302) 
      end
    end

    context 'when authorized user tries to access dashboard' do
      login_admin

      it 'returns 200 code' do
        get '/admin/dashboard'
        expect(response).to be_ok
      end
    end
  end
end
