class ApplicationController < ActionController::API
  before_action :authenticate!
	before_action :enforce_rate_limit!

	def track_usage(endpoint)
		Usage.create!(api_key: @current_api_key, endpoint: endpoint, request_count: 1)
	end


	private
	def authenticate!
		header = request.headers["Authorization"]

		unless header&.start_with?("Bearer")
			render_unauthorized and return
		end

		token = header.split(" ").last
		@current_api_key = ApiKey.find_by(token: token, active: true)

		render_unauthorized unless @current_api_key
	end

	def enforce_rate_limit!
		limit = 100 # requests
		window = 1.minute

		count = Usage.where(api_key: @current_api_key)
								.where("created_at > ?", Time.now - window)
								.count

		oldest_request = Usage.where(api_key: @current_api_key)
                      .where("created_at > ?", Time.now - window)
                      .order(:created_at)
                      .first

		retry_after = (oldest_request.created_at + window - Time.now).ceil

		if count >= limit
			render json: { error: "Rate limit exceeded", retry_after_seconds: retry_after }, status: :too_many_requests
		end
	end

	def render_unauthorized
		render json: { error: "Unauthorized" }, status: :unauthorized
	end

end
