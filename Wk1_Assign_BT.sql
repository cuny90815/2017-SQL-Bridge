#Assignment 1 - SQL BRIDGE - W.Brian Taing

# 1. Which destination in the flights database is the furthest distance away, based on information in the flights table.
# Show the SQL query(s) that support your conclusion.

# Ans: JFK to HNL (New York to Honolulu, HI) is the furthest distance flight amounting to 4,983 miles
SELECT * FROM flights ORDER BY distance DESC;


# 2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have
# the most number of seats? Show the SQL statement(s) that support your result.

# Ans: There are four different number of engines: 1, 2, 3, and 4. 
SELECT DISTINCT(engines) FROM planes;


# 3. Show the total number of flights.

# Ans: There are a total of 336,776 flights
SELECT count(flight) FROM flights;


# 4. Show the total number of flights by airline (carrier).

# Ans: There are 16 carriers totaling 336,776 flights
SELECT carrier, COUNT(flight) FROM flights GROUP BY carrier;


# 5. Show all of the airlines, ordered by number of flights in descending order.

# Ans: Same as #4 but sorted
SELECT carrier, COUNT(flight) FROM flights GROUP BY carrier ORDER BY COUNT(flight) DESC;


# 6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.

# Ans: Added "LIMIT 5" after qSQL statement to question 5.
SELECT carrier, COUNT(flight) FROM flights GROUP BY carrier ORDER BY COUNT(flight) DESC LIMIT 5;


# 7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of
# flights in descending order.

# Ans: Added "WHERE distance>100" to SQL statment to question 6.
SELECT carrier, COUNT(flight) FROM flights WHERE distance>1000 GROUP BY carrier ORDER BY count(flight) DESC LIMIT 5;


# 8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and
# write down both the question, and the query that answers the question.

#Ans: What is the average delay for flights originating from JFK
SELECT AVG(dep_delay) FROM flights WHERE origin = 'JFK';