DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cid` int(11) NOT NULL COMMENT '课程号',
  `cname` varchar(30) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '课程名',
  `tid` int(11) NULL DEFAULT NULL COMMENT '老师号',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8;

INSERT INTO `course` VALUES (3001, '英语', 1);
INSERT INTO `course` VALUES (3002, '数学', 2);
INSERT INTO `course` VALUES (3003, '物理', 3);
INSERT INTO `course` VALUES (3004, '语文', 4);

DROP TABLE IF EXISTS `sc`;
CREATE TABLE `sc`  (
  `sid` int(11) NOT NULL COMMENT '学生号',
  `cid` int(11) NOT NULL COMMENT '课程号',
  `score` int(11) NULL DEFAULT NULL COMMENT '成绩'
) ENGINE = InnoDB CHARACTER SET = utf8;

INSERT INTO `sc` VALUES (101, 3001, 90);
INSERT INTO `sc` VALUES (102, 3001, 85);
INSERT INTO `sc` VALUES (103, 3001, 76);
INSERT INTO `sc` VALUES (104, 3002, 87);
INSERT INTO `sc` VALUES (105, 3001, 92);
INSERT INTO `sc` VALUES (101, 3002, 81);
INSERT INTO `sc` VALUES (102, 3002, 93);
INSERT INTO `sc` VALUES (103, 3002, 73);
INSERT INTO `sc` VALUES (104, 3002, 65);
INSERT INTO `sc` VALUES (105, 3002, 96);
INSERT INTO `sc` VALUES (101, 3003, 85);
INSERT INTO `sc` VALUES (102, 3003, 76);
INSERT INTO `sc` VALUES (103, 3003, 63);
INSERT INTO `sc` VALUES (104, 3003, 59);
INSERT INTO `sc` VALUES (105, 3003, 56);
INSERT INTO `sc` VALUES (101, 3004, 100);
INSERT INTO `sc` VALUES (102, 3004, 83);
INSERT INTO `sc` VALUES (103, 3004, 75);
INSERT INTO `sc` VALUES (104, 3004, 69);
INSERT INTO `sc` VALUES (105, 3004, 50);
INSERT INTO `sc` VALUES (106, 3001, 60);
INSERT INTO `sc` VALUES (106, 3001, 60);

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `sid` int(11) NOT NULL COMMENT '学生号',
  `sname` varchar(30) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '姓名',
  `sage` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `ssex` varchar(8) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '性别',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8;

INSERT INTO `student` VALUES (101, '王明', 18, '女');
INSERT INTO `student` VALUES (102, '王天', 19, '男');
INSERT INTO `student` VALUES (103, '张三', 18, '男');
INSERT INTO `student` VALUES (104, '李四', 19, '女');
INSERT INTO `student` VALUES (105, '王五', 20, '男');
INSERT INTO `student` VALUES (107, '万源', 17, '男');

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `tid` int(11) NOT NULL COMMENT '老师号',
  `tname` varchar(30) CHARACTER SET utf8  NULL DEFAULT NULL COMMENT '老师名称',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8;

INSERT INTO `teacher` VALUES (1, '王老师');
INSERT INTO `teacher` VALUES (2, '李老师');
INSERT INTO `teacher` VALUES (3, '赵老师');
INSERT INTO `teacher` VALUES (4, '宋老师');

SET FOREIGN_KEY_CHECKS = 1;



-- 查询
-- 自然连接
SELECT a.sname,b.cname,c.score FROM student a,course b,sc c  WHERE a.sid = c.sid AND b.cid = c.cid;
-- 内连接
SELECT * FROM student a INNER JOIN sc b ON a.sid =b.sid  INNER JOIN course c ON c.cid = b.cid;
-- 左连接
SELECT * FROM student a LEFT JOIN sc b ON a.sid = b.sid;
-- 右连接
SELECT * FROM student a RIGHT JOIN sc b ON a.sid = b.sid;
-- 全连接
SELECT * FROM student a LEFT JOIN sc b ON a.sid = b.sid
UNION
SELECT * FROM student a RIGHT JOIN sc b ON a.sid = b.sid;
-- 嵌套查询
SELECT sname FROM student WHERE sid IN (SELECT sid FROM sc WHERE score = 100);
SELECT * FROM (SELECT sname,sage FROM student a LEFT JOIN sc b ON a.sid = b.sid) AS a;
-- 函数
SELECT MAX(score) FROM sc;
SELECT MIN(score) FROM sc;
SELECT SUM(score) FROM sc GROUP BY sid;
SELECT AVG(score) FROM sc GROUP BY sid;
SELECT COUNT(*) FROM sc GROUP BY sid;


