# Homework 3 submitted by W. Brian Taing 8/6/17

# Instructions:
# An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that users below to only one group. Your job is to design the database that supports the key-card system.
# There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group “Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. 
# Saulat is in group “Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms 101 and 102. 
# Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any rooms. Heidy is a new employee, who has not yet been assigned to any group.
# After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you should create the tables and populate them with the information indicated above.
# Next, write SELECT statements that provide the following information:
# • All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
# • All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.
# • A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted alphabetically by user, then by group, then by room.

# Create Schema
DROP SCHEMA IF EXISTS keycardaccess;
CREATE SCHEMA keycardaccess; 
USE keycardaccess;

# Drop tables if exists
DROP TABLE IF EXISTS users; -- main table
DROP TABLE IF EXISTS groups; -- main table
DROP TABLE IF EXISTS rooms;  -- main table
DROP TABLE IF EXISTS groups_rooms; -- bridge table


# Create table with the following relationships
# Users and groups: one to many
# Groups to Rooms: many to many 
 
CREATE TABLE users(
  user_id int PRIMARY KEY,
  user_name varchar(25) NOT NULL, 
  group_id int NULL REFERENCES groups
);

CREATE TABLE groups(
  group_id int PRIMARY KEY,
  group_name varchar(25) NOT NULL 
);

CREATE TABLE rooms(
  room_id int PRIMARY KEY,
  room_name varchar(25) NOT NULL 
);

CREATE TABLE groups_rooms(
  group_id int NOT NULL REFERENCES groups(group_id),
  room_id int NOT NULL REFERENCES rooms(room_id),
  CONSTRAINT pk_groups_rooms PRIMARY KEY(group_id, room_id)
 );


# Add data to respective tables
# There are six users, and four groups. 
# Modesto and Ayine are in group “I.T.” 
# Christopher and Cheong woo are in group “Sales”. 
# Saulat is in group “Administration.” 
# Heidy is a new employee, who has not yet been assigned to any group.
INSERT INTO users (user_id, user_name, group_id) VALUES ( 1, 'Modesto', 1);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 2, 'Ayine', 1);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 3, 'Christopher', 2);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 4, 'Cheong woo', 2);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 5, 'Saulat', 3);
INSERT INTO users (user_id, user_name, group_id) VALUES ( 6, 'Heidy', NULL);

# There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. 
# I.T. should be able to access Rooms 101 and 102. 
# Sales should be able to access Rooms 102 and Auditorium A. 
# Administration does not have access to any rooms. 
# Group “Operations” currently doesn’t have any users assigned. 

INSERT INTO groups (group_id, group_name) VALUES (1, 'I.T.');
INSERT INTO groups (group_id, group_name) VALUES (2, 'Sales');
INSERT INTO groups (group_id, group_name) VALUES (3, 'Administration');
INSERT INTO groups (group_id, group_name) VALUES (4, 'Operations');

INSERT INTO rooms (room_id, room_name) VALUES (1, '101');
INSERT INTO rooms (room_id, room_name) VALUES (2, '102');
INSERT INTO rooms (room_id, room_name) VALUES (3, 'Auditorium A');
INSERT INTO rooms (room_id, room_name) VALUES (4, 'Auditorium B');

# join table - access to rooms by group_id - many to many
INSERT INTO groups_rooms (group_id, room_id) VALUES (1, 1); -- IT has access to Room 101
INSERT INTO groups_rooms (group_id, room_id) VALUES (1, 2); -- IT has access to Room 102
INSERT INTO groups_rooms (group_id, room_id) VALUES (2, 2); -- Sales has access to Room 102
INSERT INTO groups_rooms (group_id, room_id) VALUES (2, 3); -- Sales has access to Auditorium A


# All groups and the users in each group. 
# A group should appear even if there are no users assigned to the group.
SELECT g.group_name, u.user_name FROM groups g
  LEFT JOIN users  u ON u.group_id = g.group_id;


# All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.
SELECT r.room_name, g.group_name FROM rooms r
	LEFT JOIN groups_rooms gr ON r.room_id = gr.room_id
    LEFT JOIN groups g ON g.group_id = gr.group_id;


# A list of users, the groups that they belong to, and the rooms to which they are assigned. 
# This should be sorted alphabetically by user, then by group, then by room.
SELECT u.user_name AS 'User', g.group_name AS 'Group', r.room_name AS 'Room' FROM users u
	LEFT JOIN groups g ON g.group_id = u.group_id
    LEFT JOIN groups_rooms gr ON gr.group_id = g.group_id
    LEFT JOIN rooms r ON r.room_id = gr.room_id
ORDER BY u.user_name, g.group_name, r.room_name;