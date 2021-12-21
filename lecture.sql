-- basic
select * from albums;

-- specific cols
select title, artistid from albums;

-- alias
select title as T, albumid from albums;

-- where
select * from albums where artistid > 100 and title like '%the%';

-- limit, offset
select * from albums order by artistid desc limit 3 offset 2;

-- distinct
select distinct artistid from albums;

-- in
select Name, AlbumId from tracks where albumid in (1,2,3);

-- group by
select artistid, count(*) as Amount
from albums
group by artistid
having Amount >= 10
order by Amount desc
limit 3;

-- join
select al.AlbumId, al.Title, ar.Name
from albums al
inner join artists ar
on ar.ArtistId = al.AlbumId
order by ar.Name desc
limit 5;

-- mega join
select al.Title, ar.Name as Artist, tr.Name as Track, ge.Name as Genre, mt.Name as Media
from albums al
inner join artists ar on ar.ArtistId = al.ArtistId
inner join tracks tr on al.AlbumId = tr.AlbumId
inner join genres ge on ge.GenreId = tr.GenreId
inner join media_types mt on mt.MediaTypeId = tr.MediaTypeId
where Artist = 'Kiss' or Genre = 'Latin'
order by Track desc
limit 3;

-- inner vs outer join
select customerid, firstname, supportrepid from customers where customerid = 1;
update customers set supportrepid = NULL where customerid = 1;
select count(*) from customers; -- 59
select count(*) from employees; -- 8
select count(*) as InnerCount -- only 58, because one value is null
from customers c
inner join employees e on e.EmployeeId = c.SupportRepId;
select count(*) as LeftCounter -- all 59, because left join ignores null value
from customers c
left outer join employees e on c.SupportRepId = e.EmployeeId;

-- common table expressions CTE
with
top as (select Name, length(name) as Length from artists order by Name asc limit 3),
bottom as (select Name, length(name) as Length from artists order by Name desc limit 3)
select *
from top t
union
select *
from bottom b
where Length > 10
order by Length desc
limit 2;

-- subquery
SELECT trackid,
       name,
       albumid
FROM tracks
WHERE albumid = (
   SELECT albumid
   FROM albums
   WHERE title = 'Let There Be Rock'
);

-- subquery
SELECT customerid,
       firstname,
       lastname
  FROM customers
 WHERE supportrepid IN (
           SELECT employeeid
             FROM employees
            WHERE country = 'Canada'
);

-- subquery
SELECT
	AVG(album.size)
FROM
	(
		SELECT
			SUM(bytes) SIZE
		FROM
			tracks
		GROUP BY
			albumid
	) AS album;

-- show the name of each customer that has spent a total of more than $40
-- order by name in descending order
-- only show 5 records

select c.FirstName as Name, count(*) as Purchases, sum(i.Total) as Amount
from customers c
inner join invoices i on c.CustomerId = i.CustomerId
group by Name
having Amount > 40
order by Name desc
limit 5;

-- what is the name of the most popular genre

-- which artist has the most tracks

-- what album has the most tracks

-- what artist has sold the most tracks

-- list the customers that listen to the Latin genre
