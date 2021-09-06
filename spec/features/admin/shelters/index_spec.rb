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
end
