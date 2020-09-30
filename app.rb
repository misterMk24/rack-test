require_relative 'middleware/parse_params'

class App
  
  def call(env)
    params = Rack::Request.new(env).params['format']
    return send_answer(body: empty_response_body, status: 400) if params.nil? || params&.empty?

    @parse_params_instance = ParseParams.new(params)
    if @parse_params_instance.permitted_params? 
      @result = @parse_params_instance.parse_params
      send_answer(body: success_response_body)
    else
      send_answer(body: unknown_response_body, status: 400)
    end
  end

  private

  def success_response_body
    ["#{@result}\n"]
  end

  def unknown_response_body
    ["Unknown time format [#{@parse_params_instance.prohibited_params.join(', ')}]\n"]
  end

  def empty_response_body
    ["Empty params\n"]
  end

  def text_response_header
    { 'Content-Type' => 'text/plain' }
  end

  def send_answer(**args)
    body = args[:body]
    status = args[:status] || 200
    headers = args[:headers] || text_response_header
    
    Rack::Response.new(body, status, headers).finish
  end
end
 