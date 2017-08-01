#Assignment 2 - Submitted by W. Brian Taing

#Instructions
#1. Videos table. Create one table to keep track of the videos. This table should include a unique ID, the title of the video, the length in minutes, and the URL. 
#   Populate the table with at least three related videos from YouTube or other publicly available resources.
#2. Create and populate Reviewers table. Create a second table that provides at least two user reviews for each of at least two of the videos. 
#   These should be imaginary reviews that include columns for the user’s name (“Asher”, “Cyd”, etc.), the rating (which could be NULL, or a number between 0 and 5), and a short text review (“Loved it!”). 
#   There should be a column that links back to the ID column in the table of videos.
#3. Report on Video Reviews. Write a JOIN statement that shows information from both tables.

# Drop table(s) if exists
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviewers;

# Create table(s) - videos; reviewers
CREATE TABLE videos (
	VideoID int AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL, -- youtube title limit per google search
    Length FLOAT(2) NOT NULL, -- minutes plus length seconds, use of float to allow for decimals
    url CHAR(60) NOT NULL -- to account for https and 12 character youtube id limit per google search
	);

CREATE TABLE reviewers (
	ReviewerID int AUTO_INCREMENT PRIMARY KEY,
    ReviewerName VARCHAR(255) NOT NULL,
    Rating int,
    Review VARCHAR(255) NOT NULL,
    VideoID int NOT NULL REFERENCES videos
    );

# Add Data into respective tables
INSERT INTO videos(Title, Length, url)
VALUES
('MySQL Beginner Tutorial 1 - Introduction to MySQL',ROUND(10+12/60,3),'https://www.youtube.com/watch?v=nN4Kjdverzs'),
('MySQL Tutorial for Beginners - Part 1 - Introduction to MySQL and Database',ROUND(10+6/60,3),'https://www.youtube.com/watch?v=JcRvy-4rf1Y'),
('MySQL 1 - Intro to MySQL', ROUND(13+78/60,3), 'https://www.youtube.com/watch?v=UGu9unCW4PA')
;

INSERT INTO reviewers(VideoID, ReviewerName, Review, Rating)
VALUES
(1,'Kin Cheng','I agree. great video and the only way to improve is to use better markers. your handwriting was fine. thank you for your time and effort in making these videos﻿',3),
(1,'Randal King','This video has so much potential. You have an energy and presentation style that most other YouTubers lack, but the video quality (or lack thereof) is killing you. PLEASE re-record this in a better setting',4),
(1,'Anthony Dark','love what your doing and I do understand why your using a white board...sorry I just have to say the light is killing me lol!!! I"m a  programmer and I do like to see what others are doing new.',3),
(2,'BlueinTN','Great video, thanks! The teacher is easy to listen to, and occassionally funny, which makes learning software much more fun! :-) This is one of the better tutorial videos Ive ever watched.﻿',4),
(2,'gooman2','This video was more helpful in an hour than 2 months of grad school on the same subject.﻿',3),
(2,'Scott Tozer','Amazing. Thank you for this. Today, Ive decided to learn SQL and this has been tremendously helpful﻿',2),
(3,'Petrockspiracy','Thank you very much for making this series! Youve clearly gotten much better at doing them since your older videos as well :)﻿',3),
(3,'Keitumetse','Thank you very much Caleb, Im in Soweto Johannesburg South Africa. You are a  genius and a very very special kid. All the best.﻿',4),
(3,'LinZee Linuz','Excellent excellent excellent!!!',3)
;

# Join Tables
SELECT v.VideoID, v.Title, v.Length, r.ReviewerName, r.Rating, r.Review, v.url
FROM videos as v
INNER JOIN reviewers as r
ON r.VideoID = v.VideoID
ORDER BY VideoID, Rating
;