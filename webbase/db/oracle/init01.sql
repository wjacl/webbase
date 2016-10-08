INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('0','数据字典',NULL,'s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.type','用户类别','0','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.type.A','员工','user.type','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.type.S','学生','user.type','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.type.C','合作用户','user.type','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.status','用户状态','0','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.status.N','正常','user.status','s',1);
INSERT INTO t_sys_dict(Id,text,pid,type,valid) VALUES('user.status.L','锁定','user.status','s',1);


INSERT INTO t_sys_role(ID,NAME,TYPE,valid)
VALUES('admin','超级管理员','s',1);

INSERT INTO t_sys_user(Id,username,password,name,TYPE,status,valid)
VALUES('u001','admin','21232F297A57A5A743894A0E4A801FC3','系统管理员','A','N',1);

INSERT INTO t_sys_user_role(u_id,r_id)VALUES('u001','admin');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys','系统管理',NULL,NULL,'2',1,9000);

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict','字典维护','/dict/main','sys','1',1,9800);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-tree','查询','/dict/getTree','sys-dict','0',1,9801);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-add','新增','/dict/add','sys-dict','0',1,9802);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-update','修改','/dict/update','sys-dict','0',1,9803);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-dict-remove','删除','/dict/remove','sys-dict','0',1,9804);

INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-tree');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-dict-remove');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user','用户管理','/user/mana','sys','1',1,9101);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-query','查询','/user/query','sys-user','0',1,9102);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-add','新增','/user/add','sys-user','0',1,9103);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-update','修改','/user/update','sys-user','0',1,9104);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-user-remove','新增','/user/remove','sys-user','0',1,9105);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-user-remove');


INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role','角色管理','/role/manage','sys','1',1,9111);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-query','查询','/role/query','sys-role','0',1,9112);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-add','新增','/role/add','sys-role','0',1,9113);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-update','修改','/role/update','sys-role','0',1,9114);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-delete','新增','/role/delete','sys-role','0',1,9115);
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('sys-role-get','获取','/role/get','sys-role','0',1,9116);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-query');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-add');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-update');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-delete');
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-role-get');

INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu','教务管理',NULL,NULL,'2',1,2000);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-class','班级管理','/class/manage','edu','1',1,2020);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-class');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-stu','学生管理','/stu/manage','edu','1',1,2030);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-stu');
INSERT INTO t_sys_privilege(pr_id,pr_name,Path,p_pr_id,pr_type,valid,Order_No)
VALUES('edu-tea','教师管理','/tea/manage','edu','1',1,2040);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','edu-tea');
