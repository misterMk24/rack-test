class ParseParams

  def initialize(app, **options)
    @app = app
    @params = options[:params]
    @result = []
  end

  def call(env)
    headers = { 'Content-Type' => 'text/plain' }
    parse_params
    body = @result.join('-')

    { status: 200, headers: headers, body: body }
  end

  private

  def parse_params
    @params.each{ |param| @result << obtain_data(param) } 
  end

  def obtain_data(param)
    time_array = Time.now.to_a
    data = {
      year: time_array[5], 
      month: time_array[4], 
      day: time_array[3],
      hour: time_array[2],
      minute: time_array[1],
      second: time_array[0]
    }
    data[param.to_sym]
  end
end
