class Float
  def round_dp decimal_places
    multiplier = 10.0**decimal_places
    (self*multiplier).round / multiplier
  end
end

