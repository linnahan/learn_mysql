-- 实例一
#检测表
DROP PROCEDURE IF EXISTS demo01;
#声明结束符
delimiter $$
#创建存储过程
CREATE PROCEDURE demo01()
BEGIN									 #开始

SELECT 'hello';				#输出hello

END $$							 #结束+$$

CALL demo01()				 #调用存储过程

-- 实例二
DROP PROCEDURE IF EXISTS demo02;
delimiter $$
CREATE PROCEDURE demo02()
BEGIN
DECLARE tname VARCHAR(32) DEFAULT '名字';			 #声明局部变量及变量类型，设置默认值
SELECT tname;
SET tname = "林钠瀚";				   #变量赋值
SELECT tname;
END $$

CALL demo02()

-- 实例三
DROP PROCEDURE IF EXISTS demo03;
delimiter $$
CREATE PROCEDURE demo03()
BEGIN
#将张三的Email 赋值给用户变量@email，用户变量即用即调，当前会话可用   将查询结果使用into 关键字赋值
SELECT Adress INTO @aadress FROM LinkmanInfo WHERE L_Name = '李四';
END $$
CALL demo03()
SELECT @aadress

-- 实例4
DROP PROCEDURE IF EXISTS demo04;
delimiter $$
#使用in关键字入参  in 参数名 参数类型
CREATE PROCEDURE demo04(in ccname VARCHAR(32))
BEGIN
SELECT Email INTO @eemail FROM LinkmanInfo WHERE L_Name = ccname;
SELECT @eemail;
END $$
CALL demo04('张三')

-- 实例5
#入参出参
DROP PROCEDURE IF EXISTS demo05;
delimiter $$
CREATE PROCEDURE demo05(IN a INT,IN b INT,OUT c INT)
BEGIN
SET c=a+b ;
END $$

CALL demo05(135,3636,@cc);
SELECT @cc;

-- 实例6
#inout 类型入参传参
DROP PROCEDURE IF EXISTS demo06;
delimiter $$
CREATE PROCEDURE demo06(INOUT a VARCHAR(32))
BEGIN
SELECT Adress INTO a FROM LinkmanInfo WHERE L_Name = a;
END $$
SET @aa = '李四';
CALL demo06(@aa);
SELECT @aa;

-- 实例7 IF
DROP PROCEDURE IF EXISTS demo07;
delimiter $$
CREATE PROCEDURE demo07(IN nname VARCHAR(32))
BEGIN
 DECLARE aage INT DEFAULT 0;
 DECLARE result VARCHAR(32) DEFAULT '666';
 SELECT Age INTO aage FROM LinkmanInfo WHERE L_Name = nname;
	IF aage<18 THEN
		SET result = '未成年';
	ELSEIF aage>= 18 AND aage <30 THEN
		SET result = '中年';
	ELSE
		SET result = '老人';
	end IF;
	SELECT result;
END $$

CALL demo07('张三');

-- 实例8  LOOP循环
DROP PROCEDURE IF EXISTS demo08;
delimiter $$
CREATE PROCEDURE demo08()
BEGIN
SET @a = 1;
loop_1 : LOOP
SELECT @a;
IF @a >= 10 THEN 
LEAVE loop_1;
END IF;
SET @a = @a + 1;
END LOOP loop_1;
END $$

CALL demo08();

-- 实例9
DROP PROCEDURE IF EXISTS demo09;
delimiter $$
CREATE PROCEDURE demo09()
BEGIN
	SET @res = '1';
	SET @a = 1;
	WHILE @a < 10 DO
	SET @a = @a + 1;
	SET @res = CONCAT(@res,",",@a);
	END WHILE;
SELECT @res;
END $$

CALL demo09();

-- 练习
#定义一个存储过程，在linkmanInfo插入一条数据，数据内容在调用时入参;
DROP PROCEDURE IF EXISTS demo1;
delimiter $$
CREATE PROCEDURE demo1(IN a INT,IN b INT,IN c INT,IN d VARCHAR(32),IN e VARCHAR(32),IN f VARCHAR(32),IN g VARCHAR(32))
BEGIN
INSERT INTO LinkmanInfo VALUES (a,b,c,d,e,f,g);
END $$

