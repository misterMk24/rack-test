require_relative 'middleware/routes'
require_relative 'app'

use Routes
run App.new
