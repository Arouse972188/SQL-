--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

task12 (lesson4)
-- Корабли: Сделать копию таблицы ships, но у название корабля не должно начинаться с буквы N (ships_without_n)

create table ships_without_n as  
(select name from ships s where name not like 'N%')

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type

select model, maker, type from product p 

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"

select *,
case 
when price > (select avg(price) from pc)
then 1
else 0
end avg_price
from printer p 

--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)

select * 
from ships
where class is null

--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

select name
from battles
where DATEPART(year, battles."date") not in
     (select launched
      from ships
      where launched is not null)

--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

select b."name"  
from battles b join outcomes o on b."name" = o.battle 
join ships s on s."name" = o.ship 
where class = 'Kongo'

--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create table all_product2 as 
select price, product.model from product join laptop  on product.model = laptop.model
union all
select price, product.model from product join pc  on product.model = pc.model
union all 
select price, product.model from product join printer  on product.model = printer.model

create view all_products_flag_3003 as 
select *,
case 
when price > 300
then 1
else 0
end flag from all_product2 
select * from all_products_flag_3003

--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
select *,
case 
when price > (select avg(price) from all_product2)
then 1
else 0
end flag from all_product2
select * from all_products_flag_avg_price

--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select p.model from printer p join product p2 on p.model =p2.model where maker = 'A' and p2."type" = 'Printer' and price >
(select distinct avg(price) from printer p left join product p2 on p.model =p2.model
where p2."type" = 'Printer' and maker = 'D' or maker = 'C' 
group by maker)

--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по каждому производителю график (X: category_price, Y: count)

#join по таблицам laptop & product
request = """
select * from products_price_categories_with_makers where maker = 'A';
"""
df = pd.read_sql_query(request, conn)
fig = px.bar(df, x = 'category_price', y = 'count', labels={'x':'maker', 'y':'avg price'})
fig.show()

--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по A & D график (X: category_price, Y: count)