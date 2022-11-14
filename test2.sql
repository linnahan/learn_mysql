USE test01;

CREATE TABLE IF NOT EXISTS bnz_exam_paper (
	id BIGINT ( 32 ) AUTO_INCREMENT COMMENT "试卷ID",
	paper_name VARCHAR ( 50 ) COMMENT "试卷名称",
	paper_type TINYINT ( 1 ) DEFAULT "1" COMMENT "试卷类型 1-计划试卷 2-阶段试卷",
	type TINYINT ( 1 ) DEFAULT "1" COMMENT "出题方式 1-选择式固定出题 2-指定题库随机出题",
	single_score INT ( 3 ) DEFAULT "2" COMMENT "单选题分值",
	multiple_score INT ( 3 ) DEFAULT "2" COMMENT "多选题分值",
	judge_score INT ( 3 ) DEFAULT "2" COMMENT "判断题分值",
	fill_score INT ( 3 ) DEFAULT "2" COMMENT "填空题分值",
	explain_score INT ( 3 ) DEFAULT "2" COMMENT "问答题分值",
	is_private bit ( 1 ) COMMENT "是否私密试卷 0-否 1-是",
	is_enable bit ( 1 ) COMMENT "是否启用 0-未启用 1-已启用",
	creator VARCHAR ( 32 ) COMMENT "`创建人",
	create_time TIMESTAMP COMMENT "修改人名称",
	pass_score INT ( 3 ) COMMENT "通过分数",
	limit_num INT ( 3 ) DEFAULT "150" COMMENT "限考次数 0为不限",
	exam_duration INT ( 3 ) COMMENT "考试时长",
	PRIMARY KEY ( id ) 
	)
	
	INSERT INTO bnz_exam_paper VALUES (1,'语文',1,2,1,2,2,3,4,1,1,"林钠瀚","2022-11-14 11:11:11",100,3,120);
	INSERT INTO bnz_exam_paper(paper_name,is_private,is_enable,creator,create_time,pass_score,limit_num,exam_duration) VALUES ("数学",1,0,"林","2022-11-14 11:11:11",120,3,120),("化学",1,0,"钠","2022-11-14 11:11:11",100,3,120),("英语",0,0,"瀚","2022-11-14 11:11:11",120,2,120),("生物",0,1,"林","2022-11-14 11:11:11",80,3,60),("地理",1,1,"钠","2022-11-14 11:11:11",80,3,60),("历史",1,1,"瀚","2022-11-14 11:11:11",120,2,120),("政治",1,0,"林","2022-11-14 11:11:11",150,1,120)