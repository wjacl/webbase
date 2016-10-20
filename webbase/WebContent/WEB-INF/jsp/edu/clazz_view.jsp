<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<h3>
		<s:message code="clazz.title" />
	</h3>
			<div class="easyui-layout" style="width: 100%; height: 500px;">
				<div data-options="region:'west'"
					style="padding: 5px; width: 200px; max-height: 500px;">
					<ul id="clazzViewTree" class="ztree"></ul>
				</div>
				<div data-options="region:'center',border:false"
					style="width: 800px; max-height: 500px; padding: 0px 10px">

					<div class="easyui-panel" data-options="collapsible:true,width:760"
						title='<s:message code="clazzView.info" />'>

						<form id="clazz_add" method="post" action="${ctx }/clazz/add"
							style="margin-bottom: 0px; padding: 5px 5px 5px 0px">
							<table class="dv-table" border="0">
								<tr>
									<th class="dv-label"><s:message code="clazz.name" />:</th>
									<td><input class="easyui-textbox" name="name"
										style="width: 100%"
										data-options="required:true,
											validType:{length:[1,30],myRemote:['${ctx }/clazz/nameExits','name','#clazz_oldname']},
											invalidMessage:'<s:message code="clazz.name.exits"/>'">
										<input type="hidden" name="oldname" id="clazz_oldname" /></td>
									<th class="dv-label"><s:message code="clazz.major" />:</th>
									<td><input class="easyui-combobox" name="major"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/major/list?sort=ordno&order=asc',
						                    method:'get',
						                    valueField:'id',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.school" />:</th>
									<td><select name="school" class="easyui-combotree"
										style="width: 100%"
										data-options="url:'${ctx }/org/tree',required:true,
						        loadFilter:$.ad.easyTreeDefaultLoadFilter">
									</select></td>
								</tr>
								<tr>
									<th class="dv-label"><s:message code="clazz.admin" />:</th>
									<td><input class="easyui-combobox" name="admin"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/user/find?type_eq_string=A',
						                    method:'get',
						                    valueField:'id',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.status" />:</th>
									<td><input class="easyui-combobox" name="status"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/dict/get?pvalue=clazz.status',
						                    method:'get',
						                    valueField:'value',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.startTime" />:</th>
									<td><input class="easyui-datebox" name="startTime"
										data-options="required:true"></td>
								</tr>
								<tr>
									<th class="dv-label"><s:message code="clazz.finishTime" />:</th>
									<td><input class="easyui-datebox" name="finishTime"
										style="width: 100%"></td>
									<th><input type="hidden" name="id" /> <input
										type="hidden" name="version" /></th>
									<td></td>
									<th></th>
									<td></td>
								</tr>
							</table>
						</form>
					</div>
					<div style="height: 10px"></div>

					
						<div id="student_tb1">
								<a href="javascript:$.ad.toUpdate('student_grid','student_w','<s:message code='student' />','student_add','${ctx }/student/update',{oldname:'name'})"
									class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
								<a href="javascript:$.ad.doDelete('student_grid','${ctx }/student/delete')" class="easyui-linkbutton" iconCls="icon-remove"
									plain="true"><s:message code='comm.remove' /></a>						
						</div>
					
						<table class="easyui-datagrid" id="student_grid" title='<s:message code="clazzView.studentInfo" />'
							data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,width:760,
									height:300,
									url:'${ctx }/student/query',method:'post',toolbar:'#student_tb1',collapsible:true">
							<thead>
								<tr>
									<th data-options="field:'ck',checkbox:true"></th>
									<th data-options="field:'name',width:100"><s:message
											code="p.name" /></th>
									<th data-options="field:'sex',width:60,sortable:'true',formatter:student.sexFormatter"><s:message
											code="p.sex" /></th>
									<th
										data-options="field:'clazz',width:100,sortable:'true',formatter:student.clazzFormatter"><s:message
											code="clazz" /></th>
									<th
										data-options="field:'learnMajor',width:100,sortable:'true',formatter:student.majorFormatter"><s:message
											code="p.major" /></th>
									<th
										data-options="field:'phone',width:100"><s:message
											code="p.phone" /></th>
									<th
										data-options="field:'startTime',width:100"><s:message
											code="student.startTime" /></th>
									<th
										data-options="field:'status',width:100,align:'center',sortable:'true',formatter:student.statusFormatter"><s:message
											code="p.status" /></th>
									<th
										data-options="field:'finishTime',width:100"><s:message
											code="p.graduateTime" /></th>
								</tr>
							</thead>
						</table>	
						
					<div style="height: 10px"></div>
					
					<div class="easyui-panel" data-options="collapsible:true,width:760"
						title='<s:message code="clazzView.courseInfo" />'>
						dddddddffff</div>

				</div>
			</div>
			<script type="text/javascript">
				var clazzView = {
						rootId:0,
						type_t:'t',
						type_c:'c',
						currNode : null,
						onClick :function(event, treeId, treeNode, clickFlag){
							clazzView.currNode = treeNode;						
							if(treeNode.pid == clazzView.rootId ){							
								treeNode.oldname = treeNode.name;
								$("#clazzView_add").form("load",treeNode);
								$("#clazzView_buttons").show();
							}
							else{
								$("#clazzView_buttons").hide();
							}
						},
						
						courseSelectOk:function(){
							var nodes = clazzViewCoursezTree.getCheckedNodes(true);
							if(nodes.length == 0 && clazzView.currNode.children && clazzView.currNode.children.length > 0){
								clazzViewzTree.removeChildNodes(clazzView.currNode);
							}
							else{
								if(clazzView.currNode.children && clazzView.currNode.children.length > 0){
									var clds = clazzView.currNode.children
									var dels = [];
									for(var i= clds.length -1; i >= 0; i--){
										var has = false;
										for(var j in nodes){
											if(clds[i].id == nodes[j].id){
												has = true;
												break;
											}
										}
										if(!has){
											clazzViewzTree.removeNode(clds[i]);
										}
									}
									
									for(var i in nodes){
										var has = false;
										for(var j in clds){
											if(clds[j].id == nodes[i].id){
												has = true;
												break;
											}
										}
										if(!has){
											clazzViewzTree.addNodes(clazzView.currNode,{id:nodes[i].id,name:nodes[i].name,pid:clazzView.currNode.id});
										}
									}
								}
								else{
									for(var i in nodes){
										clazzViewzTree.addNodes(clazzView.currNode,{id:nodes[i].id,name:nodes[i].name,pid:clazzView.currNode.id});
									}
								}
							}

							//最后存库
							if(clazzView.resaveclazzViewCourse(clazzView.currNode)){
								$("#clazzView_course_w").window("close");
							}
						},
						
						loadclazzViewCourse:function (treeNode,notexpand){
							if(treeNode.pid == clazzView.rootId && !treeNode.loaded){
								$.ajax({url:'${ctx}/clazzView/getclazzViewCourse',
									data:{clazzViewId:treeNode.id},async:false,dataType:'json',
									success:function(data){
										treeNode.loaded = true;
										if(data && data.length > 0){
											var nodes = [];
											for(var i in data){
												nodes.push({id:data[i].course.id,name:data[i].course.name,pid:treeNode.id});
											}
											clazzViewzTree.addNodes(treeNode, nodes,notexpand);
										}
									}});
							}
						},
						
						beforeExpand:function(treeId, treeNode){
							clazzView.loadclazzViewCourse(treeNode,true);
							return true;
						},
						
						beforeRemove:function(treeId, treeNode){
							$.sm.confirmDelete(function(){
								if(treeNode.pid == clazzView.rootId){
									$.ajax({url:'${ctx}/clazzView/delete',data:{ids:[treeNode.id]},
										dataType:'json',async:false,
										success: function(data){
											$.sm.handleResult(data);
											clazzViewzTree.removeNode(treeNode);
									      }});
								}else{
									if(clazzView.resaveclazzViewCourse(treeNode.getParentNode(),treeNode.id)){
										clazzViewzTree.removeNode(treeNode);
									}
								}
							});
							
							return false;
						},
						
						resaveclazzViewCourse:function(clazzViewNode,exceptCourseId){
							//保存
							var courseIds = [];
							for(var i in clazzViewNode.children){
								if(exceptCourseId && clazzViewNode.children[i].id == exceptCourseId){
									continue;
								}
								courseIds.push(clazzViewNode.children[i].id);
							}
							var res = false;
							$.ajax({url:'${ctx}/clazzView/setCourse',async:false,dataType:'json',
								data:{clazzViewId:clazzViewNode.id,courseIds:courseIds},
								success:function(data){
									$.sm.handleResult(data,function(data){
										res = true;
									})
								}});
							return res;
						},
						
						addHoverDom : function(treeId, treeNode) {
							if(treeNode.id != clazzView.rootId && treeNode.pid != clazzView.rootId){
								return false;
							}
							
							var zTree = $.fn.zTree.getZTreeObj(treeId);
							var sObj = $("#" + treeNode.tId + "_span");
							if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
							var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
								+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
							sObj.after(addStr);
							var btn = $("#addBtn_"+treeNode.tId);
							if (btn) btn.bind("click", function(){
								clazzView.currNode = treeNode;
								
								if(treeNode.id == clazzView.rootId){
									var ordno = 1;
									if(treeNode.children && treeNode.children.length > 0){
										ordno = treeNode.children.length + 1;
									}
									var da = {ordno:ordno};
									$("#clazzView_add").form("clear");
									$("#clazzView_add").form("load",da);
									$("#clazzView_buttons").show();
								}
								else{
									//添加课程
									if(!treeNode.loaded){
										clazzView.loadclazzViewCourse(treeNode,false);
									}
									$("#clazzView_course_w").window("open");
									//清空选中
									clazzViewCoursezTree.checkAllNodes(false);
									//选中已选择的
									if(treeNode.children){
										for(var i in treeNode.children){
											var nd = clazzViewCoursezTree.getNodesByParam("id",treeNode.children[i].id);
											clazzViewCoursezTree.checkNode(nd[0],true);
										}
									}
									
								}
								return false;
							});
						},
						
						beforeDrop : function(treeId, treeNodes, targetNode, moveType) {
							if(targetNode){
								if(targetNode.pid != treeNodes[0].pid){
									return false;
								}
							}
							return true;
						},
						
						onDrop : function(event, treeId, treeNodes, targetNode, moveType) {
						    if(targetNode){
						    	clazzView.resaveclazzViewCourse(targetNode.getParentNode());
						    }
						}
						
				};
				clazzView.treeSetting = {
					view: {
						addHoverDom: clazzView.addHoverDom,
						removeHoverDom: ztreef.removeHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						renameTitle:I18N.update,
						showRenameBtn: false,
						showRemoveBtn:function(treeId,treeNode){						
							if(treeNode.id == clazzView.rootId){
								return false;
							}
							return true;
						},
						drag: {
							prev: true,
							next: true,
							inner: false
						}
					},
					data: {
						simpleData: {
							enable: true,
							pIdKey:"pid"						
						}
					},
					callback: {
						beforeRemove: clazzView.beforeRemove,
						beforeExpand:clazzView.beforeExpand,
						onClick:clazzView.onClick,
						beforeDrag: ztreef.beforeDrag,
						beforeDrop: clazzView.beforeDrop,
						onDrop:clazzView.onDrop
					}
				};
				
				var times = ${times};
				var yu = '<s:message code="clazzView.year.unit"/>';
				var d = new Date();
				d.setTime(times);
				var year = d.getFullYear();
				
				clazzView.treezNodes = [];
				clazzView.treezNodes.push({id:clazzView.rootId,name:'<s:message code="clazzView.year"/>',
					pid:null,open:true,isParent:true});
				clazzView.treezNodes.push({id:year,name:year + yu,
					pid:clazzView.rootId,open:true,isParent:true});
				
				var currYearNodes = ${treeNodes};
				for(var i in currYearNodes){
					currYearNodes[i].pid = year;
					clazzView.treezNodes.push(currYearNodes[i]);
				}
				
				for(var i = 1; i < 6; i++) {
					clazzView.treezNodes.push({id:(year - i),name:(year - i) + yu,
						pid:clazzView.rootId,open:true,isParent:true});
				}
	
				var clazzViewzTree = $.fn.zTree.init($("#clazzViewTree"), clazzView.treeSetting,clazzView.treezNodes);

				function clazzViewSubmitForm(formId){
					$('#' + formId).form('submit',{success:function(data){
						var data = eval('(' + data + ')');
						$.sm.handleResult(data,function(node){
							
							var newNode = node;
							newNode.oldname = newNode.name;
							$("#clazzView_add").form("load",newNode);
							
							if(clazzView.currNode.id == clazzView.rootId){
								newNode.pid = clazzView.rootId;
								newNode.isParent = true;
								newNode.drag = false;
								clazzViewzTree.addNodes(clazzView.currNode,newNode);
								clazzView.currNode = clazzViewzTree.getNodeByParam("id",newNode.id);								
							}
							else{
								clazzView.currNode.name = newNode.name;
								clazzView.currNode.descr = newNode.descr;
								clazzView.currNode.version = newNode.version;
								clazzViewzTree.updateNode(clazzView.currNode);
							}
						});
					}});
				}
					
			</script>
			
				
	<script type="text/javascript">
		var student = {
				sexs:false,
				sexFormatter :function(value,row,index){
					if(!student.sexs){
						$.ajax({url:'${ctx}/dict/get?pvalue=sex',async:false,dataType:'json',
							success:function(data){
							student.sexs = data;
						}});
					}
					return $.ad.getName(value,student.sexs,'value');
				},
				majors:false,
				majorFormatter:function(value,row,index){
					if(!student.majors){
						student.majors = $('#studentMajor').combobox("getData");
					}
					return $.ad.getName(value,student.majors,'id');
				},
				
				clazz:false,
				clazzFormatter:function(value,row,index){ 
					if(!student.clazz){
						student.clazz = $('#student_clazz').combobox("getData");
					}
					return $.ad.getName(value,student.clazz);
				},
				
				status:false,
				statusFormatter:function(value,row,index){
					if(!student.status){
						student.status = $('#student_status').combobox("getData");
					}
					return $.ad.getName(value,student.status,'value');
				},
								
		};
	</script>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>