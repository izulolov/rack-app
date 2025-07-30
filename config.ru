require 'rack'
require_relative 'app'

use Rack::ContentType, 'text/plain'

ROUTES = {
  '/time' => TimeApp.new
}

run Rack::URLMap.new(ROUTES)
