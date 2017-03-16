class ProfilesController < ApplicationController
  before_filter :set_profile

  def show
    # TODO: Move this into the model.
    @user.races.build if @user.races.empty?
    @user.ethnicities.build if @user.ethnicities.empty?
    @user.genders.build if @user.genders.empty?
    @user.sexual_orientations.build if @user.sexual_orientations.empty?
    @user.religions.build if @user.religions.empty?
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
      income_attributes: demographic_attrs,
      year_of_birth_attributes: demographic_attrs,
      sexual_orientations_attributes: demographic_attrs,
      races_attributes: demographic_attrs,
      ethnicities_attributes: demographic_attrs,
      genders_attributes: demographic_attrs,
      religions_attributes: demographic_attrs
    })
  end
end
