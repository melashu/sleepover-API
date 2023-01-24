require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe 'Validations' do
    it { should have_one_attached(:image) }
  end

  describe 'Associtions' do
    it { should have_many(:rooms) }
    it { should belong_to(:user) }
  end
end
