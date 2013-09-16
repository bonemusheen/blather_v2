ENV["RACK_ENV"] = "test"
require_relative "../app.rb"
require "spec_helper.rb"

describe "app" do

  subject { page }

  let(:base_title) { "Blather!" }

  describe "home page" do
    it "should load the home page" do
      get "/"
      last_response.should be_ok
    end

    describe "should render" do
      before { visit "http://0.0.0.0:4567/" }

      it { should have_content("Blather!") }
      it { should have_title(base_title) }
      it { should_not have_title("|") }
    end
  end

  describe "signup page" do
    before { visit "http://0.0.0.0:4567/signup" }

    it { should have_content("Sign up") }
    it { should have_title("#{base_title} | Sign Up") }

    describe "signup" do
      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end

        describe "after submission" do
          before { click_button submit }

          it { should have_title("Sign Up") }
          it { should have_content("error") }
        end
      end

      describe "with valid information" do
        before do
          fill_in "username",     with: "Example User"
          fill_in "email",        with: "user@example.com"
          fill_in "password",     with: "foobar"
          fill_in "confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe "after saving the user" do
          before { click_button submit }
          let(:user) { User.find(email: 'user@example.com') }

          it { should have_title(user.name) }
          it { should have_selector("div.alert.alert-success", text: "Welcome") }
        end
      end
    end
  end
end