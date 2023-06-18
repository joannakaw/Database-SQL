--CREATING DATABASE
/*Chcecking whether database already exists */

IF EXISTS (SELECT * FROM sys.databases WHERE name='PizzaStoreDB')
DROP DATABASE PizzaStoreDB
GO

/* Creating database PizzaStoreDB */
CREATE DATABASE PizzaStoreDB
GO
USE PizzaStoreDB
GO


/* Creating tables and constraint */

IF EXISTS (SELECT * FROM sys.tables WHERE name='Orders')
DROP TABLE Orders
GO

CREATE TABLE Orders (
    row_id int  NOT NULL ,
    order_id varchar(10)  NOT NULL ,
    order_date datetime  NOT NULL ,
    product_id int  NOT NULL ,
    quantity int  NOT NULL ,
    cust_id int  NOT NULL ,
    emp_id int  NOT NULL ,
	receipt_id int NOT NULL,
    delivery bit  NOT NULL ,
    address_id int  NOT NULL ,
    CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED (
        row_id ASC
    )
)

IF EXISTS (SELECT * FROM sys.tables WHERE name='Customers')
DROP TABLE Customers
GO

CREATE TABLE Customers (
    cust_id int  NOT NULL ,
    customer_firstname varchar(50)  NOT NULL ,
    customer_lastname varchar(50)  NOT NULL ,
    phone varchar(15)  NOT NULL ,
    email varchar(50) ,
    adress_id int  NOT NULL ,
    CONSTRAINT PK_Customers PRIMARY KEY CLUSTERED (
        cust_id ASC
    ),
    CONSTRAINT UK_Customers_phone UNIQUE (
        phone
    ),
    CONSTRAINT UK_Customers_email UNIQUE (
        email
    )
)

IF EXISTS (SELECT * FROM sys.tables WHERE name='Address')
DROP TABLE Address
GO

CREATE TABLE Address (
    address_id int  NOT NULL ,
    delivery_adress varchar(150)  NOT NULL ,
    delivery_city varchar(50)  NOT NULL ,
    delivery_zipcode varchar(10)  NOT NULL ,
    CONSTRAINT PK_Address PRIMARY KEY CLUSTERED (
        address_id ASC
    )
)

IF EXISTS (SELECT * FROM sys.tables WHERE name='Product')
DROP TABLE Product
GO

CREATE TABLE Product (
    product_id int  NOT NULL ,
    product_name varchar(50)  NOT NULL ,
    product_category varchar(50)  NOT NULL ,
    product_size varchar(20)  NOT NULL ,
    product_price decimal(4,2)  NOT NULL ,
    CONSTRAINT PK_Product PRIMARY KEY CLUSTERED (
        product_id ASC
    )
)

IF EXISTS (SELECT * FROM sys.tables WHERE name='Employees')
DROP TABLE Employees
GO

CREATE TABLE Employees (
    emp_id int  NOT NULL ,
    first_name varchar(50)  NOT NULL ,
    last_name varchar(50)  NOT NULL ,
    position varchar(50)  NOT NULL ,
    CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (
        emp_id ASC
    )
)

IF EXISTS (SELECT * FROM sys.tables WHERE name='Payment')
DROP TABLE Payment
GO

CREATE TABLE Payment (
    receipt_id int  NOT NULL ,
    order_id int  NOT NULL ,
    payment_type varchar(20)  NOT NULL ,
    payment_amount decimal(5,2)  NOT NULL ,
    payment_date datetime  NOT NULL ,
    CONSTRAINT PK_Payment PRIMARY KEY CLUSTERED (
        receipt_id ASC
    )
)

/* Creating constraints */
ALTER TABLE Orders ADD FOREIGN KEY (cust_id) REFERENCES Customers (cust_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Orders ADD FOREIGN KEY (address_id) REFERENCES Address (address_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Orders ADD FOREIGN KEY (product_id) REFERENCES Product (product_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Orders ADD FOREIGN KEY (emp_id) REFERENCES Employees (emp_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Orders ADD FOREIGN KEY (receipt_id) REFERENCES Payment (receipt_id) ON UPDATE CASCADE ON DELETE CASCADE;

/* Creating view all customers with total number of orders */

/* Creating view all products */

