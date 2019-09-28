class Search
  def self.condition(search_method, name)
    case search_method
    when 'forward_match'
      "#{name}%"
    when 'backward_match'
      "%#{name}"
    when 'perfect_match'
      name
    end
  end
end
