class String
  def apply!(value, field)
    self.gsub!("{{#{field}}}", value)
  end
  def apply_all!(options)
    options.keys.each do |field|
      self.apply!(options[field], field)
    end
  end
end