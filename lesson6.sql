
/* Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds ' */

-- 1 variant
DELIMITER //
create procedure format_time(in number int)
begin
declare time_value time default sec_to_time(number);
declare n_sec int default second(time_value);
declare n_min int default minute(time_value);
declare n_hour INT default hour(time_value);
declare n_days INT default floor(n_hour/24);
set n_hour = n_hour- 24*floor(n_hour/24);
-- select time_value as "time", n_sec as "second", n_min, n_hour, n_days;
select concat(n_days,' days ',n_hour,' hours ',n_min,' minutes ',
n_sec,' seconds ') as 'your time';
end //
DELIMITER ;

-- 2 variant
DELIMITER //
create procedure format_time2(in num int)
begin
-- declare time_value time default sec_to_time(num);
declare n_min int default floor(num/60);
declare n_sec int default num-60*n_min;
declare n_hour INT default floor(num/3600);
declare n_days INT default floor(n_hour/24);
set n_min=n_min-60*n_hour;
set n_hour= n_hour-24*n_days;
-- select time_value as "time", n_sec as "second", n_min, n_hour, n_days;
select concat(n_days,' days ',n_hour,' hours ',n_min,' minutes ',
n_sec,' seconds ') as 'your time';
end //
DELIMITER ;

call format_time(98000);
call format_time2(98000);
drop procedure IF EXISTS format_time;
drop procedure IF EXISTS format_time2;

/* Создайте функцию, которая выводит только четные числа от 1 до 10. 
Пример: 2,4,6,8,10 */

drop function IF EXISTS two;

DELIMITER ??
create function two(counter int) RETURNS varchar(1000)
DETERMINISTIC
	BEGIN
    declare i int default 1;
    declare result varchar(1000) default '';
	while i<=counter do 
		set result= concat(result,' ',if(i%2=0,i,''));
        set i=i+1;
	end while;
    RETURN result;
    END??
DELIMITER 
select two(11);


