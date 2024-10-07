select ProductName, CategoryName
from Products, Categories
where Products.CategoryID = Categories.CategoryID
go

select ProductName, CategoryName
from Products
	inner join Categories on Products.CategoryID = Categories.CategoryID
go

/*
Ejercio 01.01
Indicar el nombre del vendedor para cada uno de los pedidos.

Employees: LastName, FirstName (EmployeeID)
Orders: OrderID (EmployeeID)
*/
select LastName + ', ' + FirstName as FullName, OrderID
from Employees as E
	inner join Orders as O on E.EmployeeID = O.EmployeeID
go

/*
Ejercio 01.02
Indicar el nombre del cliente para cada uno de los pedidos.
Customers: CompanyName (CustomerID)
Orders: OrderID (CustomerID)
*/
select CompanyName
from Customers
where CustomerID not in
	(select distinct C.CustomerID
	from Customers as C
		inner join Orders as O on C.CustomerID = O.CustomerID)
go

/*
Ejercio 01.03
Indicar los nombres de los clientes que no han hecho pedidos
*/

select CompanyName, OrderID
from Customers as C
	left join Orders as O on C.CustomerID = O.CustomerID
where OrderID is null

/*
Ejercio 01.04
Indicar los nombres de los empleados que no han atendido pedidos
*/
select LastName + ', ' + FirstName as  FullName, OrderID
from Employees as E
	left join Orders as O on E.EmployeeID = O.EmployeeID
where OrderID is null
go

/*
Indicar el nombre del producto con la mayor cantidad de órdenes. 
Products: ProductName (ProductID)
Order Details: OrderID (ProductID)
*/

create view VOrdersQuantityByProductName as
select ProductName, count(OrderID) as Quantity
from Products as P
	inner join [Order Details] as OD on P.ProductID = OD.ProductID
group by ProductName
go

select * from VOrdersQuantityByProductName
