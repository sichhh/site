module Api
  module V1
    class ApplicationController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from OpenURI::HTTPError, with: :handle_http_error

      private

      def record_not_found(exception)
        render json: { error: exception.message }, status: :not_found
      end

      def handle_http_error(exception)
        render json: { error: "HTTP request failed: #{exception.message}" }, status: :unprocessable_entity
      end
    end
  end
end
