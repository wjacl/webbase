INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('0','数据字典','',0,NULL,'s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('user.type','用户类别','user.type',1,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('2','员工','A',2,'user.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('3','学生','S',3,'user.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('4','合作用户','C',4,'user.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('user.status','用户状态','user.status',5,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('6','正常','N',6,'user.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('7','锁定','L',7,'user.status','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('5','未审核','W',8,'user.status','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('20','审核状态','audit',20,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('21','草稿','c',21,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('22','待审核','w',22,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('23','审核通过','p',23,'20','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('24','待审核','n',24,'20','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('sex','性别','sex',4,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('25','男','m',1,'sex','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('26','女','w',2,'sex','s',1);

INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('org.type','机构类别','org.type',5,'0','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot1','公司','1',1,'org.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot2','分公司','2',2,'org.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot3','学校','3',3,'org.type','s',1);
INSERT INTO t_sys_dict(Id,name,value,ordno,pid,type,valid) VALUES('ot4','部门','4',4,'org.type','s',1);


INSERT INTO t_sys_role(ID,NAME,TYPE,valid,version)
VALUES('admin','超级管理员','s',1,0);

INSERT INTO t_sys_user(Id,username,password,name,TYPE,status,valid,version)
VALUES('u001','admin','21232F297A57A5A743894A0E4A801FC3','系统管理员','A','N',1,0);

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
VALUES('sys-org','机构管理','/org/manage','sys','1',1,9130);
INSERT INTO t_sys_role_priv(r_id,pr_id) VALUES('admin','sys-org');

