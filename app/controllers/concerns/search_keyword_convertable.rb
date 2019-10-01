module SearchKeywordConvertable
  extend ActiveSupport::Concern

  def convert_keyword(search_method, keyword)
    case search_method
    when 'forward_match'
      "#{keyword}%"
    when 'backward_match'
      "%#{keyword}"
    when 'perfect_match'
      keyword
    when 'content_match'
      "%#{keyword}%"
    else
    end
  end
end
