class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Application.find(params[:id]).pets.find(params[:pet_id])
    pet.adoptable = false
    binding.pry
    redirect_to "/admin/applications/#{params[:id]}"
  end

end
