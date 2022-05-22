class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet = Application.find(params[:id]).pets.find(params[:pet_id])
    if params[:rejected].present?
      pet.application_pet.first.update(rejected: true)
    elsif params[:approved].present?
      pet.application_pet.first.update(approved: true)
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end

end
