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
      ENV["SLACK_URL"] = "https://hooks.slack.com/services/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" # slack ping to channel meant for testing in codigogroup
    end

    describe "should fail" do

      it "for invalid webhook" do
        ENV["SLACK_URL"] = "invalid_url"

        expect{CDG::Services.ping_slack!(
          text: "test",
          channel: "test",
          username: "test",
          )}.to raise_error(Errno::ECONNREFUSED, "Failed to open TCP connection to :443 (Connection refused - connect(2) for nil port 443)")
      end

      it "for fields param which is not an array" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          fields: "test",
          )}.to raise_error(ArgumentError, "wrong argument type for \"fields\"\; should be an array")
      end

      it "for missing text param" do
        expect{CDG::Services.ping_slack!}.to raise_error(ArgumentError, "missing keyword: text")
      end

      it "for invalid channel" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          channel: "#invalid-channel",
          username: "test",
          )}.to raise_error(ArgumentError, "slack channel is not found")
      end

    end


    describe "should pass" do

      it "for invalid fields params" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          fields: [
            codigo: "codigo"
          ]
          )}.not_to raise_error
      end

      it "for invalid color params" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          color: "codigo",
          )}.not_to raise_error

        expect{CDG::Services.ping_slack!(
          text: "test",
          color: ["af3131"],
          )}.not_to raise_error
      end

      it "if all the params are passed" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          channel: "#pings-tests",
          username: "test",
          color: ["good", "warning", "danger", "#af3131", "af3131"].sample,
          title: "test title",
          title_link: "https://www.codigo.co/",
          pretext: "test pretext",
          fields: [
            {
              title: "field 1 title",
              value: "field 1 value",
              short: true,
            },
            {
              title: "field 2 title",
              value: "field 2 value",
              short: true,
            },
            {
              title: "field 3 title",
              value: "This field 3 value is super loooooo oooooooooooooo ooooooooooooooo oooooooooooooong",
              short: false,
            },
          ]
          )}.not_to raise_error
      end

      it "for missing params other than text" do
        expect{CDG::Services.ping_slack!(
          text: "test",
          )}.not_to raise_error
      end

    end

  end

end
