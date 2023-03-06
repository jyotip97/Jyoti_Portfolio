create table Customers(Customer_ID INT, Name varchar(50), Email varchar(50), Password varchar(50), Address varchar(50))
create table Products(Product_ID INT, Name varchar(50), Description varchar(50), Price int, Quantity int)
create table Orders(Order_ID int, Customer_ID INT, Product_ID INT, Quantity int, Date date);

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(1, 'Shreya', 'shreya@gmail.com', 'sk@123', 'Delhi');

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(2, 'Jay', 'jay@yahoo.com', 'jay@123', 'Noida');

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(3, 'Nimita', 'nim@gmail.com', 'nimi@123', 'Bangalore');

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(4, 'Shiv', 'shiv@gmail.com', 'shiv@123', 'Gurugram');

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(5, 'Megha', 'meg@yahoo.com', 'meg@123', 'Hyderabad');

Insert into Customers(Customer_ID, Name, Email, Password, Address)
Values(6, 'Vanika', 'vana@yahoo.com', 'vanika@123', 'Mumbai');

select* from Customers;

Insert into Products(Product_ID, Name, Description, Price, Quantity)
Values(10, 'Shampoo', 'Use for hair cleansing', 120, 5);

Insert into Products(Product_ID, Name, Description, Price, Quantity)
Values(20, 'Shower Gel', 'Body Cleanser', 100, 10);

Insert into Products(Product_ID, Name, Description, Price, Quantity)
Values(30, 'Face Wash', 'Face Cleanser', 225, 15);

Insert into Products(Product_ID, Name, Description, Price, Quantity)
Values(40, 'Face Cream', 'Face Moisturizer', 100, 15);

Insert into Products(Product_ID, Name, Description, Price, Quantity)
Values(50, 'Body Lotion', 'Moisturize & Hydrates Skin', 140, 10);

select * from products;

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(11, 1, 40, 2, '2023/01/15');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(21, 4, 30, 1, '2023-01-20');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(31, 1, 20, 1, '2023-01-15');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(35, 5, 10, 2, '2023-02-05');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(52, 6, 20, 3, '2023-01-30');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(55, 3, 40, 2, '2023-02-10');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(56, 3, 50, 1, '2023-02-10');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(59, 2, 20, 1, '2023-02-14');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(61, 2, 30, 1, '2023-02-14');

Insert into Orders(Order_ID, Customer_ID, Product_ID, Quantity, Date)
Values(70, 5, 50, 1, '2023-01-21');

select * from Orders;

exec sp_rename 'Customers.Name', 'CustName';
exec sp_rename 'Products.Name', 'ProdName';
exec sp_rename 'Products.Price', 'ProdPrice';
exec sp_rename 'Products.Quantity', 'ProdQuant';
exec sp_rename 'Orders.Quantity', 'OrderQuant';

#Join
SELECT customers.customer_ID, customers.CustName, customers.email, customers.address, 
products.product_ID, products.prodname, products.description, products.ProdPrice, products.prodquant, 
orders.order_ID, orders.orderquant, orders.date 
FROM customers 
INNER JOIN orders 
ON customers.customer_ID = orders.customer_ID 
INNER JOIN products 
ON orders.product_ID = products.product_ID;

select * from products where Product_ID = 40;

#Order History
select custname, order_ID, orderquant, Prodname
from customers, orders, products
where customers.customer_ID = orders.customer_ID AND orders.product_ID = Products.product_ID
order by prodname;

#Sale_of_a_product
select products.prodname, sum(products.ProdPrice * (orders.orderquant)) as product_sale
from Products, Orders
where products.Product_ID = orders.Product_ID  

#Updating_the_Data
UPDATE Customers
SET Address = 'Bangalore'
WHERE CustName = 'Vanika';

UPDATE Products
SET ProdQuant = 10
WHERE ProdName = 'Shampoo';

UPDATE Products
SET ProdQuant = 20
WHERE ProdName = 'Shower Gel';

#Canceling_an_order
DELETE From Orders Where Order_ID = 61;

Insert into Orders(Order_ID, Customer_ID, Product_ID, OrderQuant, Date)
Values(61, 2, 30, 1, '2023-02-14');


--Jupyter Notebook code
 
 import pyodbc

connection = pyodbc.connect('Driver={SQL Server};''Server=.;''Database=sample 2 ecommerce;' 'Trusted_connection=yes;')
if connection:
    print('True')

--#Customers Entry
def read(connection):
    cursor = connection.cursor()
    print(read)
    cursor.execute('SELECT * FROM Customers')
    for i in cursor:
        print(i)
    connection.commit()

def write(connection):
    cursor = connection.cursor()
    print(write)
    ID = input('Customer_ID: ')
    Name = input('CustName: ')
    Email = input('Email: ')
    Password = input('Password: ')
    Address = input('Address: ')
    cursor.execute('INSERT INTO Customers(Customer_ID, CustName, Email, Password, Address) Values(?,?,?,?,?);',(ID, Name, Email, Password, Address))
    read(connection)
    connection.commit()
    
write(connection)

--#Products Entry
def read(connection):
    cursor = connection.cursor()
    print(read)
    cursor.execute('SELECT * FROM Products')
    for i in cursor:
        print(i)
    connection.commit()

def write(connection):
    cursor = connection.cursor()
    print(write)
    ID = input('Product_ID: ')
    Name = input('ProdName: ')
    Des = input('Description: ')
    Price = input('ProdPrice: ')
    Quantity = input('ProdQuant: ')
    cursor.execute('INSERT INTO Products(Product_ID, ProdName, Description, ProdPrice, ProdQuant) Values(?,?,?,?,?);',(ID, Name, Des, Price, Quantity))
    read(connection)
    connection.commit()
    
write(connection)
