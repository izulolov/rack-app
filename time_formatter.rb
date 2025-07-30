class TimeFormatter
  VALID_FORMATS = %w[year month day hour minute second].freeze

  def format(format_param)
    return [400, [], ['Parameter "format" is required']] unless format_param
    
    formats = format_param.split(',')
    
    # Проверяем наличие неизвестных форматов
    unknown_formats = formats.reject { |format| VALID_FORMATS.include?(format) }
    
    unless unknown_formats.empty?
      return [400, [], ["Unknown time format [#{unknown_formats.join(', ')}]"]]
    end
    
    # Форматируем время
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
    
    [200, [], [result]]
  end
end
