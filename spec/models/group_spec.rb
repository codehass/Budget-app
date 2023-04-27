require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    user = User.create(id: 1, name: 'hassan', email: 'hassan@gmail.com', password: '123456', confirmed_at: Time.now)
    Group.new(name: 'Food', icon: 'url', user_id: user.id)
  end
  before { subject.save }

  it 'Should be valid ' do
    expect(subject).to be_valid
  end

  it 'Name should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Icon should not be nil' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end
end