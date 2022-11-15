-- 检测数据库
DROP DATABASE IF EXISTS AddressList;
-- 创建数据库
CREATE DATABASE AddressList;
-- 使用数据库
USE AddressList;
-- 检测表
DROP TABLE IF EXISTS LinkmanType;
-- 创建表
CREATE TABLE LinkmanType(
TypeId INT PRIMARY KEY AUTO_INCREMENT,
TypeName VARCHAR(20) NOT NULL UNIQUE
)ENGINE=INNODB DEFAULT CHARSET=UTF8 AUTO_INCREMENT=101;
-- 检测表
DROP TABLE IF EXISTS LinkmanInfo;
-- 创建表
CREATE TABLE LinkmanInfo(
ID INT PRIMARY KEY AUTO_INCREMENT,
TypeId INT NOT NULL,
Age INT NOT NULL,
L_Name VARCHAR(20) NOT NULL,
Adress VARCHAR(100),
Phone VARCHAR(50),
Email VARCHAR(20),
CONSTRAINT typ_ky FOREIGN KEY(TypeId) REFERENCES LinkmanType(TypeId)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 AUTO_INCREMENT=1;
-- 初始化数据
INSERT INTO LinkmanType VALUES (DEFAULT,'陌生人');
INSERT INTO LinkmanType VALUES(DEFAULT,'好朋友');
INSERT INTO LinkmanType VALUES(DEFAULT,'老师');
INSERT INTO LinkmanType VALUES(DEFAULT,'家人');
INSERT INTO LinkmanType VALUES(DEFAULT,'同学');
-- 初始化数据
INSERT INTO LinkmanInfo VALUES(DEFAULT,101,15,'张三','湖北','11111111111','qq');
INSERT INTO LinkmanInfo VALUES(DEFAULT,102,16,'李四','湖南','22222222222','xinlang');
INSERT INTO LinkmanInfo VALUES(DEFAULT,103,20,'王五','长沙','33333333333','weibo');
INSERT INTO LinkmanInfo VALUES(DEFAULT,103,15,'赵六','北京','44444444444','qq');
INSERT INTO LinkmanInfo VALUES(DEFAULT,101,18,'田七','天津','55555555555','weibo');
-- 查讯
SELECT *FROM LinkmanType;
SELECT * FROM LinkmanInfo;

-- 1.设置字段名
SELECT Adress AS 地址 FROM LinkmanInfo;
-- 2. 字段连接
SELECT CONCAT(TypeId,Adress) AS id和地址 FROM LinkmanInfo;
-- 注：mysql 只能用concat 进行连接，而sqlservice 和oracle 还可以用+连接
-- 3.all关键字
SELECT ALL TypeId FROM LinkmanInfo;
-- 查讯所有
SELECT TypeId FROM LinkmanType;
-- 注：不加ALL一般是省略的，加了all必须后面根字段名，显示所有也可以用表示；
-- 4. limit关键字
SELECT * FROM LinkmanInfo LIMIT 0,4;
-- 注：表示查询所有中，从0个开始显示前面4个，mysql中不能用top关键字，sqlservice中一般用top 4,来取前4个
-- 5.distinct关键字
SELECT DISTINCT TypeId FROM LinkmanInfo;
-- 注：表示，有多个重复类别id时，用来查询有哪些类别
-- 6.where 关键字
SELECT * FROM LinkmanInfo WHERE TypeId>102;
-- 7. between and
SELECT * FROM LinkmanInfo WHERE TypeId BETWEEN 101 AND 102;
-- 注： 表示查询LinkmanInfo表中TypeId是101和102之间的所有的信息
-- 8.in /not in
SELECT * FROM LinkmanInfo WHERE TypeId IN(101,103);
SELECT * FROM LinkmanInfo WHERE TypeId NOT IN(101,103);
-- 9.逻辑运算符
SELECT * FROM LinkmanInfo WHERE TypeId=101 AND TypeId=102;
SELECT * FROM LinkmanInfo WHERE TypeId=101 OR TypeId=102;
-- 10. 关键字Like
SELECT * FROM LinkmanInfo WHERE Adress LIKE '湖%';
SELECT * FROM LinkmanInfo WHERE Adress LIKE '京';
-- 注: 一个""代表一个字,"%"表示0个或多个字,一般的话查询里面包含这个字的话,前后都要加%;
-- 11. 排序 order by desc/asc
SELECT * FROM LinkmanInfo ORDER BY TypeId DESC;
-- 注: 对于字符串的数字也是可以排序的,须确保位数一样,从左到右一位一位进行相比的;
-- 12.查询结果计算
SELECT AVG(age) AS 平均年龄,MAX(age) AS 最大年龄,MIN(age) AS 最小年龄,SUM(age) AS 年龄之和 FROM LinkmanInfo;
-- 13.统计个数
SELECT COUNT(*) AS 总人数 FROM LinkmanInfo;
-- 14.内部连接查询
-- 第一种
SELECT * FROM LinkmanType INNER JOIN LinkmanInfo ON LinkmanType.TypeId=LinkmanInfo.TypeId;
-- 第二种
SELECT * FROM LinkmanType t INNER JOIN LinkmanInfo i ON t.TypeId=i.TypeId;
-- 第三种
SELECT * FROM LinkmanType,LinkmanInfo WHERE LinkmanType.TypeId=LinkmanInfo.TypeId;