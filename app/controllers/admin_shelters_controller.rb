class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_alpha
    @pending_apps = Shelter.pending_apps
  end

end
