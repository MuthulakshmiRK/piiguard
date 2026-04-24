class ApiKey < ApplicationRecord
  before_create :generate_token

	validates :token, presence: true, uniqueness: true

	private
	def generate_token
		self.token ||= SecureRandom.hex(20)
	end
end
