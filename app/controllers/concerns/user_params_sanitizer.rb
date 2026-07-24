# frozen_string_literal: true

class ResgisterParamsSanitizer
  def initialize(params)
    @params = params
  end

  def sign_up_params
    @params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end