require "cdg/services/version"
require "net/http"
require "json"
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
        html = URI.parse("https://play.google.com/store/apps/details?id=#{app_id}&hl=en").read

        /<div[^>]*?>Current Version<\/div><div><span[^>]*?>(?<android_version>.*?)<\/span><\/div>/ =~ html

        android_version
      rescue OpenURI::HTTPError => e
        return nil
      end
    end

    def self.ping_slack!(
      webhook: ENV['SLACK_URL'],
      color: "5bc0de", # default boostrap color for info
      title: nil,
      title_link: nil,
      pretext: nil,
      text: ,
      fields: nil,
      channel: nil,
      username: nil)
      begin
        if fields && !fields.is_a?(Array)
          raise ArgumentError, "wrong argument type for \"fields\"; should be an array"
        end

        uri = URI(webhook)

        resp = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          req = Net::HTTP::Post.new(uri)
          req['Content-Type'] = 'application/json'

          attachment = {}
          attachment[:text] = text
          attachment[:color] = color if color
          attachment[:title] = title if title
          attachment[:title_link] = title_link if title_link
          attachment[:pretext] = pretext if pretext
          attachment[:fields] = fields if fields

          body = { attachments: [attachment] }
          body[:channel] = channel if channel
          body[:username] = username if username
          
          req.body = body.to_json
          resp = http.request(req)

          ## TODO need to find a better way handle response body?
          if resp.is_a?(Net::HTTPNotFound)
            case resp.body
            when "channel_not_found"
              raise ArgumentError, "slack channel is not found"
            else
              # TODO
            end
          end
        end
      rescue => e
        raise e
      end
    end

  end

end