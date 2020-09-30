class Routes

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    PERMITTED_PATH.match?(req.path) ? @app.call(env) : not_found(env)
  end

  private

  PERMITTED_PATH = /\A\/{1}time/

  def not_found(env)
    headers = { 'Content-Type' => 'text/plain' }
    status = 404
    body = ["Not Found\n"]
    [status, headers, body]
  end
end
