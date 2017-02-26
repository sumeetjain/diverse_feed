class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    @profile.assign_attributes(profile_params)

    if @profile.save
      redirect_to :profile, notice: "Profile saved."
    else
      flash.now[:alert] = "Problem saving the profile."
      render :show
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:race, :income)
  end
end
