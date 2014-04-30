require 'spec_helper'

describe User do

  it 'creates a new instance given a valid attribute' do
    create :user
  end

  describe 'email' do
    it 'is required' do
      no_email_user = build :user, email: ''
      expect(no_email_user).not_to be_valid
    end

    it 'is accepted when valid' do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = build :user, email: address
        expect(valid_email_user).to be_valid
      end
    end

    it 'is rejected when not valid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        invalid_email_user = build :user, email: address
        expect(invalid_email_user).not_to be_valid
      end
    end

    it 'is rejected when duplicated' do
      first_user = create :user
      user_with_duplicate_email = build :user, email: first_user.email
      expect(user_with_duplicate_email).not_to be_valid
    end

    it 'is rejected when identical up to case' do
      user = create :user
      user_with_duplicate_email = build :user, email: user.email.upcase
      expect(user_with_duplicate_email).not_to be_valid
    end
  end

  describe 'passwords' do
    before(:each) do
      @user = build :user
    end

    it 'has a password attribute' do
      expect(@user).to respond_to(:password)
    end

    it 'has a password confirmation attribute' do
      expect(@user).to respond_to(:password_confirmation)
    end
  end

  describe 'password validations' do
    it 'requires a password' do
      expect(build(:user, password: '', password_confirmation: ''))
        .not_to be_valid
    end

    it 'requires a matching password confirmation' do
      expect(build(:user, password_confirmation: 'invalid')).not_to be_valid
    end

    it 'rejects short passwords' do
      short = 'a' * 5
      expect(build(:user, password: short, password_confirmation: short))
        .not_to be_valid
    end
  end

  describe 'password encryption' do
    before(:each) do
      @user = create :user
    end

    it 'has an encrypted password attribute' do
      expect(@user).to respond_to(:encrypted_password)
    end

    it 'sets the encrypted password attribute' do
      expect(@user.encrypted_password).not_to be_blank
    end
  end

  describe 'fields' do
    it_behaves_like 'a model with the following database columns',
                    [:name, :string],
                    [:email, :string],
                    [:encrypted_password, :string],
                    [:reset_password_token, :string],
                    [:remember_created_at, :datetime],
                    [:sign_in_count, :integer],
                    [:last_sign_in_at, :datetime],
                    [:current_sign_in_ip, :string],
                    [:last_sign_in_ip, :string]

    it_behaves_like 'a model with timestampable columns'
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

end

