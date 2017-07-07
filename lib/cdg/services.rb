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

  end

end