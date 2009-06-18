module WatirOnRails
  # Defaults for Watir Test server
  OPTIONS = { :server => "localhost", :port => 3000 }

  module ExposeOptions
    def server(server)
      OPTIONS[:server] = server
    end
          
    def port(port)
      OPTIONS[:port] = port
    end    
  end

  def self.included(test)
    test.use_transactional_fixtures = false
    class << test
      include ExposeOptions
    end
  end

  class Util
    def self.handle_url(url)
      return url unless url.match(/^\//)
      "http://#{OPTIONS[:server]}:#{OPTIONS[:port]}#{url}"
    end    
  end

  def open_browser(starting_url = nil)
    browser_class = load_browser_class
    
    @last_browser =
      if starting_url
        browser_class.start(Util.handle_url(starting_url))
      else
        browser_class.new
      end

    class << @last_browser
      def goto(url)
        super(Util.handle_url(url))
      end
    end
    
    yield @last_browser if block_given?
    @last_browser
  end

  private

  # Hooking into assert_select, see ActionController::Assertions::SelectorAssertions
  def response_from_page_or_rjs
    html_document.root
  end

  # Overriding for assert_tag and assert_select, see ActionController::TestProcess
  def html_document
    init_response
    HTML::Document.new(@last_browser.html)
  end

  # Necessary for assert_tag's error message
  def init_response
    @response = Object.new
    class << @response
      attr_accessor :body
    end
    @response.body = @last_browser.html
  end

  def load_browser_class
    @browser_class ||=
    case RUBY_PLATFORM
    when /darwin/i
      # require_gem "safariwatir"
      require "safariwatir"
      Watir::Safari
    when /mswin/i
      # require_gem "watir"
      require "watir"
      Watir::IE
    else
      raise "Watir is only supported on Windows and Mac OS X."
    end
  end
end