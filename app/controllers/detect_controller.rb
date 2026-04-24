class DetectController < ApplicationController
  def create
    track_usage("detect")
    input = params[:data]

    detected = detect_pii(input)

    render json: { detected: detected }
  end

  private

  def detect_pii(data)
    result = []

    text = data.to_s

    result << "EMAIL" if text.match?(PiiMasker::EMAIL_REGEX)
    result << "PHONE" if text.match?(PiiMasker::PHONE_REGEX)

    result
  end
end