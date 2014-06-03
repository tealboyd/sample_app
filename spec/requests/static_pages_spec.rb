require 'spec_helper'

describe "StaticPages" do
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    # Content
    it { should have_content('Sample App') }
    # Title
    it { should have_title(full_title('')) }
    it { should_not have_title(' | Home') }

    describe "for signed-in users" do
      let (:user) {FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", item.content)
        end
      end
    end
  end
  
  describe "Help page" do
    before { visit help_path }
    # Content
    it { should have_content('Help') }
    #Title
    it { should have_title(full_title('Help')) }
    #it "should have the content 'Help'" do
      #visit help_path
      #expect(page).to have_content('Help')
      #end
    # Title
    #it "should have the right title 'Help'" do
      #visit help_path
      #expect(page).to have_title("RoR Tutorial Sample App | Help")
      #end                
  end
  
  describe "About page" do
    before { visit about_path }
    #Content
    it { should have_content('About Us') }
    #Title
    it { should have_title(full_title('About Us')) }
    #it "should have the content 'About Us'" do
      #visit about_path
      #expect(page).to have_content('About Us')
      #end
    # Title
    #it "should have the right title" do
      #visit about_path
      #expect(page).to have_title('RoR Tutorial Sample App | About Us')
      #end              
  end
  
  describe "Contact page" do
    before { visit contact_path }
    #Content
    it { should have_content('Contact') }
    #Title
    it { should have_title(full_title('Contact')) }
    #it "should have the content 'Contact'" do
      #visit contact_path
      #expect(page).to have_content('Contact')
      #end
    # Title
    #it "should have the right title" do
      #visit contact_path
      #expect(page).to have_title('RoR Tutorial Sample App | Contact')
      #end              
  end
  
  
end
