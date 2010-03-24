require 'selenium-webdriver'

class Capybara::Driver::SeleniumRemote < Capybara::Driver::Selenium
  attr_reader :app, :rack_server

  def self.driver
    unless @driver
      @driver = Selenium::WebDriver.for :remote, :url => Capybara.remote_url
      at_exit do
        @driver.quit
      end
    end
    @driver
  end

  def initialize(app)
    @app = app
    @rack_server = Capybara::Server.new(@app)
    @rack_server.boot if Capybara.run_server
		Capybara.app_host = 'http://' + Capybara.local_ip + ':' + @rack_server.port.to_s
  end

end
