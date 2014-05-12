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

  it 'routes /announcements/:id to announcements#show for id' do
    announcement = create(:announcement)
    expect(get: "/announcements/#{announcement.id}").to route_to(
      controller: 'announcements',
      action: 'show',
      id: "#{announcement.id}"
    )
  end
end
