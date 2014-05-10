require 'spec_helper'

describe 'routing to announcements' do
  it 'routes /announcements/new to annoucements#new' do
    expect(get: '/announcements/new').to route_to(
      controller: 'announcements',
      action: 'new'
    )
  end
end
