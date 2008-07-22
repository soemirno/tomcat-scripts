require File.join(File.dirname(__FILE__), '../lib/tomcat')

describe Tomcat, "with correct environment" do

  before(:each) do
    @pid_fixture = File.join(File.dirname(__FILE__), 'fixtures/tomcat.pid')
    ENV["CATALINA_PID"] = @pid_fixture
    ENV["CATALINA_HOME"] = "some/other/path/name"
    @tomcat = Tomcat.new      
  end
  
  it "should be initialized" do
    @tomcat.should_not be_nil
  end

  it "should have a pid file" do
    @tomcat.pid_file.should == @pid_fixture
  end

  it "should have a home folder" do
    @tomcat.home.should == "some/other/path/name"
  end

  it "should be valid" do
    @tomcat.should be_valid
  end
  
  it "should have pid number" do
    @tomcat.pid.should == 1234
  end

  it "should not be running" do
    @tomcat.should_not be_running
  end

end

describe Tomcat, "with CATALINA_PID not set" do

  before(:each) do
    ENV["CATALINA_PID"] = nil
    ENV["CATALINA_HOME"] = "some/other/path/name"
    @tomcat = Tomcat.new      
  end

  it "should be invalid" do
    @tomcat.should_not be_valid
  end

  it "should have meaningfull error message" do
    @tomcat.valid?
    @tomcat.errors[0].should == "CATALINA_PID environment variable not set."
  end

end

describe Tomcat, "with CATALINA_HOME not set" do

  before(:each) do
    ENV["CATALINA_PID"] = "some/other/path/name"
    ENV["CATALINA_HOME"] = nil
    @tomcat = Tomcat.new      
  end

  it "should be invalid" do
    @tomcat.should_not be_valid
  end

  it "should have meaningfull error message" do
    @tomcat.valid?
    @tomcat.errors[0].should == "CATALINA_HOME environment variable not set."
  end

end