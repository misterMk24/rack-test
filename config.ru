require_relative 'middleware/routes'
require_relative 'middleware/params'
require_relative 'app'

use Routes
use Params
run App.new
