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


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди 
--всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
--и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
select distinct maker from product
where type = 'printer' and maker in (select maker from product where model in 
(select model from pc where speed = (select max(speed) from ( 
select speed from pc where ram = (select min(ram) 
from pc)) as d)))