# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - 2.2

Pre-configured admin(Super Admin) - kinshuk@gmail.com. Password - 'password'

Once the user logs in, he/she will be able to see their upcoming bookings, as well as an option to make new bookings.There is also an option 'Edit Profile', in which the user can edit their details.

Admin functions:
1)Creating a new room: Home page -> Create a New Room
2)View rooms and room booking history, Edit Rooms, Delete Rooms: Home page -> View all rooms
3)Creating New User: Home page -> Create a New User
4)View Users, Make Bookings for Users, Edit/Destroy Users, View User Booking History, Make user into Admin: Home page-> View All users  
5)Search For Specific users:Home page -> Search For users   
6)View all bookings: Home page -> View all Bookings

Normal User functions:
1) View all bookings for himself: Home Page -> (click on the required link)
2) Book a Room: Home Page -> (click on the required link). The Room Booking page allows you to search for a room using location, size, date and time slot.
3) View Room details: Home Page -> View all rooms.

Special Case 1: When Admin deletes a room for which there exists a booking
System gives a warning saying that there is a booking for this room in the future. Are you sure you want to delete? If the admin clicks 
okay, then all future bookings of the room are delted, but the past bookings will remain in the history.

Special Case 2: When Admin deltes a user who has a room booked.
In this case, all the upcoming bookings of this user are deleted. Past bookings of this user however remain in the history.

Special Case 3:if a library member requests to book the same room multiple times. He wont be shown the room in the search if he is trying to book the same room again for the same time. 
However, if he wants to book the same room for another timeslot, he will be allowed to do so.

Extra credit Part 2: Admin can book 2 rooms for a user at the same time.

User model has been tested thoroughly

