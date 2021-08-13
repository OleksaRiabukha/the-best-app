module ControllerMacros
  def login_user
    before do
      create(:admin)
      sign_in create(:admin, :simple_user)
    end
  end

  def login_admin
    before do
      sign_in create(:admin)
    end
  end
end
