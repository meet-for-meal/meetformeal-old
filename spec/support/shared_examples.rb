shared_examples_for 'a model with the following database columns' do |*columns|
  columns.each do |column|
    it do
      name, type, options = *column

      have_this_column = have_db_column(name)
      have_this_column.of_type(type) if type.present?
      have_this_column.with_options(options) if options.present? and options.is_a?(Hash)

      should have_this_column
    end
  end
end

shared_examples_for 'a model with timestampable columns' do
  it { should have_db_column(:created_at).of_type(:datetime) }
  it { should have_db_column(:updated_at).of_type(:datetime) }
end
