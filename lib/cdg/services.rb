require "cdg/services/version"
require "net/http"
require "json"
require "pry"
require "nokogiri"
require "open-uri"

module CDG

  module Services

    def self.get_ios_version app_id: # eg 123456789
      resp = JSON.parse Net::HTTP.get(URI("https://itunes.apple.com/lookup?id=#{app_id}"))
      results = resp["results"]

      if results.empty?
        nil
      else
        results[0]["version"]
      end
    end

    def self.get_android_version app_id: # eg sg.codigo.app_name
      begin
        resp = Nokogiri::HTML(open("https://play.google.com/store/apps/details?id=#{ app_id }&hl=en"))
        elements = resp.css("div[class='content'][itemprop='softwareVersion']")

        if elements.empty?
          nil
        else
          elements[0].text.strip
        end
      rescue OpenURI::HTTPError => e
        return nil
      end
    end

    def self.ping_slack! webhook: ENV['SLACK_URL'], message:, channel: nil, username: nil
      begin
        uri = URI(webhook)

        resp = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          req = Net::HTTP::Post.new(uri)
          req['Content-Type'] = 'application/json'

          body = {}
          body[:text] = message
          body[:channel] = channel if channel
          body[:username] = username if username
          # TODO custom icon_emoji?
          
          req.body = body.to_json
          http.request(req)
        end
      rescue => e
        raise e
      end
    end

  end

end