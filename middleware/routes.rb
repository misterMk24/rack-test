class Routes

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    PATH_PARAMS.match?(req.path) ? @app.call(env) : not_found(env)
  end

  private

  PATH_PARAMS = /\A\/{1}time/

  def not_found(env)
    status, headers, body = @app.call(env)
    status = 404
    body = ["Not Found\n"]
    [status, headers, body]
  end
end
