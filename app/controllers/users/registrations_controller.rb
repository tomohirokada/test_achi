class Users::RegistrationsController < Devise::RegistrationsController
  def build_resources(hash=nil)
    hash[:uid]=User.create_unique_string
    super
  end
end
