class MaskController < ApplicationController
  def create
    input = params[:data]

    masked = PiiMasker.mask(input)

    render json: { masked: masked }
  end
end