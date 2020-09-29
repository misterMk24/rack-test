class Params

  def initialize(app)
    @app = app
    @prohibited_params = []
  end

  def call(env)
    params = obtain_params(env)
    return empty_params if params.empty?

    permitted_params?(params) ? @app.call(env) : unknown_params
  end

  def obtain_params(env)
    req = Rack::Request.new(env).params['format']
    req.nil? ? '' : req.split(',')
  end

  private

  PERMITTED_PARAMS = ['year', 'month', 'day', 'hour', 'minute', 'second']

  def permitted_params?(params)
    params.each { |param| @prohibited_params.push(param)  unless PERMITTED_PARAMS.include?(param) }
    @prohibited_params.empty? ? true : false
  end

  def unknown_params
    send_answer(
      body: ["Unknown time format [#{@prohibited_params.join(', ')}]\n"],
      status: 400,
      headers: { 'Content-Type' => 'text/plain' }
    )
  end

  def empty_params
    send_answer(
      body: ["Empty params\n"],
      status: 400,
      headers: { 'Content-Type' => 'text/plain' }
    )
  end

  def send_answer(**args)
    body = args[:body]
    status = args[:status]
    headers = args[:headers]
    @prohibited_params.clear
    
    [status, headers, body]
  end
end
