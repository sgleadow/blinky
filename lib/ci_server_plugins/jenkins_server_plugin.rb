require 'httparty'
require 'nokogiri'

module Blinky
  module JenkingsCiServer
    
    def create_ci_server_location
      server_location = ENV['BLINKY_CI_SERVER'] || "localhost"
      server_port = ENV['BLINK_CI_PORT'] || "8080"
      server_path = ENV['CI_SERVER_PATH'] || ""
      server_path = server_path + "/" unless server_path.end_with? "/"
      "http://#{server_location}:#{server_port}/#{server_path}cc.xml"
    end
    
    def watch_jenkins_server
      ci_server = create_ci_server_location
      
      while (true)
        
        r = HTTParty.get ci_server
        
        if (r.code >= 400)
          warning!
        else
          xml = Nokogiri::XML(r.body)
          proj = xml.xpath("//Project[@name='playup-live-ios']")
      
          puts proj
       
          if (proj.attribute('activity').to_str == "Sleeping")
            if (proj.attribute('lastBuildStatus').to_str == "Success")
              success!
            else
              failure!
            end
          else
            building!
          end
        end
        
        sleep(1)
      end
      
    end
  end
end