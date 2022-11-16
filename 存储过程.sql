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
DROP PROCEDURE IF EXISTS demo02;
delimiter $$
CREATE PROCEDURE demo02(IN a VARCHAR(32))
BEGIN
SELECT TypeId,Age  FROM LinkmanInfo WHERE L_Name = a;
END $$

CALL demo02('张三')