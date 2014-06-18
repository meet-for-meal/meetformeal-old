require 'spec_helper'

describe 'routing to users' do
  let(:user) { create(:user) }

  it 'routes /users/:id to users#show for id' do
    expect(get: "/users/#{user.id}").to route_to(
      controller: 'users',
      action: 'show',
      id: "#{user.id}"
    )
  end
end
