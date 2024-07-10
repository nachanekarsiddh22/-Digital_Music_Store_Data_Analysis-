create database  Music 

use music
select*from employee

-- Q.1 How is the senior most employee based on job title ?
select*from employee order by levels desc limit 1

-- Q.2 Which countries have the most invoices ?
select * from invoice

select count(*) as c , billing_country from invoice group by billing_country order by c desc 

-- Q.3 What are top 3 values of total invoice ?
select total from invoice order by total desc limit 3

-- Q.4 Which city has the best customers ? 
-- We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that return one city that has the highest sum of invoice totals. 
-- Return both the city name and sum of all invoice totals

Select sum(total) as invoice_total , billing_city from invoice group by billing_city order by invoice_total desc 

-- Q.5 Who is the best customer? The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money.
select* from invoice
select*from customer

SELECT customer.customer_id, customer.first_name, customer.last_name, total_spent.total
FROM customer
JOIN (
    SELECT customer_id, SUM(total) AS total
    FROM invoice
    GROUP BY customer_id
) AS total_spent
ON customer.customer_id = total_spent.customer_id
ORDER BY total_spent.total DESC
LIMIT 1;

-- Q.6 Write query to return the emaail, first name, last name and Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A 
SELECT DISTINCT customer.email, customer.first_name, customer.last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.track_id IN (
    SELECT track.track_id
    FROM track
    JOIN genre ON track.genre_id = genre.genre_id
    WHERE genre.name = 'Rock'
)
ORDER BY customer.email;


-- Q.7 Let's invite the artists who have written the most rock music in our dataset .
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT artist.artist_id, artist.name, COUNT(track.track_id) AS number_of_songs
FROM track 
JOIN album ON album.album_id = track.album_id 
JOIN artist ON artist.artist_id = album.artist_id 
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;


-- Q.8 Return all the track names that have a song length longer than the average song .
-- Return the name and milliseconds for each track. Order by the song length with the longest songs listed first.    
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) 
    FROM track
)
ORDER BY milliseconds DESC;


