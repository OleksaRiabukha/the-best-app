RSpec.shared_examples 'simple user is not authorized' do
  login_user

  before do
    call_action
  end

  it 'shows a flash warning to user' do
    expect(flash[:alert]).to be_present
  end

  it 'redirects to home page' do
    expect(response).to redirect_to('/')
  end

  it "returns 302 code" do
    expect(response).to have_http_status(:found) 
  end
end
