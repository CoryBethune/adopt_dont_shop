require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pet) }
    it { should have_many(:pets).through(:application_pet) }
  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should_not validate_presence_of :description }
    it { should validate_presence_of :status }
  end

  describe  'class methods' do
    shelter1 = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    shelter2 = Shelter.create!(foster_program: true, name: 'Fally', city: 'Denver', rank: 21)
    shelter3 = Shelter.create!(foster_program: true, name: 'Eally', city: 'Denver', rank: 21)
    shelter4 = Shelter.create!(foster_program: true, name: 'Dally', city: 'Denver', rank: 21)

    pet1 = shelter1.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Dante')
    pet2 = shelter1.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spot')
    pet3 = shelter3.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spike')
    pet4 = shelter4.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan')

    application1 = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    application2 = Application.create!(name: 'Jamie James', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    ap1 = ApplicationPet.create!(application_id: application1.id, pet_id: pet1.id)
    ap2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet2.id)

    describe '#pending_apps' do
      it "gets all of the applications for a specific shelter with a pending status " do
        expect(Application.pending_apps).to eq([application1, application2])
      end
    end
  end
end
