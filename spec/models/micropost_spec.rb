require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }
  
  subject{ @micropost }
  
  # test that a micropost object responds to the required attributes
  # works for methods too. The respond_to methods implicitly use the 
  # Ruby method respond_to?, which accepts a symbol and returns true 
  # if the object responds to the given method or attribute and false 
  # otherwise:
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  
  # verify that the model's validations all return true
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
  
end
