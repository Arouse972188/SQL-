--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task17
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select o.battle 
from outcomes o 
join ships s 
on s."name" = o.ship
where "class" = 'Kongo'

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select count(*), s.class
from outcomes o
join ships s 
on o.ship = s."name" 
where result = 'sunk'
group by "class" 

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
--Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. 
--Вывести: класс, год.

select c."class" , k.min
from classes c 
left join
(select class, min(launched) as min
from ships s 
group by s."class") as k on c."class" = k.class

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
--вывести имя класса и число потопленных кораблей.

SELECT c.class, SUM(s.sunked)
FROM classes c
LEFT JOIN (SELECT t.name, t.class,
	CASE WHEN o.result = 'sunk' THEN 1 ELSE 0 END AS sunked
    FROM
	(SELECT name, class
     FROM ships
     UNION
     SELECT ship, result 
     FROM outcomes) t
    LEFT JOIN outcomes o ON t.name = o.ship) s ON s.class = c.class
GROUP BY c.class
HAVING COUNT(DISTINCT s.name) >= 3 AND SUM(s.sunked) > 0


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди 
--всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select name from
(select name, displacement, numguns 
from ships inner join classes on ships.class = classes.class 
union 
select ship, displacement, numguns 
from outcomes inner join classes on outcomes.ship= classes.class) as t 
inner join (select displacement, max(numGuns) as numguns 
from ( select displacement, numguns from ships inner join classes on ships.class = classes.class 
union select displacement, numguns from outcomes inner join classes on outcomes.ship= classes.class) as f 
group by displacement) as n on t.displacement=n.displacement and t.numguns=n.numguns


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
--и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select distinct maker from product
where type = 'printer' and maker in (select maker from product where model in 
(select model from pc where speed = (select max(speed) from ( 
select speed from pc where ram = (select min(ram) 
from pc)) as d)))