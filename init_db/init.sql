CREATE TABLE public.regions (
	"regionID" int4 NOT NULL,
	"regionDescription" varchar(50) NULL,
	CONSTRAINT regions_pkey PRIMARY KEY ("regionID")
);
CREATE TABLE public.territories (
	"territoryID" int4 NOT NULL,
	"territoryDescription" varchar(50) NULL,
	"regionID" int4 NULL,
	CONSTRAINT territories_pkey PRIMARY KEY ("territoryID"),
	CONSTRAINT fk_regionid FOREIGN KEY ("regionID") REFERENCES public.regions("regionID")
);
CREATE TABLE public.customers (
	"customerID" varchar(50) NOT NULL,
	"companyName" varchar(50) NULL,
	"contactName" varchar(50) NULL,
	"contactTitle" varchar(50) NULL,
	address varchar(50) NULL,
	city varchar(50) NULL,
	region varchar(50) NULL,
	"postalCode" varchar(50) NULL,
	country varchar(50) NULL,
	phone varchar(50) NULL,
	fax varchar(50) NULL,
	CONSTRAINT customers_pkey PRIMARY KEY ("customerID")
);
CREATE TABLE public.shippers (
	"shipperID" int4 NOT NULL,
	"companyName" varchar(50) NULL,
	phone varchar(50) NULL,
	CONSTRAINT shippers_pkey PRIMARY KEY ("shipperID")
);
CREATE TABLE public.employees (
	"employeeID" int4 NOT NULL,
	"lastName" varchar(50) NULL,
	"firstName" varchar(50) NULL,
	title varchar(50) NULL,
	"titleOfCourtesy" varchar(50) NULL,
	"birthDate" varchar(50) NULL,
	"hireDate" varchar(50) NULL,
	address varchar(50) NULL,
	city varchar(50) NULL,
	region varchar(50) NULL,
	"postalCode" varchar(50) NULL,
	country varchar(50) NULL,
	"homePhone" varchar(50) NULL,
	"extension" int4 NULL,
	photo varchar(256) NULL,
	notes varchar(256) NULL,
	"reportsTo" varchar(50) NULL,
	"photoPath" varchar(50) NULL,
	CONSTRAINT employees_pkey PRIMARY KEY ("employeeID")
);
CREATE TABLE public.categories (
	"categoryID" int4 NOT NULL,
	"categoryName" varchar(50) NULL,
	description varchar(64) NULL,
	picture varchar(256) NULL,
	CONSTRAINT categories_pkey PRIMARY KEY ("categoryID")
);
CREATE TABLE public.suppliers (
	"supplierID" int4 NOT NULL,
	"companyName" varchar(50) NULL,
	"contactName" varchar(50) NULL,
	"contactTitle" varchar(50) NULL,
	address varchar(50) NULL,
	city varchar(50) NULL,
	region varchar(50) NULL,
	"postalCode" varchar(50) NULL,
	country varchar(50) NULL,
	phone varchar(50) NULL,
	fax varchar(50) NULL,
	"homePage" varchar(128) NULL,
	CONSTRAINT suppliers_pkey PRIMARY KEY ("supplierID")
);
CREATE TABLE public.products (
	"productID" int4 NOT NULL,
	"productName" varchar(50) NULL,
	"supplierID" int4 NULL,
	"categoryID" int4 NULL,
	"quantityPerUnit" varchar(50) NULL,
	"unitPrice" float4 NULL,
	"unitsInStock" int4 NULL,
	"unitsOnOrder" int4 NULL,
	"reorderLevel" int4 NULL,
	discontinued int4 NULL,
	CONSTRAINT products_pkey PRIMARY KEY ("productID"),
	CONSTRAINT fk_categoryid FOREIGN KEY ("categoryID") REFERENCES public.categories("categoryID"),
	CONSTRAINT fk_supplierid FOREIGN KEY ("supplierID") REFERENCES public.suppliers("supplierID")
);
CREATE TABLE public.employee_territories (
	"employeeID" int4 NOT NULL,
	"territoryID" int4 NOT NULL,
	CONSTRAINT employee_territories_pkey PRIMARY KEY ("employeeID", "territoryID"),
	CONSTRAINT fk_employeeid FOREIGN KEY ("employeeID") REFERENCES public.employees("employeeID"),
	CONSTRAINT fk_territoryid FOREIGN KEY ("territoryID") REFERENCES public.territories("territoryID")
);
CREATE TABLE public.orders (
	"orderID" int4 NOT NULL,
	"customerID" varchar(50) NULL,
	"employeeID" int4 NULL,
	"orderDate" varchar(50) NULL,
	"requiredDate" varchar(50) NULL,
	"shippedDate" varchar(50) NULL,
	"shipVia" int4 NULL,
	freight float4 NULL,
	"shipName" varchar(50) NULL,
	"shipAddress" varchar(50) NULL,
	"shipCity" varchar(50) NULL,
	"shipRegion" varchar(50) NULL,
	"shipPostalCode" varchar(50) NULL,
	"shipCountry" varchar(50) NULL,
	CONSTRAINT orders_pkey PRIMARY KEY ("orderID"),
	CONSTRAINT fk_customerid FOREIGN KEY ("customerID") REFERENCES public.customers("customerID"),
	CONSTRAINT fk_employeeid FOREIGN KEY ("employeeID") REFERENCES public.employees("employeeID"),
	CONSTRAINT fk_shipperid FOREIGN KEY ("shipVia") REFERENCES public.shippers("shipperID")
);
CREATE TABLE public.order_details (
	"orderID" int4 NOT NULL,
	"productID" int4 NOT NULL,
	"unitPrice" float4 NULL,
	quantity int4 NULL,
	discount int4 NULL,
	CONSTRAINT order_details_pkey PRIMARY KEY ("orderID", "productID"),
	CONSTRAINT fk_orderid FOREIGN KEY ("orderID") REFERENCES public.orders("orderID"),
	CONSTRAINT fk_productid FOREIGN KEY ("productID") REFERENCES public.products("productID")
);