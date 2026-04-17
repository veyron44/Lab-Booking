require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../errors"

class BookingTest < Minitest::Test
  def setup
    @user = User.new(id: 1, name: "Mahi", role: "assistant")
    @resource = Resource.new(id: 1, name: "Microscope", category: "lab")
  end

  def test_booking_an_available_resource_creates_active_booking
    booking = Booking.new(user: @user, resource: @resource)
    assert_equal "active", booking.status
    assert_equal false, @resource.available?
  end

  def test_booking_an_unavailable_resource_raises_error
    Booking.new(user: @user, resource: @resource)
    assert_raises(ResourceUnavailableError) do
      Booking.new(user: @user, resource: @resource)
    end
  end

  def test_cancelling_a_booking_changes_its_status
    booking = Booking.new(user: @user, resource: @resource)
    booking.cancel
    assert_equal "cancelled", booking.status
  end

  def test_cancelling_a_booking_makes_the_resource_available_again
    booking = Booking.new(user: @user, resource: @resource)
    booking.cancel
    assert_equal true, @resource.available?
  end
end