CALL demo1(25,101,15,'林','广东','66666666666','qq')

#定义一个存储过程，传入任意L_name的姓名，查询该人员的typeId和Age;
DROP PROCEDURE IF EXISTS demo2;
delimiter $$
CREATE PROCEDURE demo2(IN a VARCHAR(32))
BEGIN
SELECT TypeId,Age  FROM LinkmanInfo WHERE L_Name = a;
END $$

CALL demo2('张三')

#定义一个存储过程，判断某个人的email类型，如果是weibo，打印输出姓名和电话，如果是qq，打印输出姓名和id，如果是xinlang，打印输出“不符合要求”
DROP PROCEDURE IF EXISTS demo3;
delimiter $$
CREATE PROCEDURE demo3(IN nname VARCHAR(32))
BEGIN
DECLARE el VARCHAR(32);
DECLARE result VARCHAR(32);
SELECT Email INTO el FROM LinkmanInfo WHERE L_Name = nname;
IF el = 'weibo' THEN
	SELECT L_Name,Phone FROM LinkmanInfo WHERE L_Name = nname;
ELSEIF el = 'qq' THEN
	SELECT L_Name,ID FROM LinkmanInfo WHERE L_Name = nname;
ELSEIF el = 'xinlang' THEN
	SELECT "不符合要求";
END IF;
END $$

CALL demo3('王五')

#使用loop循环打印出linkmaninfo表email类型是qq的所有信息。
DROP PROCEDURE IF EXISTS demo4;
delimiter $$
CREATE PROCEDURE demo4(IN aa VARCHAR(32))
BEGIN
SET @id = 0;
loop_1 : LOOP
IF (SELECT Email FROM LinkmanInfo WHERE ID = @id) = aa THEN
SELECT * FROM LinkmanInfo WHERE ID = @id;
ELSEIF @id > 30 THEN
LEAVE loop_1;
END IF;
SET @id = @id + 1;
END LOOP loop_1;
END $$

CALL demo4('qq');


drop PROCEDURE if EXISTS demo5;
delimiter $$
CREATE PROCEDURE demo5(in uemail VARCHAR(32))
BEGIN
SELECT count(*) into @a from LinkmanInfo;
SELECT ID into @b FROM LinkmanInfo LIMIT 1;
SELECT ID INTO @d FROM LinkmanInfo ORDER BY ID DESC LIMIT 1;
set @c=@b+(@d-@a);
loop_1:loop
SELECT Email into @eemail from LinkmanInfo WHERE ID=@b;
if @b>=@c+@a THEN
LEAVE loop_1;
elseif @eemail=uemail then
SELECT * from LinkmanInfo WHERE ID=@b;
end if;
set @b=@b+1;
END loop loop_1;
end $$


call demo5("qq");

#定义一个存储过程，使用循环将linkmaninfo表Phone值后面都加一个0
DROP PROCEDURE IF EXISTS demo5;
delimiter $$
CREATE PROCEDURE demo5()
BEGIN
SELECT count(*) into @a from LinkmanInfo;
SELECT ID into @b FROM LinkmanInfo LIMIT 1;
SELECT ID INTO @d FROM LinkmanInfo ORDER BY ID DESC LIMIT 1;
set @c=@b+(@d-@a);
WHILE  @b<=@c+@a DO
SELECT Phone INTO @t FROM LinkmanInfo WHERE ID = @b;
UPDATE LinkmanInfo SET Phone = CONCAT(@t,	0) WHERE ID=@b;
set @b=@b+1;
END WHILE;
END $$

CALL demo5();

UPDATE LinkmanInfo SET Phone = '8888888888';
	
drop PROCEDURE if EXISTS demo11;
delimiter $$
CREATE PROCEDURE demo11()
BEGIN
DECLARE b int DEFAULT 0;
SELECT COUNT(*) into @a  from LinkmanInfo;
WHILE b<@a DO
SELECT Phone into @d from LinkmanInfo LIMIT b,1;
UPDATE LinkmanInfo set Phone=CONCAT(@d,0) WHERE Phone=@d;
set b=b+1;
END WHILE;
end$$
call demo11();