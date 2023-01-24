require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', email: 'tom00@gmail.com', password: 'tom244', password_digest: 'tom244' ) }
  before { subject.save }
  it 'Name must not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Email must not be blank' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
