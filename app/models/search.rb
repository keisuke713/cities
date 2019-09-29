class Search
  def self.condition(search_method, keyword)
    case search_method
    when 'forward_match'
      "#{keyword}%"
    when 'backward_match'
      "%#{keyword}"
    when 'perfect_match'
      keyword
    end
  end
end
