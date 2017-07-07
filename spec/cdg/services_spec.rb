require "spec_helper"

RSpec.describe CDG::Services do

  it "has a version number" do
    expect(CDG::Services::VERSION).not_to be nil
  end

  describe "#get_ios_version" do

    it "should return nil if invalid iOS app id is given" do
      expect(CDG::Services.get_ios_version(app_id: 123)).to eq(nil)
    end

    it "should return the version number in String if a valid iOS app id is given" do
      app_id = "284882215" # facebook app id on App Store
      app_version = CDG::Services.get_ios_version(app_id: app_id)
      expect(app_version).not_to eq(nil)
    end

  end

  describe "#get_android_version" do

    it "should return nil if invalid android app id is given" do
      expect(CDG::Services.get_android_version(app_id: 123)).to eq(nil)
    end

    it "should return the version number in String if a valid android app id is given" do
      app_id = "com.facebook.katana" # facebook app id on Play Store
      app_version = CDG::Services.get_android_version(app_id: app_id)
      expect(app_version).not_to eq(nil)
    end

  end

  describe "#ping_slack!" do

    before :each do
      ENV["SLACK_URL"] = "https://hooks.slack.com/services/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" # slack ping privately to Vic-L in codigogroup
    end

    it "should throw error for invalid webhook" do
      ENV["SLACK_URL"] = "invalid_url"

      expect{CDG::Services.ping_slack!(
        message: "test",
        channel: "test",
        username: "test",
      )}.to raise_error(Errno::ECONNREFUSED, "Failed to open TCP connection to :443 (Connection refused - connect(2) for nil port 443)")
    end

    it "should throw error for missing message param" do
      expect{CDG::Services.ping_slack!}.to raise_error(ArgumentError, "missing keyword: message")
    end

    it "should pass for missing channel/username params" do
      expect{CDG::Services.ping_slack!(
        message: "test",
      )}.not_to raise_error
    end

  end

end
