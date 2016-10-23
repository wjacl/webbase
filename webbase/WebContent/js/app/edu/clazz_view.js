var clazzView = {
	rootId : 0,
	type_o : 'o',
	type_c : 'c',
	type_y : 'y',
	currNode : null,
	loadClazz:function(treeNode,tree,close){
		var data = {"startTime_after_date":treeNode.id + "-01-01","startTime_before_date":treeNode.id + "-12-31",sort:'startTime',order:'desc'};
		if(treeNode.pid != clazzView.rootId){
			data.school = treeNode.pid;
		}
		
		$.ajax({url: ctx + "/clazz/list",data:data,dataType:'json',async:false,
			success:function(data){
				treeNode.loaded = true;
				if(data && data.length > 0){
					for(var i in data){
						data[i].pid = treeNode.id;
						data[i].nodeType = clazzView.type_c;
					}
					tree.addNodes(treeNode,data,close);
				}
			}});
	},
	onClick : function(event, treeId, treeNode, clickFlag) {
		
		if (treeNode.nodeType == clazzView.type_c) {
			clazzView.currNode = treeNode;
			treeNode.oldname = treeNode.name;
			$("#clazz").form("load", treeNode);
			$("#student_grid").datagrid({url:ctx + '/student/list'});
			$("#student_grid").datagrid("load",{clazz:treeNode.id});
			$("#clazz_course").datagrid("loadData",[]);
			$("#clazz_course").datagrid({url:ctx + '/clazz/courses'});
			$("#clazz_course").datagrid("load",{clazzId:treeNode.id});
		} else {
			
		}
	},
	
	course : {
		loadFilter:function(data){
			if(data && data.length > 0){
				for(var i in data){
					data[i].courseId = data[i].course.id;
					data[i].courseName = data[i].course.name;
					data[i].hour = data[i].course.hour;
					data[i].credit = data[i].course.credit;
				}
			}
		},
		
		toAddCourse : function(){
			$("#course_w").window("open");
			//清空选中
			courseTree.ztree.checkAllNodes(false);
			//选中已选择的
			var tabDatas = $("#clazz_course").datagrid("getRows");
			if(tabDatas && tabDatas.length >0){
				for(var i in tabDatas){
					var nd = courseTree.ztree.getNodesByParam("id",tabDatas[i].courseId);
					courseTree.ztree.checkNode(nd[0],true);
				}
			}
		},
		saveClazzCourse:function(){		
			if($.endCellEdit("#clazz_course")){
				var tabDatas = $("#clazz_course").datagrid("getRows");
				var data = [];
				if(tabDatas.length > 0){
					data.push({clazzId:tabDatas[i].id,
							course:{id:tabDatas[i].courseId},
							teacher:tabDatas[i].teacher,
							startTime:tabDatas[i].startTime,
							finishTime:tabDatas[i].finishTime,
							status:tabDatas[i].status})
				}
				$.post(ctx + "/clazz/saveCourse",{clazzId:clazzView.currNode.id,
												course:JSON.stringify(data)},
					function(data){
						$.sm.handleResult(data);
				    },
				 	'json');
			}
		}
	},

	courseSelectOk : function() {
		var nodes = courseTree.ztree.getCheckedNodes(true);
		var tabDatas = $("#clazz_course").datagrid("getRows");
		if (nodes.length == 0 && tabDatas
				&& tabDatas.length > 0) {
			$("#clazz_course").datagrid("loadData",[]);
		} else {
			if (tabDatas
					&& tabDatas.length > 0) {
				var clds = tabDatas
				for (var i = clds.length - 1; i >= 0; i--) {
					var has = false;
					for ( var j in nodes) {
						if (clds[i].courseId == nodes[j].id) {
							has = true;
							break;
						}
					}
					if (!has) {
						$("#clazz_course").datagrid("deleteRow",i);
					}
				}

				for ( var i in nodes) {
					var has = false;
					for ( var j in clds) {
						if (clds[j].courseId == nodes[i].id) {
							has = true;
							break;
						}
					}
					if (!has) {
						$("#clazz_course").datagrid("appendRow",{
							id : '',
							clazzId : clazzView.currNode.id,
							courseName:nodes[i].name,
							courseId:nodes[i].id,
							hour:nodes[i].hour,
							credit:nodes[i].credit,
							status:'',
							startTime:'',
							finishTime:''
						});
					}
				}
			} else {
				for ( var i in nodes) {
					$("#clazz_course").datagrid("appendRow",{
						id : '',
						clazzId : clazzView.currNode.id,
						courseName:nodes[i].name,
						courseId:nodes[i].id,
						hour:nodes[i].hour,
						credit:nodes[i].credit,
						status:'',
						startTime:'',
						finishTime:''
					});
				}
			}
		}

		$("#course_w").window("close");
	},

	loadclazzViewCourse : function(treeNode, notexpand) {
		if (treeNode.pid == clazzView.rootId && !treeNode.loaded) {
			$.ajax({
				url : '${ctx}/clazzView/getclazzViewCourse',
				data : {
					clazzViewId : treeNode.id
				},
				async : false,
				dataType : 'json',
				success : function(data) {
					treeNode.loaded = true;
					if (data && data.length > 0) {
						var nodes = [];
						for ( var i in data) {
							nodes.push({
								id : data[i].course.id,
								name : data[i].course.name,
								pid : treeNode.id
							});
						}
						clazzViewzTree.addNodes(treeNode, nodes, notexpand);
					}
				}
			});
		}
	},

	beforeExpand : function(treeId, treeNode) {
		if(!treeNode.loaded){
			clazzView.loadClazz(treeNode, clazzViewzTree,true);
		}
		return true;
	},

	beforeRemove : function(treeId, treeNode) {
		$.sm.confirmDelete(function() {
			if (treeNode.pid == clazzView.rootId) {
				$.ajax({
					url : '${ctx}/clazzView/delete',
					data : {
						ids : [ treeNode.id ]
					},
					dataType : 'json',
					async : false,
					success : function(data) {
						$.sm.handleResult(data);
						clazzViewzTree.removeNode(treeNode);
					}
				});
			} else {
				if (clazzView.resaveclazzViewCourse(treeNode.getParentNode(),
						treeNode.id)) {
					clazzViewzTree.removeNode(treeNode);
				}
			}
		});

		return false;
	},

	resaveclazzViewCourse : function(clazzViewNode, exceptCourseId) {
		//保存
		var courseIds = [];
		for ( var i in clazzViewNode.children) {
			if (exceptCourseId
					&& clazzViewNode.children[i].id == exceptCourseId) {
				continue;
			}
			courseIds.push(clazzViewNode.children[i].id);
		}
		var res = false;
		$.ajax({
			url : '${ctx}/clazzView/setCourse',
			async : false,
			dataType : 'json',
			data : {
				clazzViewId : clazzViewNode.id,
				courseIds : courseIds
			},
			success : function(data) {
				$.sm.handleResult(data, function(data) {
					res = true;
				})
			}
		});
		return res;
	},

	addHoverDom : function(treeId, treeNode) {
		if (treeNode.id != clazzView.rootId && treeNode.pid != clazzView.rootId) {
			return false;
		}

		var zTree = $.fn.zTree.getZTreeObj(treeId);
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
			return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_" + treeNode.tId);
		if (btn)
			btn.bind("click", function() {
				clazzView.currNode = treeNode;

				if (treeNode.id == clazzView.rootId) {
					var ordno = 1;
					if (treeNode.children && treeNode.children.length > 0) {
						ordno = treeNode.children.length + 1;
					}
					var da = {
						ordno : ordno
					};
					$("#clazzView_add").form("clear");
					$("#clazzView_add").form("load", da);
					$("#clazzView_buttons").show();
				} else {
					//添加课程
					if (!treeNode.loaded) {
						clazzView.loadclazzViewCourse(treeNode, false);
					}
					$("#clazzView_course_w").window("open");
					//清空选中
					clazzViewCoursezTree.checkAllNodes(false);
					//选中已选择的
					if (treeNode.children) {
						for ( var i in treeNode.children) {
							var nd = clazzViewCoursezTree.getNodesByParam("id",
									treeNode.children[i].id);
							clazzViewCoursezTree.checkNode(nd[0], true);
						}
					}

				}
				return false;
			});
	}
};
clazzView.treeSetting = {
	view : {
		addHoverDom : clazzView.addHoverDom,
		removeHoverDom : ztreef.removeHoverDom,
		selectedMulti : false
	},
	edit : {
		enable : true,
		removeTitle : I18N.remove,
		renameTitle : I18N.update,
		showRenameBtn : false,
		showRemoveBtn : function(treeId, treeNode) {
			if (treeNode.id == clazzView.rootId) {
				return false;
			}
			return true;
		},
		drag : {
			isMove:false,
			isCopy:false
		}
	},
	data : {
		simpleData : {
			enable : true,
			pIdKey : "pid"
		}
	},
	callback : {
		beforeRemove : clazzView.beforeRemove,
		beforeExpand : clazzView.beforeExpand,
		onClick : clazzView.onClick
	}
};

