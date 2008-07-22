#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '../lib/tomcat')

tomcat = Tomcat.new()
if tomcat.valid?
  loop do
    puts "check if tomcat is running"
    tomcat.start unless tomcat.running?
    sleep(30)
  end
else
  tomcat.errors.each {|e| puts e}
end
