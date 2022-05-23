require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:application_pet) }
    it { should have_many(:applications).through(:application_pet) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application1 = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    @application2 = Application.create!(name: 'Jamie James', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    @ap1 = ApplicationPet.create!(application_id: @application1.id, pet_id: @pet_1.id)
    @ap2 = ApplicationPet.create!(application_id: @application1.id, pet_id: @pet_3.id)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search('Claw')).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe '.app_approved?' do
      it 'checks the approved value of the pet on a specific application' do
        expect(@pet_1.app_approved?(@application1)).to eq(false)
      end
    end

    describe '.app_rejected?' do
      it 'checks the approved value of the pet on a specific application' do
        expect(@pet_1.app_rejected?(@application1)).to eq(false)
      end
    end
  end
end
