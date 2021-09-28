--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task12 (lesson5)
-- Компьютерная фирма: Сделать view, в которой будет постраничная разбивка всех laptop (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

--task1 (lesson5)
-- Компьютерная фирма: Сделать view (pages_all_products), в которой будет постраничная разбивка всех продуктов (не более двух продуктов на одной странице). Вывод: все данные из laptop, номер страницы, список всех страниц

create view laptop_pages as
select*, 
case when num % 2=0 then num / 2 else num / 2 + 1 end as page_num,
case when total % 2=0
then total / 2
else total / 2 + 1
end as num_of_pages
from (
	select*, row_number () over (order by price desc) as num,
	count(*) over () as total from laptop l
	) D


--task2 (lesson5)
-- Компьютерная фирма: Сделать view (distribution_by_type), в рамках которого будет процентное соотношение всех товаров по типу устройства. Вывод: производитель,

create view distribution_by_type as
select maker, f*100./total as procent 
from (	
	select *, count(*) over (partition by type) as f,
	count(*) over () as total from 
	(
	select p.type, maker from product p join laptop l on p.model = l.model 
	union all 
	select p.type, maker from product p join pc l on p.model = l.model 
	union all 
	select p.type, maker from product p join printer l on p.model = l.model
	) x
	) d

--task3 (lesson5)
-- Компьютерная фирма: Сделать на базе предыдущенр view график - круговую диаграмму



--task4 (lesson5)
-- Корабли: Сделать копию таблицы ships (ships_two_words), но у название корабля должно состоять из двух слов

create table ships_two_words as
select * from ships s where "name" like '% %'

--task5 (lesson5)
-- Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL) и название начинается с буквы "S"

select * from 
ships s join classes c 
on s."class" = c."class"
where c."class" is null and "name" like 'S%'

--task6 (lesson5)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'C' и три самых дорогих (через оконные функции). Вывести model
select p.model, row_number () over (order by price desc) from product p join printer p2 
on p.model = p2.model 
where maker = 'A' 
limit 3
--Производитель С не делает принтеры