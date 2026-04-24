class MaskController < ApplicationController
  def create
  track_usage("mask")
  result = PiiMasker.process(params[:data])

  render json: {
    masked: result[:masked],
    meta: {
      detected: result[:detected],
      fields_masked: result[:fields_masked],
      request_id: SecureRandom.uuid,
      processed_at: Time.now.utc
    }
  }
end
end