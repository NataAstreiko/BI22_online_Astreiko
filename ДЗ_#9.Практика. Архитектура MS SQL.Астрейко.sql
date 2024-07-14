

--*4. Создайте функцию, которая возвращает температуру в градусах Фаренгейта, при подаче на вход градусы в Цельсиях.(F = C * 9/5 +32)

CREATE FUNCTION sales.temperature3
(
	@celsius DECIMAL (5,1)
)
RETURNS DECIMAL (5,1)
AS
BEGIN 
RETURN @celsius*9/5+32;
END;

SELECT sales.temperature1(@celsius)


--Не получилось, не понимаю какая структура запроса должна быть. Делала по твоему примеру.
--При создании функции ошибки нет - Commands completed successfully
--Функция SELECT не выводится. Ошибка: Must declare the scalar variable "@celsius".
--Но когда я пытаюсь создать переменную эту - пишет, что она уже есть.


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