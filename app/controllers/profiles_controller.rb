class ProfilesController < ApplicationController
  before_filter :set_profile

  def show
  end

  def update
    @user.assign_attributes(user_params)

    if @user.save
      redirect_to :profile, notice: "Profile saved."
    else
      flash.now[:alert] = "Problem saving the profile."
      render :show
    end
  end

  private

  def set_profile
    @user = current_user
  end

  def user_params
    params.require(:user).permit({demographics_attributes: [:id, :key, :value]})
  end
end
