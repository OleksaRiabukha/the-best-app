
RSpec.describe "Restaurants", type: :request do
  describe "GET /restaurants" do
    context "when logged in user tries to access restaurants list " do
      login_user
      let!(:restaurants) { FactoryBot.create_list(:restaurant, 5, hidden: false)}
   
      before do
        get restaurants_path
      end

      it 'returns a 200 code' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list with active restaurants' do
        expect(assigns(:restaurants)).to eq(restaurants)
      end
    end

    context "when unauthenticated user tries to access restaurants list" do
      let!(:restaurants) { FactoryBot.create_list(:restaurant, 5, hidden: false) }

      before do
        get restaurants_path
      end

      it 'redirects user to sign in page' do
        expect(response).to redirect_to("/")
      end

      it 'throws a warning' do
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET /restaurants/:id" do
    context "when logged in user tries to access hidden restaurant page" do
      login_user
      let(:restaurant) { FactoryBot.create(:restaurant, hidden: true) }

      before do
        get "/restaurants/#{restaurant.id}"
      end

      it "redirects to restaurants page" do
        p response.status
        expect(response).to redirect_to('/')
      end

      it 'shows a flash warning to user' do
        expect(flash[:alert]).to be_present
      end
    end

    context "when logged in user tries to access active restaurant page" do
      login_user
      let(:restaurant) { FactoryBot.create(:restaurant, hidden: false) }
      
      before do
        get restaurants_path(restaurant)
      end

      it "returns a 200 code" do
        expect(response).to have_http_status(:success)
      end

      it 'returns valid restaurant details' do
        expect(response.body).to include(restaurant.name)
        expect(response.body).to include(restaurant.description)        
      end
    end

    context "when unauthenticated user tries to access restaurant page" do
      let(:restaurant) { FactoryBot.create(:restaurant, hidden: "false") }

      before do
        get restaurants_path(restaurant)
      end

      it 'returns a 401 code' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a warning' do
        expect(response.body).to include("You need to sign in or sign up before continuing")
      end
    end

  end
end