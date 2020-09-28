class Params
  
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    req = Rack::Request.new(env)
    # req.query_string
    status, headers, body = @app.call(env)
    body = ["#{Rack::Utils.parse_nested_query(req.query_string).values}\n"] # возвращает хэш.
    # значение хэша format - строка с перечисленными необходимыми параметрами
    [status, headers, body]
  end
end
