require 'spec_helper'

describe 'announcements/show' do
  let(:announcement) { create(:announcement) }

  it 'displays the announcement location' do
    assign(:announcement, announcement)
    render
    expect(rendered).to include(announcement.longitude.to_s)
    expect(rendered).to include(announcement.latitude.to_s)
  end
end
