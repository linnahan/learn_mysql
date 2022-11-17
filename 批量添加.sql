#编写存储过程
DROP PROCEDURE IF EXISTS procedure_test;
DELIMITER $ #这一步是因为，正常的sql中是以分号（;）为结尾，遇见分号就说明该段sql执行完了，但是在存储过程中很明显遇见分号，并没有执行完成，所以该段语句则为将结束语句的标识符（;）替换为（$）,数据库中一般用$或者//代替;
CREATE PROCEDURE procedure_test() #创建存储过程
BEGIN
    DECLARE i INT DEFAULT 1; #声明变量
    WHILE i <= 10 DO
    insert into LinkmanInfo ( ID,TypeId,Age,L_Name,Adress,Phone,Email)
    values (i+30, 105,18,CONCAT('zhangsan',i),'江西',88888888,'wx');
    SET i = i+1;
    END WHILE;
END $
CALL procedure_test(); #调用存储过程