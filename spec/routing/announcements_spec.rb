require 'spec_helper'

describe 'routing to announcements' do
  it 'routes /announcements/new to annoucements#new' do
    expect(get: '/announcements/new').to route_to(
      controller: 'announcements',
      action: 'new'
    )
  end

  it 'routes POST /announcements to annoucements#create' do
    expect(post: '/announcements').to route_to(
      controller: 'announcements',
      action: 'create'
    )
  end

  it 'routes /users/:user_id/announcements/:id to announcements#show for id 1' do
    expect(get: '/users/1/announcements/1').to route_to(
      controller: 'announcements',
      action: 'show',
      user_id: '1',
      id: '1'
    )
  end

  it 'routes /announcements/near to announcements#near' do
    expect(get: '/announcements/near').to route_to(
      controller: 'announcements',
      action: 'near'
    )
  end
end
