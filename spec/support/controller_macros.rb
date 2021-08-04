module ControllerMacros
  def login_user
    before(:each) do
      sign_in FactoryBot.create(:admin, :simple_user)
    end
  end

  def login_admin
    before(:each) do
      sign_in FactoryBot.create(:admin)
    end
  end
end
