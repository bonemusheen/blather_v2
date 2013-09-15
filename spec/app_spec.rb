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
  end
end