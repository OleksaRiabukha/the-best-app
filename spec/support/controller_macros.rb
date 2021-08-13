module ControllerMacros
  def login_user
    before do
      create(:user)
      sign_in create(:user, :simple)
    end
  end

  def login_admin
    before do
      sign_in create(:user, :admin)
    end
  end
end
