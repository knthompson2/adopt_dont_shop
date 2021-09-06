class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.find_application(app_id, pet_id)
    where(application_id: app_id, pet_id: pet_id)
  end
end
