class BookingError < StandardError; end
class ResourceUnavailableError < BookingError; end