require 'spec_helper'

describe User do
  
  # create a new user with initialization hash
  before { @user = User.new(name: "Example User", email: "user@example.com",
    password: "foobar", password_confirmation: "foobar") }
  
  # make created user the default subject of the test
  subject { @user }
  
  # test that user.name and user.email are valid constructions
  # add passowrd, password_confirmation, authenticate
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  
  # check for blank password
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
      password: " ", password_confirmation: " " )
    end
    it { should_not be_valid }
  end
  
  # check for password mismatch
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  

  
  # verify that @user is intially valid
  it { should be_valid }
  
  # set user to blank and test 
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  # test the max length of name
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  # set email to blank and test
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  # email format validation - invalid
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com ]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
  # email format validation - valid
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn ]
      addresses.each do |nvalid_address|
        @user.email = nvalid_address
        expect(@user).to be_valid
      end
    end
  end
  # check for duplicate email address
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  # verify authentication and passowrd match and mismatch
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
    
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false}
    end
  end
  
  # test password length
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

end
