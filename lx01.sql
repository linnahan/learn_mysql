-- 1、student表数据
DROP TABLE  if EXISTS student;
CREATE TABLE student(
Sno int(8),
Sname VARCHAR(32),
Ssex  VARCHAR(32),
Sage  int(8),
Sdept VARCHAR(32)
);

insert into student values('9512101','李勇','男',19,'计算机系'),('9512102','刘晨','男',20,'计算机系'),('9512103','王敏','女',20,'计算机系'),('9521101','张立','男',22,'信息系'),('9521102','吴宾','女',21,'信息系'),('9521103','张海','男',20,'信息系'),('9531101','钱小平','女',18,'数学系'),('9531102','王大力','男',19,'数学系');

-- 2、course表数据
DROP table if EXISTS course;
CREATE TABLE course(
Cno VARCHAR(32),
Cname VARCHAR(32),
Ccredit int(8),
Semster int(8)
);

insert into course(Cno,Cname,Ccredit,Semster)values('C01','计算机文化学',3,1),('C02','VB',2,3),('C03','计算机网络',4,7),('C04','数据库基础',6,6),('C05','高等数学',8,2),('C06','数据结构',5,4);

-- 3、sc表数据
DROP table if EXISTS sc;
CREATE  TABLE sc(
Sno int(8),
Cno VARCHAR(32),
Grade int(8),
XKLB VARCHAR(32)
);

insert into sc values('9512101','c01',90,'必修'),('9512101','c02',86,'选修'),('9512101','c06',NULL,'必修'),('9512102','c02',78,'选修'),('9512102','c04',66,'必修'),('9521102','c01',82,'选修'),('9521102','c02',75,'选修'),('9521102','c04',92,'必修'),('9521102','c05',50,'必修'),('9521103','c02',68,'选修'),('9521103','c06',NULL,'必修'),('9531101','c01',80,'选修'),('9531101','c05',95,'必修'),('9531102','c05',85,'必修');

-- 一、单表查询
1.查询全体学生的学号与姓名
SELECT Sno,Sname FROM student;
2.查询计算机系全体学生的姓名
SELECT Sname FROM student WHERE Sdept = "计算机系";
3.查询所有年龄在20岁以下的学生的姓名及年龄
SELECT Sname,Sage FROM student WHERE Sage < 20;
4.查询考试成绩不及格的学生的姓名
SELECT Sname FROM student where Sno IN (SELECT Sno FROM sc WHERE Grade < 60);
5.查询年龄在20~23岁之间的学生的姓名，所在系和年龄
SELECT Sdept,Sage FROM student WHERE Sage BETWEEN 20 AND 23;
6.查询年龄不在20~23之间的学生的姓名，所在系和年龄
SELECT Sdept,Sage FROM student WHERE Sage NOT BETWEEN 20 AND 23;
7.查询信息系，数学系和计算机系学生的姓名和性别
SELECT Sname,Ssex FROM student WHERE Sdept IN ('信息系','数学系','计算机系');
8.查询学生表中姓“张”的学生的详细信息
SELECT * FROM student WHERE Sname LIKE "张%";
9.查询学生表中姓“张”，姓“李”和姓“刘”的学生的情况
SELECT * FROM student WHERE Sname LIKE "张%" OR Sname LIKE "刘%" OR Sname LIKE "李%";
10.查询名字中第2个字为“小”或“大”字的学生的姓名和学号
SELECT Sname,Sno FROM student WHERE Sname LIKE "_小%" OR Sname LIKE "_大%";
11.查询所有不姓“刘”的学生的姓名
SELECT * FROM student WHERE Sname NOT LIKE "刘%"; 
12.查询无考试成绩的学生的学号和相应的课程号
SELECT a.Sno,b.Cno FROM student a,sc b WHERE a.Sno = b.Sno AND b.Grade IS NULL ;
13.查询所有有考试成绩的学生的学号和课程号
SELECT student.Sno,sc.Cno FROM student,sc WHERE student.Sno = sc.Sno;
14.查询计算机系年龄在20岁以下的学生的姓名，将学生按年龄升序排序
SELECT Sname FROM student WHERE Sdept = "计算机系" AND Sage < 20 ORDER BY Sage ASC;
15.查询选修了课程“c02”的学生的学号及其成绩，查询结果按成绩降序排列
SELECT a.Sno,b.Grade FROM student a,sc b WHERE a.Sno = b.Sno AND b.Cno = "c02"  ORDER BY b.Grade DESC;
16.查询全体学生的信息，查询结果按所在系的系名升序排列，同一系的学生按年龄降序排列
SELECT * FROM student ORDER BY Sdept ASC,Sage DESC;

