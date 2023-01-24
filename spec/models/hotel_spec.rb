require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe 'Validations' do
    it { should have_one_attached(:image)}
  end

end
