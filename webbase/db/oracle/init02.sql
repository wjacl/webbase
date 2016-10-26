
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

/*10-14*/
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('44','博士','4',44,'education','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('c.c.sta','课程计划状态','c.c.sta',49,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('50','未开始','1',1,'c.c.sta','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('51','授课中','2',2,'c.c.sta','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('52','已完成','3',3,'c.c.sta','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('course.type','课程数据类别','course.type',53,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('54','分类','t',1,'course.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('55','课程','c',2,'course.type','s',1);

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

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-major','专业管理','/major/manage','edu','1',1,2060);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-major');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-class-view','班级管理','/clazz/view','edu','1',1,2025);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-class-view');


INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-clazz-add','新增班级','/clazz/add','edu-class-view','0',1,2026);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-clazz-add');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-clazz-update','修改班级','/clazz/update','edu-class-view','0',1,2027);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-clazz-update');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-clazz-del','删除班级','/clazz/delete','edu-class-view','0',1,2028);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-clazz-del');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cs-update','修改学生','/student/update','edu-class-view','0',1,2029);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cs-update');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cs-del','删除学生','/student/delete','edu-class-view','0',1,2030);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cs-del');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cc-save','课程计划修改','/clazz/saveCourses','edu-class-view','0',1,2031);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cc-save');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cc-del','删除课程','/clazz/deleteCourses','edu-class-view','0',1,2032);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cc-del');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-cc-add','添加课程','/clazz/addCourses','edu-class-view','0',1,2033);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-cc-add');

INSERT INTO t_sys_param(ID,name,VALUE,remark)
VALUES('day.lessons','每日上课课时数','6','每日上课课时数，整数>0');

INSERT INTO t_sys_param(ID,name,VALUE,remark)
VALUES('clazz.tree.years','班级树上展示的年份个数','3','班级树上展示的年份个数');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-myclazz','我的班级','/clazz/my','edu','1',1,2010);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-myclazz');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-myclazz-update','修改班级','/clazz/update','edu-myclazz','0',1,2027);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-myclazz-update');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-mycs-update','修改学生','/student/update','edu-myclazz','0',1,2029);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-mycs-update');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-mycs-del','删除学生','/student/delete','edu-myclazz','0',1,2030);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-mycs-del');

