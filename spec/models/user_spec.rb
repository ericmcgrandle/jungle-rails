require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Initial Test' do
    # Create Category and Product
    let(:create_user) { User.create(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc123", password_confirmation: "abc123") }
    
    it "saves successfully" do
      expect do
        create_user.save
      end.to change{ User.count }.by(1)
    end
  end


  describe 'Passwords' do
    it "is not valid for mismatched passwords" do
      create_user = User.create(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc123", password_confirmation: "123123")

      expect(create_user).not_to be_valid
      expect(create_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "is not valid for missing confirmation password" do
      create_user = User.create(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc123")

      expect(create_user).not_to be_valid
    end
    it "is not valid for passwords that are shorter than 6 characters" do
      create_user = User.create(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc", password_confirmation: "abc")

      expect(create_user).not_to be_valid
    end
    it "is valid for matched passwords, 6 characters long" do
      create_user = User.create(first_name: "First", last_name: "Last", email: "test@example.com", password: "abc123", password_confirmation: "abc123")
      
      expect(create_user).to be_valid
    end
  end

  describe 'Emails' do
    it "checks for uniqueness" do
      email = 'unique@example.com'
      create_user = User.create(first_name: "First", last_name: "First", email: email, password: "abc123", password_confirmation: "abc123")        
      create_second_user = User.create(first_name: "Second", last_name: "Second", email: email, password: "123123", password_confirmation: "123123")

      expect(create_second_user).not_to be_valid
    end
    it "trims whitespace" do
      email = '  test@example.com   '
      create_user = User.create(first_name: "First", last_name: "First", email: email, password: "abc123", password_confirmation: "abc123")   
      
      expect(create_user[:email]).to eq("test@example.com")
    end
    it "ignores case" do
      email = 'teSt@ExaMplE.com'
      create_user = User.create(first_name: "First", last_name: "First", email: email, password: "abc123", password_confirmation: "abc123")

      # user params
      params_email = 'test@example.com'
      params_password = 'abc123'

      # mock login
      user = User.find_by_lower_email(params_email)
      success = user && user.authenticate(params_password)

      expect(success).to be_truthy       
    end
  end

  describe 'First Name' do
    it "is not valid if name is nil" do
      create_user = User.create(first_name: nil, last_name: "First", email: "test@example.com", password: "abc123", password_confirmation: "abc123")        

      expect(create_user).not_to be_valid
    end
    it "is valid if name exsists" do
      create_user = User.create(first_name: "Something", last_name: "First", email: "test@example.com", password: "abc123", password_confirmation: "abc123")        

      expect(create_user).to be_valid
    end
  end

  describe 'Last Name' do
    it "is not valid if name is nil" do
      create_user = User.create(first_name: "First", last_name: nil, email: "test@example.com", password: "abc123", password_confirmation: "abc123")        

      expect(create_user).not_to be_valid
    end
    it "is valid if name exsists" do
      create_user = User.create(first_name: "First", last_name: "Something", email: "test@example.com", password: "abc123", password_confirmation: "abc123")        

      expect(create_user).to be_valid
    end
  end

  describe 'authenticate' do
    it 'return falsey if user does not exists or password do not matches' do
      create_user = User.create(first_name: "First", last_name: "Something", email: "test@example.com", password: "abc123", password_confirmation: "abc123") 
      
      # user params
      params_email = 'test@example.com'
      params_password = 'abc12345'

      # mock login
      user = User.find_by_lower_email(params_email)
      success = user && user.authenticate(params_password)

      expect(success).to be_falsey
    end
    it 'return truthy if user exists and password matches' do
      create_user = User.create(first_name: "First", last_name: "Something", email: "test@example.com", password: "abc123", password_confirmation: "abc123") 
      
      # user params
      params_email = 'test@example.com'
      params_password = 'abc123'

      # mock login
      user = User.find_by_lower_email(params_email)
      success = user && user.authenticate(params_password)

      expect(success).to be_truthy 
    end

  end

end
