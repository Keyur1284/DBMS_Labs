CREATE SCHEMA LAB2;
SET SEARCH_PATH to LAB2;

CREATE TABLE customer (
	cust_id INT NOT NULL PRIMARY KEY,
	"name" VARCHAR(30),
	city VARCHAR(30),
	"state" VARCHAR(30),
	pin INT,
	email VARCHAR(30)
);

CREATE TABLE items (
	item_code INT NOT NULL PRIMARY KEY,
	item_name VARCHAR(30),
	category_id INT,
	saleprice INT,
	qty_in_stock INT,
	reorderlevel INT,
	averagepurchaseprice INT
);

CREATE TABLE invoice (
	invno INT NOT NULL PRIMARY KEY,
	invdate DATE,
	customerid INT,
	FOREIGN KEY (customerid) REFERENCES customer (cust_id) ON DELETE SET NULL
);

CREATE TABLE invoicedetails (
	invno INT NOT NULL,
	itemcode INT NOT NULL,
	qty INT,
	rate INT,
	FOREIGN KEY (invno) REFERENCES invoice(invno) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (itemcode) REFERENCES items(item_code) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (invno, itemcode)
);

INSERT INTO customer VALUES (101, 'Ram', 'Surat', 'Gujarat', 395005, 'abc123@gmail.com');
INSERT INTO customer VALUES (102, 'Shyam', 'Baroda', 'Gujarat', 395895, 'def123@gmail.com');
INSERT INTO customer VALUES (103, 'Raj', 'Mumbai', 'Maharashtra', 395045, 'ghi123@gmail.com');
INSERT INTO customer VALUES (104, 'Jake', 'Pune', 'Maharashtra', 394705, 'jkl123@gmail.com');
INSERT INTO customer VALUES (105, 'Pedro', 'Navsari', 'Gujarat', 395235, 'mno123@gmail.com');

SELECT * FROM customer;

INSERT INTO items VALUES(11101, 'Mouse', 1, 300, 50, 5, 250);
INSERT INTO items VALUES(11102, 'Keyboard', 1, 350, 75, 6, 300);
INSERT INTO items VALUES(11103,	'Mobile', 1, 2000, 30, 3, 1900);
INSERT INTO items VALUES(11104,	'Books', 2, 60, 100, 10, 55);
INSERT INTO items VALUES(11105,	'Pen', 2, 20, 150, 15, 15);
INSERT INTO items VALUES(11106,	'Scale', 2, 10, 100, 15, 8);
INSERT INTO items VALUES(11107,	'Eraser', 2, 5, 125, 18, 5);
INSERT INTO items VALUES(11108,	'Charger', 1, 400, 70, 5, 355);
INSERT INTO items VALUES(11109,	'Earphone', 1, 450, 90, 8, 400);
INSERT INTO items VALUES(11110,	'Pouch', 2, 50, 80, 5, 40);

SELECT * FROM items;

INSERT INTO invoice VALUES(1, '2019-12-12', 101);
INSERT INTO invoice VALUES(2, '2019-12-18', 102);
INSERT INTO invoice VALUES(3, '2019-12-6', 103);
INSERT INTO invoice VALUES(4, '2019-12-9', 104);
INSERT INTO invoice VALUES(5, '2019-12-11', 105);

SELECT * FROM invoice;

INSERT INTO invoicedetails VALUES(1, 11101, 2, 290);
INSERT INTO invoicedetails VALUES(1, 11104, 5, 55);
INSERT INTO invoicedetails VALUES(2, 11108, 3, 395);
INSERT INTO invoicedetails VALUES(2, 11109, 1, 450);
INSERT INTO invoicedetails VALUES(3, 11103, 4, 1850);
INSERT INTO invoicedetails VALUES(3, 11107, 5, 4);
INSERT INTO invoicedetails VALUES(4, 11106, 1, 10);
INSERT INTO invoicedetails VALUES(4, 11102, 3, 330);
INSERT INTO invoicedetails VALUES(5, 11105, 2, 38);
INSERT INTO invoicedetails VALUES(5, 11106, 4, 8);

SELECT * FROM invoicedetails;

UPDATE items SET saleprice = 3000 WHERE item_name='Mobile';

UPDATE items SET saleprice = saleprice + (saleprice*(10.0/100));

UPDATE items SET saleprice = saleprice + (saleprice*(5.0/100)) WHERE category_id = 2;

DELETE FROM items WHERE item_code = 11101;

DELETE FROM customer WHERE cust_id = 101;

DELETE FROM invoice WHERE invdate = '2019-12-11';