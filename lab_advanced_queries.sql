-- Lab | SQL Advanced queries --

-- In this lab, you will be using the Sakila database of movie rentals.
use sakila;

-- 1 List each pair of actors that have worked together.

with cte_actor1 as (
	select fa.film_id, a.actor_id as actor1, a.first_name, a.last_name
	from film_actor as fa
    join actor as a
    on fa.actor_id = a.actor_id
)
select cte.film_id, cte.actor1, cte.first_name, cte.last_name, f.actor_id as actor2, ac.first_name, ac.last_name
from cte_actor1 as cte
join film_actor as f
on cte.film_id = f.film_id
and cte.actor1 < f.actor_id
join actor as ac
on f.actor_id = ac.actor_id
order by cte.film_id;


-- 2 For each film, list actor that has acted in more films.

#final query:
select f.film_id, f.title, fa.actor_id from film as f
join film_actor as fa
on f.film_id = fa.film_id
where fa.actor_id in (
	select actor_id from (
		select actor_id, count(film_id) as nr_of_films from film_actor
		group by actor_id
		order by nr_of_films desc
    ) as sub1)
order by actor_id;


#inner query:
select actor_id from (
	select actor_id, count(film_id) as nr_of_films from film_actor
	group by actor_id
	order by nr_of_films desc
) as sub_test;

#note to myself:
	#where ... in renturns a table
	# <, >, = returns a value
	# check this by running the inner query first!