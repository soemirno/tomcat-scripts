class Tomcat

  attr_reader :pid_file, :errors, :home

  def initialize()
    @pid_file=ENV["CATALINA_PID"]
    @home=ENV["CATALINA_HOME"]    
    @errors=[]
  end

  def running?
    begin
      Process.getpgid(pid)!= -1
    rescue Errno::ESRCH, Errno::ENOENT
      false
    end
  end

  def pid
    File.open(@pid_file) do |f|
      f.gets.to_i
    end
  end

  def start
    puts "Starting tomcat"
    timestamp = Time.now.strftime("%Y%M%d%H%M%S")
    `mv #{@home}/logs/catalina.out #{@home}/logs/catalina_#{timestamp}.out`
    `cd #{@home}/bin;./catalina.sh start`
  end

  def valid?
    if @valid.nil?
      @valid = true
      if @pid_file.nil?
        @errors << "CATALINA_PID environment variable not set."
        @valid = false
      end
      if @home.nil?
        @errors << "CATALINA_HOME environment variable not set."
        @valid = false
      end
    end
    @valid
  end

end