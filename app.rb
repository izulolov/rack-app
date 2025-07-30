require_relative 'time_formatter'

class TimeApp
  def initialize
    @formatter = TimeFormatter.new
  end

  def call(env)
    request = Rack::Request.new(env)
    
    if request.get?
      status, headers, body = @formatter.format(request.params['format'])
      [status, headers, body]
    else
      [404, [], ['Method Not Allowed']]
    end
  end
end
