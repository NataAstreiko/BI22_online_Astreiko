

--*4. Создайте функцию, которая возвращает температуру в градусах Фаренгейта, при подаче на вход градусы в Цельсиях.(F = C * 9/5 +32)


GO
CREATE FUNCTION functi(@temp_c DECIMAL(5,1))
RETURNS DECIMAL(5,1)
AS
BEGIN
	DECLARE @temp_f DECIMAL(5,1);
	SET @temp_f = @temp_c*9/5+32
	RETURN @temp_f;
END;
GO

SELECT dbo.functi(10.5) as results


--**5. Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена (используем функцию текущей даты и идем от нее)

SELECT DATEPART(dw,GETDATE() - day(GETDATE())+1) as number_of_the_weekday,
CASE 
WHEN DATEPART(dw,GETDATE() - day(GETDATE())+1) between 2 and 6
THEN GETDATE() - day (GETDATE())+1

WHEN DATEPART(dw,GETDATE() - day(GETDATE())+1) = 1
THEN DATEPART(dw,GETDATE() - day(GETDATE())+1+1)

WHEN DATEPART(dw,GETDATE() - day(GETDATE())+1) = 7
THEN DATEPART(dw,GETDATE() - day(GETDATE())+1+2)
END as first_working_day
