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
			if(!$("#student_grid").datagrid("options").url){
				$("#student_grid").datagrid("options").url = ctx + '/student/list';
			}
			$("#student_grid").datagrid("load",{clazz:treeNode.id});
			
			$("#clazz_course").datagrid("loadData",[]);
			if(!$("#clazz_course").datagrid("options").url){
				$("#clazz_course").datagrid("options").url = ctx + '/clazz/courses';
			}
			$("#clazz_course").datagrid("load",{clazzId:treeNode.id});
		} else {
			
		}
	},
	
	course : {
		up:function(){
			var rows = $("#clazz_course").datagrid("getChecked");
			for(var i in rows){
				var index = $("#clazz_course").datagrid("getRowIndex",rows[i]);
				if(index != 0){
					var prerow = {};
					$.extend(prerow,$("#clazz_course").datagrid("getRows")[index - 1]);
					$("#clazz_course").datagrid("updateRow",{index:index - 1,row:rows[i]});
					$("#clazz_course").datagrid("checkRow",index - 1);
					$("#clazz_course").datagrid("updateRow",{index:index,row:prerow});
					$("#clazz_course").datagrid("uncheckRow",index);
				}
			}
		},
		down:function(){
			var rows = $("#clazz_course").datagrid("getChecked");
			var maxIndex = $("#clazz_course").datagrid("getRows").length - 1; 
			for(var i = rows.length -1 ; i >= 0; i--){
				var index = $("#clazz_course").datagrid("getRowIndex",rows[i]);
				if(index < maxIndex){
					var prerow = {};
					$.extend(prerow,$("#clazz_course").datagrid("getRows")[index + 1]);
					$("#clazz_course").datagrid("updateRow",{index:index + 1,row:rows[i]});
					$("#clazz_course").datagrid("checkRow",index + 1);
					$("#clazz_course").datagrid("updateRow",{index:index,row:prerow});
					$("#clazz_course").datagrid("uncheckRow",index);
				}
			}
		},	
		doDelete:function(){
			var rows = $("#clazz_course").datagrid("getChecked");
			if(rows.length > 0){
				$.sm.confirmDelete(function(){
					for(var i = rows.length -1 ; i >= 0; i--){
						var index = $("#clazz_course").datagrid("getRowIndex",rows[i]);
						$("#clazz_course").datagrid("deleteRow",index);
					}
				});
			}
		},
		toAddCourse : function(){
			if(!clazzView.currNode){
				$.sm.alert(I18N.regist_select_clazz);
				return;
			}
			$("#course_w").window("open");
			//清空选中
			courseTree.ztree.checkAllNodes(false);
			//选中已选择的
			var tabDatas = $("#clazz_course").datagrid("getRows");
			if(tabDatas && tabDatas.length >0){
				for(var i in tabDatas){
					var nd = courseTree.ztree.getNodesByParam("id",tabDatas[i].course.id);
					courseTree.ztree.checkNode(nd[0],true);
				}
			}
		},
		endEditing : function (){
			var editIndex;
			var cell = $("#clazz_course").datagrid("cell");
			if(cell){
				editIndex = cell.index;
			}
            if (editIndex == undefined){return true}
            if ($('#clazz_course').datagrid('validateRow', editIndex)){
                $('#clazz_course').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        },
		saveClazzCourse:function(){		
			if(clazzView.course.endEditing()){
				var tabDatas = $("#clazz_course").datagrid("getRows");
				var data = [];
				if(tabDatas.length > 0){
					for(var i in tabDatas){
						data.push({clazzId:tabDatas[i].clazzId,
							course:{id:tabDatas[i].course.id},
							teacher:tabDatas[i].teacher,
							startTime:tabDatas[i].startTime,
							finishTime:tabDatas[i].finishTime,
							status:tabDatas[i].status,
							ordno:i});
					}
				}
				$.post(ctx + "/clazz/saveCourses",{clazzId:clazzView.currNode.id,
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
						if (clds[i].course.id == nodes[j].id) {
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
						if (clds[j].course.id == nodes[i].id) {
							has = true;
							break;
						}
					}
					if (!has) {
						$("#clazz_course").datagrid("appendRow",{
							id : '',
							clazzId : clazzView.currNode.id,
							course:{name:nodes[i].name,
								id:nodes[i].id,
								hour:nodes[i].hour,
								credit:nodes[i].credit},
							status:'1',
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
						course:{name:nodes[i].name,
							id:nodes[i].id,
							hour:nodes[i].hour,
							credit:nodes[i].credit},
						status:'1',
						startTime:'',
						finishTime:''
					});
				}
			}
		}

		$("#course_w").window("close");
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

	addHoverDom : function(treeId, treeNode) {
		if (!abc || treeNode.nodeType != clazzView.type_y) {
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
		enable : false,
		removeTitle : I18N.remove,
		renameTitle : I18N.update,
		showRenameBtn : false,
		showRemoveBtn : function(treeId,treeNode){
			if(edf){
				if(treeNode.nodeType == clazzView.type_c){
					return true;
				}
			}
			return false;
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
		//beforeRemove : clazzView.beforeRemove,
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
		detailFormatter:function(index,row){
            return '<div class="ddv" style="padding:5px 10px;height:100px"></div>';
        },
        onExpandRow: function(index,row){
            var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
            
            if(row.addDetail){
            
            }else{
            	var des = '<table class="dv-table" border="0">' +
				'<tr>' +
					'<th>' + I18N.person.baseInfo + '</th>'+
					'<th class="dv-label">' + I18N.person.birthday + ':</th>' +
					'<td>' + $.ad.nvl(row.birthday) + '</td>' +
					
					'<th class="dv-label">QQ:</th>' +
					'<td>' + $.ad.nvl(row.qq) + '</td>' +
					
					'<th class="dv-label">Email:</th>' +
					'<td>' + $.ad.nvl(row.email) + '</td>' +
					
					'<th></th>' +
					'<td></td>' +
				'</tr>' +
				'<tr>' +
					'<th></th>' +
					'<th class="dv-label">' + I18N.person.address + ':</th>' +
					'<td colspan="3">' + $.ad.nvl(row.address) + '</td>' +
					
					'<th class="dv-label">' + I18N.person.remark + ':</th>' +
					'<td colspan="3">' + $.ad.nvl(row.remark) + '</td>' +
				'</tr>' +
				'<tr>' +
					'<th>' + I18N.person.eduInfo + '</th>'+
					'<th class="dv-label">' + I18N.person.education + ':</th>' +
					'<td>' + $.ad.getDictName('education',row.education) + '</td>' +
					
					'<th class="dv-label">' + I18N.person.school + ':</th>' +
					'<td>' + $.ad.nvl(row.school) + '</td>' +
					
					'<th class="dv-label">' + I18N.person.major + ':</th>' +
					'<td>' + $.ad.nvl(row.major) + '</td>' +
					
					'<th class="dv-label" style="width:120px">' + I18N.person.graduateTime + ':</th>' +
					'<td>' + $.ad.nvl(row.graduateTime) + '</td>' +
				'</tr>' +
				
				'<tr>' +
					'<th style="width:120px">' + I18N.person.homeInfo + '</th>'+
					'<th class="dv-label" style="width:120px">' + I18N.person.parent + ':</th>' +
					'<td>' + $.ad.nvl(row.parent) + '</td>' +
					
					'<th class="dv-label" style="width:120px">' + I18N.person.phone + ':</th>' +
					'<td>' + $.ad.nvl(row.homePhone) + '</td>' +
					
					'<th class="dv-label" style="width:120px">' + I18N.person.home + ':</th>' +
					'<td colspan="3">' + $.ad.nvl(row.home) + '</td>' +
				
				'</tr>' +
			'</table>';
	
            	ddv.append(des);
            	row.addDetail = true;
            	$('#dg').datagrid('fixDetailRowHeight',index);
            }
            $('#dg').datagrid('fixDetailRowHeight',index);
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
				isParent : true,
				nodeType:clazzView.type_y
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
					isParent : true,
					nodeType:clazzView.type_y
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