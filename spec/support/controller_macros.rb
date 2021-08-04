module ControllerMacros
  def login_user
    before do
      sign_in FactoryBot.create(:admin, :simple_user)
    end
  end

  def login_admin
    before do
      sign_in FactoryBot.create(:admin)
    end
  end
end
