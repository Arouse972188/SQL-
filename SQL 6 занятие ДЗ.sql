--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing


--task5  (lesson6)
-- Компьютерная фирма: Создать таблицу all_products_with_index_task5 как объединение всех данных по ключу code (union all) и сделать флаг (flag) по цене > максимальной по принтеру. 
--Также добавить нумерацию (через оконные функции) по каждой категории продукта в порядке возрастания цены (price_index). 
--По этому price_index сделать индекс

create table all_products_with_index_task5 as
select *, row_number () over (partition by code order by price) as price_index,
case when price > (select max (price) from printer p)
then 1
else 0
end flag
from
(select price , code from product p join laptop l on p.model = l.model 
	union all 
	select price, code from product p join pc l on p.model = l.model 
	union all 
	select price, code from product p join printer l on p.model = l.model) a

create index task5_idx on all_products_with_index_task5(price_index);
