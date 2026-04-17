# Lab-Booking
REFLECTION
1.What part was easiest?
   setting up the classes was easier.
2. What part was hardest?
    making the users name get printed with resources when the are booked

3. What bug did you face, and how did you fix it?
   When I selected "View Resources," it wouldn't show who borrowed the item—it only showed if it was "Booked" or "Available."
    The Fix: I added a .find method inside the display loop. This code looks through the @bookings array to find the active booking for that resource, which then allows the system to pull and print the specific user.name of the borrower.

