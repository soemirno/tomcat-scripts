#!/usr/bin/ruby
class Tomcat

  def initialize(pidfile)
    @pidfile=pidfile
  end
  
  def running?
    begin
      Process.getpgid(pid)!= -1
    rescue Errno::ESRCH, Errno::ENOENT
      false
    end
  end

  def pid
    File.open(@pidfile) do |f|
      f.gets.to_i
    end
  end
  
  def start
    puts "Starting tomcat"
    `./startup.sh`
  end

end

@pidfile=ENV["CATALINA_PID"]
if @pidfile.nil? 
  puts "CATALINA_PID environment variable not set."
  exit
end

tomcat = Tomcat.new(@pidfile)
loop do
  puts "checking"
  tomcat.start unless tomcat.running?
  sleep(30)
end
