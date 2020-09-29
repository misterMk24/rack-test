require_relative 'middleware/parse_params'

class App

  def call(env)
    params = Params.new(self).obtain_params(env)
    parse_params = ParseParams.new(self, params: params).call(env)

    status = parse_params[:status]
    headers = parse_params[:headers]
    body = ["#{parse_params[:body]}\n"]

    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
  end
end
 