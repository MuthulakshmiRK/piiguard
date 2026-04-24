class PiiMasker
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
  PHONE_REGEX = /\b\d{10}\b/

  def self.mask(data)
    case data
    when String
      mask_string(data)
    when Hash
      data.transform_values { |v| mask(v) }
    when Array
      data.map { |v| mask(v) }
    else
      data
    end
  end

  def self.mask_string(text)
    text
      .gsub(EMAIL_REGEX, "[EMAIL]")
      .gsub(PHONE_REGEX, "[PHONE]")
  end
end