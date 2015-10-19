# For a Rails project, put this in;
# # spec/support/formatters/vim_formatter.rb

class VimFormatter
  RSpec::Core::Formatters.register self, :example_failed

  def initialize(output)
    puts 'initializing'
    @output = output
  end

  def example_failed(notification)
    puts 'example failed'
    @output << format(notification) + "\n"
  end

  private

  def format(notification)
    rtn = "%s: %s" % [notification.example.location, notification.exception.message]
    rtn.gsub("\n", ' ')[0,160]
  end
end
