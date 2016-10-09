
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('major','专业','0','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('bi','大数据分析','major','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('java','Java','major','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('bigdata','大数据研发','major','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('ui','UIUE','major','s',1);

INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('clazz.status','班级状态','0','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('notStart','未开班','clazz.status','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('started','已开班','clazz.status','s',1);
INSERT INTO t_sys_dict(Id,name,pid,type,valid) VALUES('finished','已毕业','clazz.status','s',1);



INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu','教务管理',NULL,NULL,'2',1,2000);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-class','班级管理','/clazz/manage','edu','1',1,2020);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-class');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-stu','学生管理','/stu/manage','edu','1',1,2030);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-stu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-tea','教师管理','/tea/manage','edu','1',1,2040);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-tea');
