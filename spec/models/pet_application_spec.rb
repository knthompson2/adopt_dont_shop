require "rails_helper"

RSpec.describe PetApplication do
  describe "relationships" do
    it { should belong_to :pet}
    it { should belong_to :application}
  end

  describe 'class methods' do
    before :each do
      @shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
      @application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "Dogs", status: "In Progress")
      @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
      @pet_app = PetApplication.create!(application: @application_1, pet: @pet_1)
    end
    it '#find_application' do

      expect(PetApplication.find_application(@application_1.id, @pet_1.id)).to eq([@pet_app])
    end
  end
end
