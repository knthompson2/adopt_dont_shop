require 'rails_helper'

RSpec.describe 'show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
    @application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "Dogs", status: "In Progress")
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Labradoodle", name: "Leo")

  end

  it 'displays all attributes of the application' do
    PetApplication.create!(application: @application_1, pet: @pet_1)
    PetApplication.create!(application: @application_1, pet: @pet_2)
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
  end

  it 'has a section to search for pet to add to the application' do
    visit "/applications/#{@application_1.id}"
    # save_and_open_page
    expect(page).to have_content("Add a Pet to this Application")
    fill_in :search, with: "Lucy"
    click_on "Search"
    expect(page).to have_content(@pet_1.name)

  end
  it 'has a section to add a pet to the application' do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content("Add a Pet to this Application")
    fill_in :search, with: "Lucy"
    click_on "Search"
    click_on "Adopt this Pet"

    within("#pet-#{@pet_1.id}")do
      expect(page).to have_content(@pet_1.name)
    end
  end
  #adds description, submt app, checks case insensitivty, parial matches, no submit button with zero pets
  it 'has a section to input description and submit app' do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "LuCy"

    click_on "Search"
    expect(page).to have_content("Lucy")
    fill_in :search, with: "Le"
    click_on "Search"
    save_and_open_page
    expect(page).to have_content("Leo")

    expect(page).not_to have_content("Submit")

    click_on "Adopt this Pet"

    fill_in :description, with: "I just really love dogs."
    click_on "Submit"
    # save_and_open_page
    expect(page).to have_content("Pending")
    expect(page).to have_content("I just really love dogs.")
  end


end
