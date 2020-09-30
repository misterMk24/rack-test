class ParseParams
  
  attr_reader :prohibited_params

  def initialize(params)
    @result = []
    @prohibited_params = []
    @params = params.split(',')
  end

  def parse_params
    @params.each{ |param| @result << obtain_data(param) }
    @result.join('-')
  end

  def permitted_params?
    @params.each { |param| @prohibited_params.push(param)  unless PERMITTED_PARAMS.include?(param) }
    @prohibited_params.empty? ? true : false
  end

  private

  attr_writer :prohibited_params

  PERMITTED_PARAMS = ['year', 'month', 'day', 'hour', 'minute', 'second']

  def obtain_data(param)
    time_array = Time.now
    data = {
      year: "%Y", 
      month: "%m", 
      day: "%d",
      hour: "%H",
      minute: "%M",
      second: "%S"
    }
    time_array.strftime(data[param.to_sym])
  end
end
