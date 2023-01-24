require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:prices) }
    it { should validate_presence_of(:number_of_bed) }
    it { should validate_presence_of(:photo) }
  end

  describe 'associatons' do
    it { should have_many(:reservations) }
    it { should have_many(:users).through(:reservations) }
    it { should belong_to(:hotel) }
  end
end
