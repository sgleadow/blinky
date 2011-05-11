require 'httparty'
require 'nokogiri'

module Blinky
  module JenkingsCiServer
    def watch_jenkins_server
      
      while (true)
        server_location = ENV['BLINKY_CI_SERVER'] || "localhost"
        server_port = ENV['BLINK_CI_PORT'] || "8080"
        server_path = ENV['CI_SERVER_PATH'] || ""
        ci_server = "http://#{server_location}:#{server_port}/#{server_path}cc.xml"
        
        r = HTTParty.get "http://ci-mac.local:8080/cc.xml"
        xml = Nokogiri::XML(r.body)
        proj = xml.xpath("//Project[@name='playup-live-ios']")
      
        puts proj
       
        if (proj.attribute('activity').to_str == "Sleeping")
          failure! unless proj.attribute('lastBuildStatus').to_str == "Success"
        else
          building!
        end
        
        sleep(1)
      end
      
    end
  end
end