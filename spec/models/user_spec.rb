require 'spec_helper'

describe User do

  it 'should create a new instance given a valid attribute' do
    FactoryGirl.create :user
  end

  describe 'email' do
    it 'should be required' do
      no_email_user = FactoryGirl.build :user, email: ''
      no_email_user.should_not be_valid
    end

    it 'should be accepted when valid' do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = FactoryGirl.build :user, email: address
        valid_email_user.should be_valid
      end
    end

    it 'should be rejected when not valid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = FactoryGirl.build :user, email: address
        invalid_email_user.should_not be_valid
      end
    end

    it 'should be rejected when duplicated' do
      first_user = FactoryGirl.create :user
      user_with_duplicate_email = FactoryGirl.build :user, email: first_user.email
      user_with_duplicate_email.should_not be_valid
    end

    it 'should be rejected when identical up to case' do
      user = FactoryGirl.create :user
      user_with_duplicate_email = FactoryGirl.build :user, email: user.email.upcase
      user_with_duplicate_email.should_not be_valid
    end
  end

  describe 'passwords' do
    before(:each) do
      @user = FactoryGirl.build :user
    end

    it 'should have a password attribute' do
      @user.should respond_to(:password)
    end

    it 'should have a password confirmation attribute' do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe 'password validations' do
    it 'should require a password' do
      FactoryGirl.build(:user, password: '', password_confirmation: '')
        .should_not be_valid
    end

    it 'should require a matching password confirmation' do
      FactoryGirl.build(:user, password_confirmation: 'invalid').should_not be_valid
    end

    it 'should reject short passwords' do
      short = 'a' * 5
      FactoryGirl.build(:user, password: short, password_confirmation: short)
        .should_not be_valid
    end
  end

  describe 'password encryption' do
    before(:each) do
      @user = FactoryGirl.create :user
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end

    it 'should set the encrypted password attribute' do
      @user.encrypted_password.should_not be_blank
    end
  end

  describe 'fields' do
    [
      [:name, :string],
      [:email, :string],
      [:encrypted_password, :string],
      [:reset_password_token, :string],
      [:remember_created_at, :datetime],
      [:sign_in_count, :integer],
      [:last_sign_in_at, :datetime],
      [:current_sign_in_ip, :string],
      [:last_sign_in_ip, :string]
    ].each do |column|
      it do
        name, type, options = *column

        have_this_column = have_db_column(name)
        have_this_column.of_type(type) if type.present?
        have_this_column.with_options(options) if options.present? and options.is_a?(Hash)

        should have_this_column
      end
    end

    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

end

