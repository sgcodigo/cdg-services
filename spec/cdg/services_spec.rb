require "spec_helper"

RSpec.describe CDG::Services do

  it "has a version number" do
    expect(CDG::Services::VERSION).not_to be nil
  end

  describe "#GetIOSVersion" do

    it "should return nil if invalid iOS app id is given" do
      expect(CDG::Services.GetIOSVersion(app_id: 123)).to eq(nil)
    end

    it "should return the version number in String if a valid iOS app id is given" do
      app_id = "284882215" # facebook app id on App Store
      app_version = CDG::Services.GetIOSVersion(app_id: app_id)
      expect(app_version).not_to eq(nil)
    end

  end

  describe "#GetAndroidVersion" do

    it "should return nil if invalid android app id is given" do
      expect(CDG::Services.GetAndroidVersion(app_id: 123)).to eq(nil)
    end

    it "should return the version number in String if a valid android app id is given" do
      app_id = "com.facebook.katana" # facebook app id on Play Store
      app_version = CDG::Services.GetAndroidVersion(app_id: app_id)
      expect(app_version).not_to eq(nil)
    end

  end

end
