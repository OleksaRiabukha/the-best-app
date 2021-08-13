
RSpec.describe "Restaurants", type: :request do
  context "when logged in user tries to" do
    login_user
    describe "GET /restaurants" do
      context "access restaurants list " do
        let!(:restaurants) { FactoryBot.create_list(:restaurant, 5, hidden: false)}
    
        before do
          get restaurants_path
        end

        it 'returns a 200 code' do
          expect(response).to have_http_status(:success)
        end

        # it 'returns a list with active restaurants' do
        #   expect(assigns(:restaurants)).to eq(restaurants)
        # end
      end
    end

    describe "GET /restaurants/:id" do
      context "access hidden restaurant page" do
        let(:restaurant) { FactoryBot.create(:restaurant) }
        let(:call_action) { get restaurants_path(restaurant) }
        
        it_behaves_like "simple user is not authorized"
      end

      context "when logged in user tries to access active restaurant page" do
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
    end
  end
end