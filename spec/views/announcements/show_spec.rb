require 'spec_helper'

describe 'announcements/show' do
  let(:announcement) { create(:announcement_with_user) }

  it 'displays the user name' do
    assign(:announcement, announcement)
    render
    expect(rendered).to include(announcement.user.name)
  end

  it "displays the announcement's title" do
    assign(:announcement, announcement)
    render
    expect(rendered).to include(announcement.title)
  end

  it 'displays the announcement location' do
    assign(:announcement, announcement)
    render
    expect(rendered).to include(announcement.lat.to_s)
    expect(rendered).to include(announcement.lng.to_s)
  end
end
