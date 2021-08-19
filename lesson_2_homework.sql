--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

Задание 1: Вывести name, class по кораблям, выпущенным после 1920
--select *
--from ships s 
--where launched >= 1920

Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
--select *
--from ships s 
--where launched >= 1920 and not launched <= 1942

Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
--select count(*), "class" 
--from ships s 
--group by "class"

Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
--select class, country
--from classes c 
--where bore >= 16
--group by class

Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
--select ship 
--from
--(select ship
--from outcomes o
--where battle = 'North Atlantic' and result = 'sunk') t

Задание 6: Вывести название (ship) последнего потопленного корабля
--select ship
--from outcomes o
--join battles b 
--on o.battle = b.name
--where "result" = 'sunk'
--order by date desc 
--limit 1

Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
--select o.ship , s.class
--from outcomes o 
--left outer join battles b on b."name" = o.battle 
--left outer join ships s  on s."name" = o.ship 
--where result = 'sunk'
--order by date desc 
--limit 1

Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
--select t3.ship , t2.class
--from ships t1
--left outer join classes t2 on t2.class = t1.class
--left outer join outcomes t3 on t3.ship = t1.name 
--where bore > 16 and result = 'sunk

Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
--select class 
--from classes c 
--where country = 'USA'
Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
--select name, c."class" 
--from classes c join ships s 
--on c."class" = s."class" 
--where country = 'USA'