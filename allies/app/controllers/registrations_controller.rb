class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    self.resource.organization = Organization.new
    respond_with self.resource
  end

  def create
    super
    @volunteer = Volunteer.new
    @volunteer.user = current_user
    @volunteer.organization = current_user.organization
    @volunteer.save!
  end

  protected

  def sign_up_params
    allow = [:first_name, :last_name, :email, :password, :password_confirmation, :organization, [organization_attributes: [:name, :description, :street_address, :state, :zip]]]
    params.require(resource_name).permit(allow)
  end

  # def after_sign_up_path_for(resource)
  #   #put post paths for org, volunteer here
  # end
end
