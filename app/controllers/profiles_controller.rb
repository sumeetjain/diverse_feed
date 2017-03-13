class ProfilesController < ApplicationController
  before_filter :set_profile

  def show
    # TODO: Move this into the model.
    @user.races.build if @user.races.empty?
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
    demographic_attrs = [:id, :key, :value, :_destroy]

    params.require(:user).permit({
      races_attributes: demographic_attrs,
      income_attributes: demographic_attrs
    })
  end
end
