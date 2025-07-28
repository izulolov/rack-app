require 'pry'

class TimeApp
  VALID_FORMATS = %w[year month day hour minute second].freeze

  def call(env)
    request = Rack::Request.new(env)
    
    # Проверяем, что это GET-запрос на /time.
    # Если это GET-запрос на /time вызываем метод process_time_request(request)
    if request.path == '/time' && request.get?
      process_time_request(request)
    else
      # Для любого другого URL возвращаем 404
      [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
    end
  end

  private

  def process_time_request(request)
    format_param = request.params['format']
    
    # По заданию, если параметр format отсутствует то выводим "Parameter "format" is required"
    return [400, { 'Content-Type' => 'text/plain' }, ['Parameter "format" is required']] unless format_param
    
    # Если параметр format есть то разбываем его на отдельные форматы
    formats = format_param.split(',')
    binding.pry

    # Проверяем наличие неизвестных форматов
    unknown_formats = formats.reject { |format| VALID_FORMATS.include?(format) }
    
    # Если есть неизвестные форматы, возвращаем ошибку 400 и текст "Unknown time format [yearrrr]"
    unless unknown_formats.empty?
      return [400, { 'Content-Type' => 'text/plain' }, ["Unknown time format [#{unknown_formats.join(', ')}]"]]
    end
    
    # Формируем ответ с текущим временем в запрошенном формате
    time_now = Time.now
    result = formats.map do |format|
      case format
      when 'year'   then time_now.strftime('%Y')
      when 'month'  then time_now.strftime('%m')
      when 'day'    then time_now.strftime('%d')
      when 'hour'   then time_now.strftime('%H')
      when 'minute' then time_now.strftime('%M')
      when 'second' then time_now.strftime('%S')
      end
    end.join('-')
    
    [200, { 'Content-Type' => 'text/plain' }, [result]]
  end
end