var student = {	
		sexFormatter :function(value,row,index){
			return $.ad.getDictName("sex",value);
		},
		majors:false,
		majorFormatter:function(value,row,index){
			if(!student.majors){
				student.majors = $('#major').combobox("getData");
			}
			return $.ad.getName(value,student.majors);
		},
		
		status:false,
		statusFormatter:function(value,row,index){
			return $.ad.getDictName("stu.status",value);
		},
						
};

	var courseTree = {
			ztree : null,
			treeSetting:{
				data: {
					simpleData: {
						enable: true,
						pIdKey: "pid"
					}
				},
				check: {
					enable: true
				}
			},
			initTree:function(){
				courseTree.treezNodes = courseTreeNodes;
				for(var i in courseTree.treezNodes){
					if(courseTree.treezNodes[i].type == 't'){
						courseTree.treezNodes[i].isParent = true;
						courseTree.treezNodes[i].nocheck = true;
						courseTree.treezNodes[i].open = true;
					}
				}
				courseTree.ztree = $.fn.zTree.init($("#courseTree"), courseTree.treeSetting,courseTree.treezNodes);
			}
	};

var clazzViewzTree;

$(function(){
	var d = new Date();
	d.setTime(times);
	var year = d.getFullYear();

	clazzView.treezNodes = [];
	var firstYearNode;
	
	if(!schoolNodes || schoolNodes.length == 0){
		clazzView.treezNodes.push({
			id : clazzView.rootId,
			name : rootName,
			pid : null,
			open : true,
			isParent : true
		});
		firstYearNode = {
				id : year,
				name : year + yu,
				pid : clazzView.rootId,
				isParent : true,
				nodeType:clazzView.type_y
			};

		clazzView.treezNodes.push(firstYearNode);
		for (var i = 1; i < 6; i++) {
			clazzView.treezNodes.push({
				id : (year - i),
				name : (year - i) + yu,
				pid : clazzView.rootId,
				isParent : true,
				nodeType:clazzView.type_y
			});
		}
	}
	else{
		for ( var i in schoolNodes) {
			schoolNodes[i].open = true;
			schoolNodes[i].nodeType = clazzView.type_o;
			
			clazzView.treezNodes.push(schoolNodes[i]);
			
			var n = {
				id : (year),
				name : (year) + yu,
				pid : schoolNodes[i].id,
				isParent : true
			};
			clazzView.treezNodes.push(n);
			
			if(i == 0){
				firstYearNode = n;
			}
			
			for (var j = 1; j < 6; j++) {
				clazzView.treezNodes.push({
					id : (year - j),
					name : (year - j) + yu,
					pid : schoolNodes[i].id,
					isParent : true
				});				
			}
		}	
	}

	clazzViewzTree = $.fn.zTree.init($("#clazzViewTree"),
			clazzView.treeSetting, clazzView.treezNodes);
	
	clazzView.loadClazz(clazzViewzTree.getNodeByParam("id",firstYearNode.id), clazzViewzTree);
	
	courseTree.initTree();
	
	 $("#clazz_course").datagrid('enableCellEditing').datagrid('gotoCell', {
         index: 0,
         field: 'status'
     });
});