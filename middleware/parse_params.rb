class ParseParams
  
  attr_reader :prohibited_params

  def initialize(params)
    @params = params
    @result = []
    @prohibited_params = []
    @clear_params = []
  end

  def call
    @clear_params = @params.split(',')
    parse_params
  end

  def permitted_params?
    @clear_params.each { |param| @prohibited_params.push(param)  unless PERMITTED_PARAMS.include?(param) }
    @prohibited_params.empty? ? true : false
  end

  private

  attr_writer :prohibited_params

  PERMITTED_PARAMS = ['year', 'month', 'day', 'hour', 'minute', 'second']

  def parse_params
    @clear_params.each{ |param| @result << obtain_data(param) }
    @result.join('-')
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
