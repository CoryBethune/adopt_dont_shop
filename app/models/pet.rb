class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pet
  has_many :applications, through: :application_pet
  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def app_approved?
    application_pet.where(application_id: @application.id).first.approved
  end

  def app_rejected?
    application_pet.where(application_id: @application.id).first.rejected
  end
end
