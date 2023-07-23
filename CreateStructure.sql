use purchasesdb;

create table dbo.SKU
(
	ID int identity
	,Code as concat('s', convert(varchar, ID)) persisted unique
	,Name nvarchar(256) not null

	,constraint PK_SKU primary key (ID)
);

create table dbo.Family
(
	ID int identity
	,SurName nvarchar(256) not null
	,BudgetValue decimal(18, 2) not null

	,constraint PK_Family primary key (ID)
);

create table dbo.Basket
(
	ID int identity
	,ID_SKU int not null
	,ID_Family int not null
	,Quantity int not null
	,Value decimal(18, 2) not null
	,PurchaseDate date not null default(convert (date, sysdatetime()))
	,DiscountValue decimal(18, 2)

	,constraint FK_Basket_SKU foreign key (ID_SKU) references dbo.SKU (ID)
	,constraint FK_Basket_Family foreign key (ID_Family) references dbo.Family (ID)
	,constraint CHK_Basket_Quantity check(Quantity > 0)
	,constraint CHK_Basket_Value check(Value > 0)
);
