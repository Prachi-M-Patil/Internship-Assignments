--Tables--

create table TblCustomers_2(
customerId int Primary Key,
customerName varchar(50),
Email varchar(50),
PhoneNumber varchar(20)
);

create table TblAccounts(
accountId int Primary Key,
customerId int,
AccountNumber varchar(30),
Balance Decimal(10,2),
AccountType varchar(40)
);

ALTER TABLE TblAccounts
ADD CONSTRAINT FK_TblAccounts_Customers
FOREIGN KEY (customerId) REFERENCES TblCustomers(customerId);

create table TblTransactions(
TransactionId int Primary key,
accountId int,
transactionType varchar(40),
amount Decimal(10,2),
transactionDate date
CONSTRAINT FK_Account FOREIGN KEY (accountId) REFERENCES TblAccounts(accountId)

);

create table Tbl_Audit_Transactions(
auditId int primary key,
accountId int,
amount decimal(10,2),
transactionDate date,
action NVARCHAR(50),
CONSTRAINT FK_Account_tble FOREIGN KEY (accountId) REFERENCES TblAccounts(accountId)

);

ALTER TABLE Tbl_Audit_Transactions
ALTER COLUMN transactionDate DATETIME NOT NULL;
ALTER TABLE Tbl_Audit_Transactions
ADD CONSTRAINT DF_Tbl_Audit_Transactions_transactionDate DEFAULT GETDATE() FOR transactionDate;

---Indexing---

DECLARE @i INT = 1;

WHILE @i <= 300
BEGIN
    INSERT INTO TblCustomers (customerId, customerName, Email, PhoneNumber)
    VALUES (@i, 'Customer ' + CAST(@i AS NVARCHAR(10)), 'customer' + CAST(@i AS NVARCHAR(10)) + '@example.com', '1234567890');
    SET @i = @i + 1;
END;


DECLARE @i INT = 1;

WHILE @i <= 300
BEGIN
    INSERT INTO TblAccounts (accountId, customerId, AccountNumber, Balance, AccountType)
    VALUES (@i, @i, 'ACC' + RIGHT('000' + CAST(@i AS NVARCHAR(10)), 3), RAND() * 10000, 'Savings');
    SET @i = @i + 1;
END;

DECLARE @i INT = 1;

WHILE @i <= 300
BEGIN
    -- Ensure accountId exists in TblAccounts
    IF EXISTS (SELECT 1 FROM TblAccounts WHERE accountId = @i)
    BEGIN
        INSERT INTO TblTransactions (TransactionId, accountId, transactionType, amount, transactionDate)
        VALUES (@i, @i, 'Deposit', RAND() * 1000, GETDATE());
    END
    SET @i = @i + 1;
END;



DECLARE @i INT = 1;

WHILE @i <= 300
BEGIN
    -- Ensure accountId exists in TblAccounts
    IF EXISTS (SELECT 1 FROM TblAccounts WHERE accountId = @i)
    BEGIN
        INSERT INTO Tbl_Audit_Transactions (auditId, accountId, amount, transactionDate, action)
        VALUES (@i, @i, RAND() * 1000, GETDATE(), 'Insert');
    END
    SET @i = @i + 1;
END;

--Task 1--
--clustered index--
CREATE CLUSTERED INDEX IX_Customer_Id ON TblCustomers(customerId);

--non-clustered index--
create nonclustered index IX_Customer_CustomerName On TblCustomers(customerName);

--composite index--
create nonclustered index IX_Transaction_Date_amount On TblTransactions(transactionDate, amount);

--unique index--
create unique index IX_accounts_accountNumber on TblAccounts(AccountNumber);

EXEC sp_helpindex 'TblCustomers';

--verify indexes--
Select * from sys.indexes where object_id = OBJECT_ID('TblAccounts');


--Task 2--
Go
CREATE FUNCTION fn_CalculateInterest_1 (@accountId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Balance DECIMAL(10, 2);
    DECLARE @Interest DECIMAL(10, 2);

    -- Get the balance for the given accountId
    SELECT @Balance = Balance
    FROM TblAccounts
    WHERE accountId = @accountId;

    -- Calculate interest at an annual rate of 5%
    SET @Interest = @Balance * 0.05;

    RETURN @Interest;
END;

--function in select query--
select accountId, Balance, dbo.fn_CalculateInterest_1(accountId) As Interest
from TblAccounts;


--task3--
--create stored procedure for transactions--
Go
create procedure TransferMoneyProcedure
	@FromAccountId int,
	@ToAccountId int,
	@Amount Decimal(10,2)
As
Begin
	Declare @FromBalance Decimal(10,2);

	Select @FromBalance = Balance from TblAccounts where accountId = @FromAccountId;

	If @FromBalance is null or @ToAccountId is null
	Begin
		PRINT 'Invalid account id. Transaction aborted';
		RETURN;
	END;

	If @FromBalance < @Amount
	Begin
		PRINT 'Insufficient Funds';
		REturn;
	END;

	Begin Transaction;

	update TblAccounts set Balance = Balance - @Amount where accountId = @FromAccountId;
	update TblAccounts set Balance = Balance + @Amount where accountId = @ToAccountId;

	Insert into TblTransactions(accountId, transactionType, amount, transactionDate)
	values  (@FromAccountId, 'Debit', @Amount, getDate()),
			(@ToAccountId, 'Credit', @Amount, getDate());

	Commit Transaction;

	PRINT 'Transfer Successful.';

END;


Exec TransferMoneyProcedure @FromAccountId = 1, @ToAccountId= 2, @Amount = 1000.00; 


Select * from TblAccounts;

--task 4--
Go
create trigger PreventOverDraft
On TblAccounts
Instead of Update
As
Begin
	if Exists(
		select 1 from inserted i
		Join deleted d on i.accountId = d.accountId
		where i.Balance < 0
	)
	Begin
		Print 'Insufficient balance';
		Rollback Transaction;
		return;
	End

	Update TblAccounts
	Set Balance = i.Balance
	from TblAccounts a
	Join inserted i On a.accountId = i.accountId;
End;

update TblAccounts
Set Balance  = Balance - 200
where accountId = 1;

update TblAccounts
Set Balance  = Balance - 76000
where accountId = 1;



--task 5--
Go
CREATE Trigger trg_AuditTransactions
On TblTransactions
After Insert
As
Begin
	Insert Into Tbl_Audit_Transactions (accountId , amount, transactionDate, action)
	Select 
	i.accountId,
	i.amount,
	i.transactionDate,
	case
		when i.transactionType = 'Deposit' then 'Deposit'
		when i.transactionType = 'Withdrawal' then 'Withdrawal'
		when i.transactionType = 'Transfer' then 'Transfer'
		Else 'Unknown'
	END
from inserted i;
END;


select * from Tbl_Audit_Transactions;
select * from TblTransactions;

insert into TblTransactions(TransactionId, accountId, transactionType, amount) values (780,1, 'Deposit' , 5000.00);
