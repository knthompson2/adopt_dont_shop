class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    pet_application = PetApplication.find_application(params[:id], params[:pet_id]).first


    pet_application.update(status: params[:status])

    redirect_to "/admin/applications/#{params[:id]}"
  end
end
