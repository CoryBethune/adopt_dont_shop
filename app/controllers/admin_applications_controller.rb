class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    if params[:rejected].present?
      pet.application_pet.update(params[:rejected])
    else
      pet = Application.find(params[:id]).pets.find(params[:pet_id])
      pet.update(adoptable: false)
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

end