二、多表查询
17.查询每个学生的情况及其选课的情况
SELECT a.Sno,a.Sname,a.Sage,a.Ssex,a.Sdept,c.Cno,c.Cname,c.Ccredit,c.Semster FROM student a,sc b,course c WHERE a.Sno = b.Sno AND b.Cno = c.Cno; 
18.查询计算机系学生的选课情况，要求列出学生的名字，所修课的课程号和成绩
SELECT a.Sname,b.Cno,b.Grade FROM student a,sc b WHERE a.Sno = b.Sno AND a.Sdept = '计算机系';
19.查询信息系选修VB课程的学生的成绩，要求列出学生姓名，课程名和成绩
SELECT a.Sname,c.Cname,b.Grade FROM student a,sc b,course c WHERE a.Sno = b.Sno AND b.Cno = c.Cno AND a.Sdept = '信息系' AND b.XKLB = "选修" AND c.Cname = "VB";
20.查询所有选修了VB课程的学生的情况，要求列出学生姓名和所在的系
SELECT Sname,Sdept FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Cno IN (SELECT Cno FROM course WHERE Cname = "VB"));
21.查询与刘晨在同一个系学习的学生的姓名和所在系
SELECT Sname,Sdept FROM student WHERE Sdept IN (SELECT Sdept FROM student WHERE Sname = "刘晨");
22.查询学生的选课情况，包括选修课程的学生和没有修课的学生
SELECT a.Sname,b.Cno FROM student a, sc b WHERE a.Sno = b.Sno AND (b.XKLB = '选修' OR b.XKLB IS NULL);
23.查询数学系成绩在80分以上的学生的学号，姓名
SELECT Sno,Sname FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Grade > 80) AND Sdept = '数学系';
24.查询计算机系考试成绩最高的学生的姓名
SELECT Sname FROM student WHERE Sdept = '计算机系' AND Sno = (SELECT Sno FROM sc WHERE Grade = (SELECT max(Grade) FROM sc WHERE Sno IN (SELECT Sno FROM student WHERE Sdept = '计算机系')));
三、函数
25.统计学生总人数
SELECT count(*) FROM student;
26.统计选修了选修课程的学生的人数
SELECT count(*) FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE XKLB = '选修');
27.计算学号为9512101的学生的考试总成绩之和
SELECT sum(Grade) FROM sc WHERE Sno = 9512101;
28.计算课程“c01”的学生的考试平均成绩
SELECT avg(Grade) FROM sc WHERE Cno = 'c01';
29.查询选修了课程“c01”的学生的最高分和最低分
SELECT max(Grade),min(Grade) FROM sc WHERE Cno = "c01" AND XKLB = '选修';
30.统计每门课程的选课人数，列出课程号和人数
SELECT Cno,count(*) FROM sc GROUP BY Cno;
31.查询每名学生的选课门数和平均成绩
SELECT count(*),avg(Grade) FROM sc GROUP BY Sno;
32.查询选了3门以上课程的学生的学号
SELECT Sno FROM sc GROUP BY Sno HAVING count(*) > 3;
33.查询选课门数等于或大于4门的学生的平均成绩和选课门数
SELECT avg(Grade),count(*) FROM sc GROUP BY Sno HAVING count(*) >= 4;
四、嵌套子查询
34.查询成绩大于90分的学生的学号和姓名
SELECT Sno,Sname FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Grade > 90);
35.查询选修了“数据库基础”课程的学生的学号和姓名
SELECT Sno,Sname FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Cno IN (SELECT Cno FROM course WHERE Cname = '数据库基础'));
36.查询选修了刘晨没有选修的课程的学生的学号和所在系
SELECT Sno,Sdept FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Cno NOT IN (SELECT Cno FROM sc WHERE Sno = (SELECT Sno FROM student WHERE Sname = '刘晨')));
37.查询选修了课程“c02”且成绩高于此课程的平均成绩的学生的学号和成绩
SELECT a.Sno,b.Grade FROM student a,sc b WHERE a.Sno = b.Sno AND b.Cno = 'c02' AND b.Grade > (SELECT avg(Grade) FROM sc WHERE Cno = 'c02'); 
38.查询选修了课程“c01”的学生姓名
SELECT Sname FROM student WHERE Sno IN (SELECT Sno FROM sc WHERE Cno = 'c01');
五、修改数据
39.将所有学生的年龄加1
UPDATE student SET Sage = Sage + 1;
40.将“9512101”学生的年龄改为21岁
UPDATE student SET Sage = 21 WHERE Sno = 9512101;
41.将计算机系学生的成绩加5分
UPDATE sc SET Grade = Grade + 5 WHERE Sno IN (SELECT Sno FROM student WHERE Sdept = '计算机系');
六、删除数据
42.删除所有学生的选课记录
DELETE FROM sc;
43.删除所有不及格学生的选课记录
DELETE  FROM sc WHERE Grade < 60;
44.删除计算机系不及格学生的选课记录
DELETE FROM sc WHERE Sno IN (SELECT Sno FROM student WHERE Sdept = '计算机系') AND Grade < 60;
