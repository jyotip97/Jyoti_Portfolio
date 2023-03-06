--1) Who is the senior most employee based on th ejob title?

SELECT * FROM employee;

SELECT Top(1) * FROM employee ORDER BY Levels DESC;

--2) Which countries have the most Invoices?

SELECT * FROM invoice;

SELECT COUNT(*) as num, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY num DESC;

--3) What are the top 3 values of total invoice?

SELECT * FROM invoice;

SELECT TOP(3) total FROM invoice
ORDER BY total DESC;

--4)Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.

SELECT SUM(total) as invoice_total, billing_city
FROM INVOICE 
GROUP BY billing_city
ORDER BY invoice_total DESC;


--5)Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.

SELECT * FROM customer;
 

SELECT TOP(1) customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id,customer.first_name, customer.last_name
ORDER BY total DESC;

--6) Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
--Return your list ordered alphabetically by email starting with A

SELECT * FROM genre;
SELECT * FROM track;


SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
     SELECT track_id FROM track
     JOIN genre ON track.genre_id = genre.genre_id
     WHERE genre.name = 'Rock'
)
ORDER BY email;

--7) Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT * FROM artist;
SELECT * FROM album;


SELECT TOP(10) COUNT(artist.artist_id) AS num_of_songs, artist.artist_id, artist.name
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist on artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY num_of_songs DESC;

--8)Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) AS avg_song_length FROM track)
ORDER BY milliseconds DESC;

--9)Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.

WITH best_selling_artist AS(
    SELECT TOP(1) SUM(invoice_line.unit_price * invoice_line.quantity) as total_sales,
	artist.artist_id AS arts_id, artist.name AS artist_name
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist on artist.artist_id = album.artist_id
	GROUP BY artist.artist_id, artist.name
	ORDER BY total_Sales DESC
	)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name,
	SUM(il.unit_price * il.quantity) AS amount_spent
	FROM invoice i
	JOIN customer c ON c.customer_id = i.customer_id
	JOIN invoice_line il ON il.invoice_id = i.invoice_id
	JOIN track t ON t.track_id = il.track_id
	JOIN album alb ON alb.album_id = t.album_id
	JOIN best_selling_artist bsa ON bsa.arts_id = alb.artist_id
GROUP BY c.customer_id, first_name, last_name ,artist_name
ORDER BY amount_spent DESC;

--9)We want to find out the most popular music Genre for each country. 
--We determine the most popular genre as the genre with the highest amount of purchases.
--Write a query that returns each country along with the top Genre. 
--For countries where the maximum number of purchases is shared return all Genres.

WITH popular_genre AS
(
   SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
   ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo
   FROM invoice_line
   JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
   JOIN customer ON customer.customer_id = invoice.customer_id
   JOIN track ON track.track_id = invoice_line.track_id
   JOIN genre ON genre.genre_id = track.genre_id
   GROUP BY customer.country, genre.name, genre.genre_id
   ORDER BY customer.country ASC, purchases DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1;

--10)Write a query that determines the customer that has spent the most on music for each country.
--Write a query that returns the country along with the top customer and how much they spent. 
--For countries where the top amount spent is shared, provide all customers who spent this amount.

WITH customer_with_country AS (
           SELECT customer.customer_id, first_name, last_name, billing_country, SUM(total) AS total_spending,
		   ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS row_no
		   FROM invoice
		   JOIN customer ON customer.customer_id = invoice.customer_id
		   GROUP BY customer.customer_id, first_name, last_name, billing_country
		   ORDER BY billing_country ASC, total_spending DESC
		   )
SELECT * FROM customer_with_country WHERE row_no <= 1;
