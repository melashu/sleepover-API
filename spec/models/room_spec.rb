require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:prices) }
    it { should validate_presence_of(:number_of_bed) }
    it { should validate_presence_of(:photo) }
  end
end
