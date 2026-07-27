# frozen_string_literal: true

class BaseError < StandardError
  attr_reader :status, :message

  def initialize(message = nil, status = nil)
    @status = status || :internal_server_error
    @message = message || self.class.name
    super(@message)

    # Sentry.capture_exception(self)
    Rails.logger.error "#{DateTime.current} AppError: Class: #{self.class.name}, Status: #{@status}, Error: #{@message}"
  end

  def to_h
    {
      error: message,
      status: status
    }
  end

  def to_json(*_args)
    to_h.to_json
  end
end
