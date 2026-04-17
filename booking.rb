require_relative 'errors'

class Booking
  attr_reader :user, :resource, :status, :created_at

  def initialize(user:, resource:)
    # Check if resource is available before creating booking
    unless resource.available?
      raise ResourceUnavailableError, "Resource '#{resource.name}' is already booked!"
    end

    @user = user
    @resource = resource
    @status = "active"
    @created_at = Time.now
    
    # Update the resource so it knows it is now taken
    @resource.assign_booking(self)
  end

  def cancel
    @status = "cancelled"
    @resource.clear_booking
  end
end