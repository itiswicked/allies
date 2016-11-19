class OrganizationsController < ApplicationController

  def create
    @organization = Organization.new(organization_params)
    @user = current_user
    if @organization.save
      flash[:notice] = "Welcome to Allies!"
    else
      flash[:error] = @organization.errors.full_messages.join('. ')
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization_params).permit(
      :name,
      :description,
      :street_address,
      :state,
      :zip
    )
  end
end
