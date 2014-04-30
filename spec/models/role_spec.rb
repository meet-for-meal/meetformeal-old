require 'spec_helper'

describe Role do

  let!(:first_user) { create(:admin) }
  let!(:second_user) { create(:user) }
  let!(:third_user) { create(:admin) }

  it 'returns only admin users' do
    users = User.with_role(:admin)
    expect(users).to have(2).items
    expect(users).to include(first_user)
    expect(users).to include(third_user)
    expect(users).not_to include(second_user)
  end

end
