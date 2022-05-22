require 'rails_helper'

RSpec.describe 'admin application show page' do
  it "lets the admin approve pets on an application" do
    shelter1 = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    shelter2 = Shelter.create!(foster_program: true, name: 'Fally', city: 'Denver', rank: 21)
    shelter3 = Shelter.create!(foster_program: true, name: 'Eally', city: 'Denver', rank: 21)
    shelter4 = Shelter.create!(foster_program: true, name: 'Dally', city: 'Denver', rank: 21)

    pet1 = shelter1.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Dante')
    pet2 = shelter2.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spot')
    pet3 = shelter3.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spike')
    pet4 = shelter4.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan')

    application1 = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    application2 = Application.create!(name: 'Jamie James', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    ap1 = ApplicationPet.create!(application_id: application1.id, pet_id: pet1.id)
    ap2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet3.id)

    visit "/admin/applications/#{application1.id}"

    click_button('Approve Pet')

    expect(current_path).to eq("/admin/applications/#{application1.id}")
    within('div#petApproval') do
      save_and_open_page
      expect(page).to have_content('Approved')

      expect(page).to_not have_content('Approve Pet')
    end
  end


end
