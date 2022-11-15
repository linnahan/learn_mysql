/*创建表 emp*/
create table emp (
    empno int(11),
    ename varchar(22),
   job varchar(22),
    mgr int,
    hiredate date,
    sal double(11,2),
    comm double(11,2),
    deptno int
)default charset=utf8;
/*添加数据*/
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7369, 'SMITH', 'CLERK', 7902, NULL, 800.00, NULL, 20);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, NULL, 1600.00, NULL, 30);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7521, 'WARD', 'SALESMAN', 7698, NULL, 1250.00, NULL, 30);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7566, 'JONES', 'MANAGER', 7839, NULL, 2975.00, NULL, 20);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, NULL, 1250.00, NULL, 30);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7698, 'BLAKE', 'MANAGER', 7839, NULL, 2850.00, NULL, 30);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7782, 'CLARK', 'MANAGER', 7839, NULL, 2450.00, NULL, 10);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7788, 'SCOTT', 'ANALYST', 7566, NULL, 3000.00, NULL, 20);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7839, 'KING', NULL, NULL, NULL, 5000.00, NULL, NULL);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7844, 'TURNER', 'SALESMAN', 7698, NULL, 1500.00, NULL, 30);
INSERT INTO `emp`(`empno`, `ename`, `job`, `mgr`, `hiredate`, `sal`, `comm`, `deptno`) VALUES (7876, 'ADAMS', 'CLERK', 7788, NULL, 1100.00, NULL, 20);


/*创建表 dept*/
create table dept (
	deptno int(11),
    dname varchar(22),
    loc varchar(22)
);
/*添加数据*/
INSERT INTO `dept`(`deptno`, `dname`, `loc`) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO `dept`(`deptno`, `dname`, `loc`) VALUES (20, 'RESEARCE', 'DAKKAS');
INSERT INTO `dept`(`deptno`, `dname`, `loc`) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO `dept`(`deptno`, `dname`, `loc`) VALUES (40, 'OPERATIONS', 'BOSTON');


/*创建表 salgrade*/
create table salgrade(
	grade int(11),
    losal int(11),
    hisal int(11)
);
/*添加数据*/
INSERT INTO `salgrade`(`grade`, `losal`, `hisal`) VALUES (1, 700, 1200);
INSERT INTO `salgrade`(`grade`, `losal`, `hisal`) VALUES (2, 1201, 1400);
INSERT INTO `salgrade`(`grade`, `losal`, `hisal`) VALUES (3, 1400, 2000);
INSERT INTO `salgrade`(`grade`, `losal`, `hisal`) VALUES (4, 2001, 3000);
INSERT INTO `salgrade`(`grade`, `losal`, `hisal`) VALUES (5, 3001, 9999);

-- 题目
/**查询工资等于5000的员工姓名
*/
SELECT ename FROM emp WHERE sal = 5000;
/**查询emp表中工资大于1100,小于3000的员工
*/
SELECT * FROM emp WHERE sal BETWEEN 1100 and 3000;
/**
	找出工作岗位是manager和salesman的员工
*/
SELECT * FROM emp WHERE job IN ('MANAGER','SALESMAN');
/**
	找出薪资是1000和5000的员工
*/
SELECT * FROM emp WHERE sal IN (1000,5000);
/**
	找出工作岗位不是manager和salesman的员工
*/
SELECT * FROM emp WHERE job NOT IN ('MANAGER','SALESMAN');
/**
	找出名字中含有o的所有员工
*/
SELECT * FROM emp WHERE ename LIKE "%o%";
/**
	找出第二个字母是a的所有员工
*/
SELECT * FROM emp WHERE ename LIKE "_a%";
/**
	找出名字中含有下划线的所有员工
*/
SELECT * FROM emp WHERE ename LIKE "%\_%";
/**找出哪些人的津贴为空
*/
SELECT * FROM emp WHERE comm IS NULL;
/**找出那些人没有津贴
*/
SELECT * FROM emp WHERE comm IS NULL OR comm = 0;
/**找出工作岗位是manager和salesman的员工
*/
SELECT * FROM emp WHERE job IN ('MANAGER','SALESMAN');
/**and和or联合使用：
找出薪资大于3000，并且部门编号是20或30部门的员工
*/
SELECT * FROM emp WHERE sal > 3000 AND deptno IN (20,30);
/**
	按照工资升序，找出员工名和薪资
*/
SELECT ename,sal FROM emp ORDER BY sal ASC;
/**
	按照工资的降序排列，当工资相同的时候再按照名字的升序排列
*/
SELECT * FROM emp ORDER BY sal DESC,ename ASC;
/**
	找出工作岗位是salesman的员工，并且要求按照薪资的降序排列
*/
SELECT * FROM emp WHERE job="salesman" ORDER BY sal DESC;