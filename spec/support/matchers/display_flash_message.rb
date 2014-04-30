# Usage:
#
# describe 'A feature' do
# specify { page.should display_flash_message('foo') }
# end
RSpec::Matchers.define :display_flash_message do |text|
  match do
    within 'div.alert' do
      expect(page).to have_content(text)
    end
  end

  description do
    "have the following flash message: '#{text.inspect}'"
  end
end
