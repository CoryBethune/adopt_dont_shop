require 'rails_helper'

RSpec.describe 'application' do
  it 'shows full address of applicant' do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    ap1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    visit "/applications/#{application.id}"

    expect(page).to have_content('Sylvester Tommy')
    expect(page).to have_content('1827 Vincent Ave')
    expect(page).to have_content('Halifax')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('19274')
    expect(page).to have_content('I LOVE pets')
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Suzan')

    click_link('Suzan')

    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it "lets you add a pet to an unsubmitted application" do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 3, breed: 'Poodle', name: 'Spot', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Search", with: "Spot")
    click_button("Search")

    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content("Spot")
    expect(page).to_not have_content("Suzan")
    save_and_open_page
  end


end
