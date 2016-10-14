
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('major','专业','major',8,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('9','大数据分析','bi',9,'major','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('10','Java','java',10,'major','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('11','大数据研发','bd',11,'major','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('12','UIUE','ui',12,'major','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('clazz.status','班级状态','clazz.status',13,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('14','未开班','n',14,'clazz.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('15','已开班','s',15,'clazz.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('16','已毕业','f',16,'clazz.status','s',1);

/*10-12 */
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('stu.status','学生状态','stu.status',30,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('31','待审核','w',31,'stu.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('32','在学','s',32,'stu.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('33','已毕业','f',33,'stu.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('34','辍学','l',34,'stu.status','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('tea.status','教师状态','tea.status',35,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('36','待审核','w',36,'tea.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('37','在职','s',37,'tea.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('38','离职','f',38,'tea.status','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('education','学历','education',40,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('41','专科','1',41,'education','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('42','本科','2',42,'education','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('43','硕士','3',43,'education','s',1);



INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu','教务管理',NULL,NULL,'2',1,2000);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-class','班级管理','/clazz/manage','edu','1',1,2020);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-class');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-stu','学生管理','/student/manage','edu','1',1,2030);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-stu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-tea','教师管理','/teacher/manage','edu','1',1,2040);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-tea');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cour','课程管理','/course/manage','edu','1',1,2050);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cour');
