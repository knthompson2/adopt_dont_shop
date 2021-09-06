require "rails_helper"

RSpec.describe 'show page' do
  before :each do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
    @application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "Dogs", status: "In Progress")
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Labradoodle", name: "Leo")
    PetApplication.create!(application: @application_1, pet: @pet_1)
    PetApplication.create!(application: @application_1, pet: @pet_2)
  end

  it 'lets the admin approve pets and then indicates pet has been approved'do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Approve #{@pet_1.name}")
    expect(page).to have_button("Approve #{@pet_2.name}")
    click_on "Approve #{@pet_1.name}"
    
    expect(page).to have_no_button("Adopt #{@pet_1.name}")
    expect(page).to have_content("#{@pet_1.name} has been approved")
  end

  it 'lets the admin reject pets adoption and then indicates pet has been rejected'do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_button("Reject #{@pet_1.name}")
    expect(page).to have_button("Reject #{@pet_2.name}")
    click_on "Reject #{@pet_1.name}"
    save_and_open_page
    expect(page).to have_no_button("Adopt #{@pet_1.name}")
    expect(page).to have_content("#{@pet_1.name} has been rejected")
  end
end
