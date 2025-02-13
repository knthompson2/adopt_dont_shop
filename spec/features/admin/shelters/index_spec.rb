require 'rails_helper'

RSpec.describe 'index page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end


  it 'should alphabetize the shelters in descending order by name' do
    visit "/admin/shelters"
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
  end

  it 'has a section for Shelters with pending applications' do
    application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "Dogs", status: "In Progress")
    pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
    PetApplication.create!(application: application_1, pet: pet_1)
    visit "/admin/shelters"
    within("#shelter-#{@shelter_1.id}")do
      expect(page).to have_content(@shelter_1.name)
    end
  end
end
