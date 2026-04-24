class PiiMasker
  EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
  PHONE_REGEX = /\b\d{10}\b/


  def self.process(data)
    context = {
      detected: [],
      fields_masked: []
    }

    masked = mask(data, context, [])
    {
      masked: masked,
      detected: context[:detected].uniq,
      fields_masked: context[:fields_masked]
    }
  end

  def self.mask(data, context, path)
    case data
    when String
      mask_string(data, context, path)

    when ActionController::Parameters
      mask(data.to_unsafe_h, context, path)
    when Hash
      data.each_with_object({}) do |(k,v), result|
        new_path = path +  [k.to_s]
        result[k] = mask(v, context, new_path)
      end
    when Array
      data.map.with_index do |v, i|
        mask(v, context, path + [i.to_s])
      end
    else
      data
    end
  end

  def self.mask_string(text, context, path)
    original = text.dup

    masked = text
    if masked.gsub!(EMAIL_REGEX, "[EMAIL]")
      context[:detected] << "EMAIL"
      context[:fields_masked] << path.join(".")
    end
    if masked.gsub!(PHONE_REGEX, "[PHONE]")
      context[:detected] << "PHONE"
      context[:fields_masked] << path.join(".")
    end
    masked
  end
end