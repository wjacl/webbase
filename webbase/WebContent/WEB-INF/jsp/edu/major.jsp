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
	
	<div id="mainwrap">
		<div id="content" class="content min500h">
	<h3>
		<s:message code="major.title" />
	</h3>
	<div class="easyui-layout" style="width:620px;height:430px;">
		<div data-options="region:'west'" style="padding: 5px;width:300px;max-height:430px;">
				<ul id="majorTree" class="ztree"></ul>			
		</div>
		<div data-options="region:'center',border:false" style="width:300px;max-height:430px;"> 
			<div class="content">
				<form id="major_add" method="post" action="${ctx }/major/add">		
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 240px"
							data-options="label:'<s:message code="major.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/major/nameCheck','name','#major_oldname']},
							invalidMessage:'<s:message code="major.name.exits"/>'">
						<input type="hidden" name="oldname" id="major_oldname" />
					</div>			
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="descr" style="width: 240px"
							data-options="label:'<s:message code="major.descr"/>:',
							validType:{length:[0,300]},multiline:true,height:60">
					</div>
					<input type="hidden" name="ordno" />
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0;width:240px" id="major_buttons">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="majorSubmitForm('major_add')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('major_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
			</div>
		</div>
	</div>
				<script type="text/javascript">
				var major = {
						rootId:0,
						type_t:'t',
						type_c:'c',
						currNode : null,
						onClick :function(event, treeId, treeNode, clickFlag){
							major.currNode = treeNode;
							
							if(treeNode.pid == major.rootId ){							
								treeNode.oldname = treeNode.name;
								$("#major_add").form("load",treeNode);
								$("#major_buttons").show();
							}
						},
						
						courseSelectOk:function(){
							var nodes = majorCoursezTree.getCheckedNodes(true);
							if(nodes.length == 0 && major.currNode.children && major.currNode.children.length > 0){
								majorzTree.removeChildNodes(major.currNode);
							}
							else{
								if(major.currNode.children && major.currNode.children.length > 0){
									var clds = major.currNode.children
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
											majorzTree.removeNode(clds[i]);
										}
									}
									
									for(var i in nodes.length){
										var has = false;
										for(var j in clds){
											if(clds[j].id == nodes[i].id){
												has = true;
												break;
											}
										}
										if(!has){
											majorzTree.addNodes(major.currNode,{id:nodes[i].id,name:nodes[i].name,pid:major.currNode.id});
										}
									}
								}
								else{
									for(var i in nodes){
										majorzTree.addNodes(major.currNode,{id:nodes[i].id,name:nodes[i].name,pid:major.currNode.id});
									}
								}
							}
							
							//最后存库
							var courseIds = [];
							for(var i in major.currNode.children){
								courseIds.push(major.currNode.children[i].id);
							}
							$.ajax({url:'${ctx}/major/setCourse',async:false,dataType:'json',
								data:{majorId:major.currNode.id,courseIds:courseIds},
								success:function(data){
									$.sm.handleResult(data,function(data){
										$("#major_course_w").window("close");
									})
								}})
						},
						
						beforeRename:function(treeId, treeNode, newName, isCancel){
							var ztree = $.fn.zTree.getZTreeObj(treeId);
							
							
							if(treeNode.name == newName){
								return true;
							}
							
							var res = false;
							treeNode.name = newName;
							$.ajax({ url: ztree.saveUrl,dataType:'json',data:treeNode,async:false, 
								success: function(data){
									$.sm.handleResult(data);
									if(data.status == $.sm.ResultStatus_Ok){
										if(!treeNode.id){
											treeNode.id = data.data.id;
										}
										res = true;
									}
							      }});
							
							return res;
							
						},
						
						addHoverDom : function(treeId, treeNode) {
							if(treeNode.id != major.rootId && treeNode.pid != major.rootId){
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
								major.currNode = treeNode;
								
								if(treeNode.id == major.rootId){
									var ordno = 1;
									if(treeNode.children && treeNode.children.length > 0){
										ordno = treeNode.children.length + 1;
									}
									var da = {ordno:ordno};
									$("#major_add").form("clear");
									$("#major_add").form("load",da);
									$("#major_buttons").show();
								}
								else{
									//添加课程
									$("#major_course_w").window("open");
									//清空选中
									majorCoursezTree.checkAllNodes(false);
									//选中已选择的
									if(treeNode.children){
										for(var i in treeNode.children){
											var nd = majorCoursezTree.getNodesByParam("id",treeNode.children[i].id);
											majorCoursezTree.checkNode(nd,true);
										}
									}
									
								}
								return false;
							});
						}
						
				};
				major.treeSetting = {
					view: {
						addHoverDom: major.addHoverDom,
						removeHoverDom: ztreef.removeHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						renameTitle:I18N.update,
						showRenameBtn: false,
						showRemoveBtn:function(treeId,treeNode){						
							if(treeNode.id == major.rootId){
								return false;
							}
							return true;
						}
					},
					data: {
						simpleData: {
							enable: true,
							pIdKey:"pid"						
						}
					},
					callback: {
						beforeRemove: ztreef.beforeRemove,
						beforeRename: major.beforeRename,
						onClick:major.onClick
					}
				};
				
				major.treezNodes =${treeNodes};
				for(var i in major.treezNodes){
					major.treezNodes[i].pid = major.rootId;
					major.treezNodes[i].isParent = true;
				}
				major.treezNodes.push({id:major.rootId,name:'<s:message code="major"/>',
					pid:null,open:true,isParent:true});
	
				var majorzTree = $.fn.zTree.init($("#majorTree"), major.treeSetting,major.treezNodes);
				majorzTree.saveUrl = "${ctx}/major/add";
				majorzTree.deleteUrl = "${ctx}/major/delete";
				
				function majorSubmitForm(formId){
					$('#' + formId).form('submit',{success:function(data){
						var data = eval('(' + data + ')');
						$.sm.handleResult(data,function(node){
							
							var newNode = node;
							newNode.oldname = newNode.name;
							$("#major_add").form("load",newNode);
							
							if(major.currNode.id == major.rootId){
								newNode.pid = major.rootId;
								newNode.isParent = true;
								majorzTree.addNodes(major.currNode,newNode);
								major.currNode = majorzTree.getNodeByParam("id",newNode.id);								
							}
							else{
								major.currNode.name = newNode.name;
								major.currNode.descr = newNode.descr;
								major.currNode.version = newNode.version;
								majorzTree.updateNode(major.currNode);
							}
						});
					}});
				}
					
			</script>	
			
	<div id="major_course_w" class="easyui-window" title='<s:message code="major.course.select" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 490px; padding: 10px;">
		
			<div class="easyui-panel" style="padding: 5px;width:360px;height:390px;">
			<ul id="majorCourseTree" class="ztree"></ul>
			</div>	
			<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="major.courseSelectOk()" style="width: 80px">
						<s:message code="comm.ok" /></a> 
			</div>
		
		<script type="text/javascript">
			var majorCourseTree = {
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
					}
			};

			majorCourseTree.treezNodes = ${courseTreeNodes};
			for(var i in majorCourseTree.treezNodes){
				if(majorCourseTree.treezNodes[i].type == 't'){
					majorCourseTree.treezNodes[i].isParent = true;
					majorCourseTree.treezNodes[i].nocheck = true;
					majorCourseTree.treezNodes[i].open = true;
				}
			}
			var majorCoursezTree = $.fn.zTree.init($("#majorCourseTree"), majorCourseTree.treeSetting,majorCourseTree.treezNodes);
		</script>
	</div>
			
			
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>