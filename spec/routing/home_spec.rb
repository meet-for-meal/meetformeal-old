require 'spec_helper'

describe 'routing to home' do
  it 'routes / to home#index' do
    expect(get: '/').to route_to(
      controller: 'home',
      action: 'index'
    )
  end

  it 'routes /home to home#main' do
    expect(get: '/home').to route_to(
      controller: 'home',
      action: 'main'
    )
  end
end
