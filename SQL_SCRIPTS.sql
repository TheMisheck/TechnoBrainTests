USE [TEST_DB]
GO


----------------QUESTION 2 PART 1
CREATE TABLE [dbo].[emp-categories](
	[upper_limit] [int] NULL,
	[lower_limit] [int] NULL,
	[category] [varchar](1) NULL
) ON [PRIMARY]

GO



INSERT INTO [dbo].[emp-categories]
           ([upper_limit]
           ,[lower_limit]
           ,[category])
     VALUES
           (20000
           ,10000
           ,'A'
		   )
GO

SELECT * FROM [emp-categories]


CREATE TABLE [dbo].[emp-salary](
	[id] [int] IDENTITY (1,1),
	[name] [varchar](50) NULL,
	[salary] [int] NOT NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[emp-salary]
           ([name]
           ,[salary])
     VALUES
           ('JOE DOE'
           ,35000
		   )
GO

SELECT * FROM [emp-salary]

CREATE PROCEDURE [dbo].[UpdateEmployeeSalary]
	 @empId             INT,
	 @newSalary         INT ,
	 @oldSalary         INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
	SELECT @oldSalary = salary FROM [dbo].[emp-salary] WHERE id = @empId

	UPDATE [dbo].[emp-salary] SET salary = @newSalary   WHERE id = @empId

	SELECT @oldSalary AS [OLD_SALARY]

	SET NOCOUNT OFF;
END

Go
exec UpdateEmployeeSalary  @empId = 1, @newSalary = 15000, @oldSalary = null

----------------QUESTION 2 PART 2
 ALTER TABLE [emp-salary] ADD [category] [varchar](1) NULL


 ALTER PROCEDURE [dbo].[UpdateEmployeeCategory]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @category varchar(1);
	DECLARE @salary INT;
	DECLARE @COUNTER INT;

	 SET @COUNTER =1;

      WHILE ( @Counter <= (SELECT COUNT(id)  FROM [emp-salary]))
      BEGIN

		  SELECT @salary= salary  FROM [emp-salary] where id = @COUNTER

		  SELECT  @category = category FROM [emp-categories] WHERE  lower_limit <= @salary AND upper_limit >= @salary

		 UPDATE [emp-salary] SET category= @category WHERE id = @COUNTER

          SET @Counter  = @Counter  + 1
      
	  END


	SET NOCOUNT OFF;
END

Go
exec [UpdateEmployeeCategory]  


