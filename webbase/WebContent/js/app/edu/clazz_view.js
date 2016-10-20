var clazzView = {
	rootId : 0,
	type_t : 't',
	type_c : 'c',
	currNode : null,
	onClick : function(event, treeId, treeNode, clickFlag) {
		clazzView.currNode = treeNode;
		if (treeNode.nodeType == clazzView.type_c) {
			treeNode.oldname = treeNode.name;
			$("#clazz").form("load", treeNode);
			$("#student_grid").datagrid({url:ctx + '/student/list'});
			$("#student_grid").datagrid("load",{clazz:treeNode.id});
		} else {
			
		}
	},

	courseSelectOk : function() {
		var nodes = clazzViewCoursezTree.getCheckedNodes(true);
		if (nodes.length == 0 && clazzView.currNode.children
				&& clazzView.currNode.children.length > 0) {
			clazzViewzTree.removeChildNodes(clazzView.currNode);
		} else {
			if (clazzView.currNode.children
					&& clazzView.currNode.children.length > 0) {
				var clds = clazzView.currNode.children
				var dels = [];
				for (var i = clds.length - 1; i >= 0; i--) {
					var has = false;
					for ( var j in nodes) {
						if (clds[i].id == nodes[j].id) {
							has = true;
							break;
						}
					}
					if (!has) {
						clazzViewzTree.removeNode(clds[i]);
					}
				}

				for ( var i in nodes) {
					var has = false;
					for ( var j in clds) {
						if (clds[j].id == nodes[i].id) {
							has = true;
							break;
						}
					}
					if (!has) {
						clazzViewzTree.addNodes(clazzView.currNode, {
							id : nodes[i].id,
							name : nodes[i].name,
							pid : clazzView.currNode.id
						});
					}
				}
			} else {
				for ( var i in nodes) {
					clazzViewzTree.addNodes(clazzView.currNode, {
						id : nodes[i].id,
						name : nodes[i].name,
						pid : clazzView.currNode.id
					});
				}
			}
		}

		//最后存库
		if (clazzView.resaveclazzViewCourse(clazzView.currNode)) {
			$("#clazzView_course_w").window("close");
		}
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
		clazzView.loadclazzViewCourse(treeNode, true);
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
	},

	beforeDrop : function(treeId, treeNodes, targetNode, moveType) {
		if (targetNode) {
			if (targetNode.pid != treeNodes[0].pid) {
				return false;
			}
		}
		return true;
	},

	onDrop : function(event, treeId, treeNodes, targetNode, moveType) {
		if (targetNode) {
			clazzView.resaveclazzViewCourse(targetNode.getParentNode());
		}
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
			prev : true,
			next : true,
			inner : false
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
		onClick : clazzView.onClick,
		beforeDrag : ztreef.beforeDrag,
		beforeDrop : clazzView.beforeDrop,
		onDrop : clazzView.onDrop
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

var clazzViewzTree;

$(function(){
	var d = new Date();
	d.setTime(times);
	var year = d.getFullYear();

	clazzView.treezNodes = [];
	clazzView.treezNodes.push({
		id : clazzView.rootId,
		name : rootName,
		pid : null,
		open : true,
		isParent : true
	});
	clazzView.treezNodes.push({
		id : year,
		name : year + yu,
		pid : clazzView.rootId,
		open : true,
		isParent : true
	});

	for ( var i in currYearNodes) {
		currYearNodes[i].pid = year;
		currYearNodes[i].nodeType = clazzView.type_c;
		
		clazzView.treezNodes.push(currYearNodes[i]);
	}

	for (var i = 1; i < 6; i++) {
		clazzView.treezNodes.push({
			id : (year - i),
			name : (year - i) + yu,
			pid : clazzView.rootId,
			open : true,
			isParent : true
		});
	}

	clazzViewzTree = $.fn.zTree.init($("#clazzViewTree"),
			clazzView.treeSetting, clazzView.treezNodes);
});