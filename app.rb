require_relative 'middleware/parse_params'

class App
  
  def call(env)
    params = Rack::Request.new(env).params['format']
    return empty_params if params.nil? || params&.empty?

    @parse_params_instance = ParseParams.new(params)
    @result = @parse_params_instance.call
    @parse_params_instance.permitted_params? ? success_params : unknown_params
  end

  private

  def success_params
    send_answer(
      body: ["#{@result}\n"],
      status: 200,
      headers: { 'Content-Type' => 'text/plain' }
    )
  end

  def unknown_params
    send_answer(
      body: ["Unknown time format [#{@parse_params_instance.prohibited_params.join(', ')}]\n"],
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
    
    [status, headers, body]
  end
end
 