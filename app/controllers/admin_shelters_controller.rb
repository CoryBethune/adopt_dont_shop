class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @applications_with_pending = Application.pending_apps
  end
end
