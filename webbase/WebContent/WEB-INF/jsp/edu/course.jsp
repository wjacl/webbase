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
		<s:message code="course.title" />
	</h3>
	<div class="easyui-layout" style="width:620px;height:430px;">
		<div data-options="region:'west'" style="padding: 5px;width:300px;max-height:430px;">
				<ul id="courseTree" class="ztree"></ul>			
		</div>
		<div data-options="region:'center',border:false" style="width:300px;max-height:430px;padding-left:30px"> 
			<div class="content">
				<form id="course_add" method="post" action="${ctx }/course/add">							
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="typeName" style="width: 240px"
							data-options="label:'<s:message code="course.belong"/>:',readonly:true">
					</div>		
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 240px"
							data-options="label:'<s:message code="course.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/course/nameCheck','name','#course_oldname','pid','#course_pid']},
							invalidMessage:'<s:message code="course.name.exits"/>'">
						<input type="hidden" name="oldname" id="course_oldname" />
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type" id="courseType"
							style="width: 240px"
							data-options="
			                    url:'${ctx }/dict/get?pvalue=course.type',
			                    method:'get',
			                    valueField:'value',
			                    textField:'name',
			                    panelHeight:'auto',
		                    	required:true,
		                    	onChange:course.onChange,
		                    	label:'<s:message code="course.dtype"/>:'
		                    ">
	                </div>
					<div style="margin-bottom: 20px" id="hourDiv">
						<input class="easyui-numberbox" name="hour" style="width: 240px" id="hour"
							data-options="label:'<s:message code="course.hour"/>:',required:true,
							max:999">
					</div>
					<div style="margin-bottom: 20px" id="creditDiv">
						<input class="easyui-numberbox" name="credit" style="width: 240px" id="credit"
							data-options="label:'<s:message code="course.credit"/>:',required:true,
							max:999">
					</div>			
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="descr" style="width: 240px"
							data-options="label:'<s:message code="course.descr"/>:',
							validType:{length:[0,300]},multiline:true,height:60">
					</div>
					<input type="hidden" name="ordno" />
                    <input type="hidden" name="id" />
                    <input type="hidden" name="pid"  id="course_pid"/>
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0;width:240px;display:none" id="course_buttons">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="courseSubmitForm('course_add')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('course_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
			</div>
		</div>
	</div>
				<script type="text/javascript">
				var course = {
						rootId:0,
						type_t:'t',
						type_c:'c',
						currNode : null,
						onChange : function(newValue,oldValue){
							if(newValue == course.type_t){
								$("#hourDiv").hide();
								$("#creditDiv").hide();
								$("#hour").textbox("setValue",0);
								$("#credit").textbox("setValue",0);
							}
							else{
								$("#hourDiv").show();
								$("#creditDiv").show();
							}
						},
						onClick :function(event, treeId, treeNode, clickFlag){
							course.currNode = treeNode;
							
							if(treeNode.id == course.rootId){
								$("#course_buttons").hide();
							}
							else {
								treeNode.oldname = treeNode.name;
								treeNode.typeName = treeNode.getParentNode().name;
								$("#course_add").form("load",treeNode);
								$("#courseType").combobox("readonly",true);
								if(treeNode.type == course.type_t){
									$("#hourDiv").hide();
									$("#creditDiv").hide();
								}else{
									$("#hourDiv").show();
									$("#creditDiv").show();
								}
								$("#course_buttons").show();
							}
						},
						
						addHoverDom : function(treeId, treeNode) {
							if(treeNode.type != course.type_t){
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
								course.currNode = treeNode;
								var ordno = 1;
								if(treeNode.children && treeNode.children.length > 0){
									ordno = treeNode.children.length + 1;
								}

								$("#courseType").combobox("readonly",false);
								var dtype = course.type_c;
								if(treeNode.id == course.rootId){
									dtype = course.type_t;
									$("#hourDiv").hide();
									$("#creditDiv").hide();
								}
								else{									
									$("#hourDiv").show();
									$("#creditDiv").show();
								}
								
								var da = {pid:treeNode.id,type:dtype,ordno:ordno,typeName:treeNode.name};
								$("#course_add").form("clear");
								$("#course_add").form("load",da);
								$("#course_buttons").show();
								
								return false;
							});
						}
						
				};
				course.treeSetting = {
					view: {
						addHoverDom: course.addHoverDom,
						removeHoverDom: ztreef.removeHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						renameTitle:I18N.update,
						showRenameBtn: false,
						showRemoveBtn:function(treeId,treeNode){						
							if(treeNode.id == course.rootId){
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
						onClick:course.onClick
					}
				};
				
				course.treezNodes =${treeNodes};
				for(var i in course.treezNodes){
					if(course.treezNodes[i].type == course.type_t){
						course.treezNodes[i].isParent = true;
					}
				}
				course.treezNodes.push({id:course.rootId,name:'<s:message code="course.type"/>',
					pid:null,type:'t',open:true,isParent:true});
	
				var coursezTree = $.fn.zTree.init($("#courseTree"), course.treeSetting,course.treezNodes);
				coursezTree.saveUrl = "${ctx}/course/add";
				coursezTree.deleteUrl = "${ctx}/course/delete";
				
				function courseSubmitForm(formId){
					$('#' + formId).form('submit',{success:function(data){
						var data = eval('(' + data + ')');
						$.sm.handleResult(data,function(node){
							
							var newNode = node;
							newNode.oldname = newNode.name;
							$("#course_add").form("load",newNode);
							
							if(newNode.pid == course.currNode.id){
								coursezTree.addNodes(course.currNode,newNode);
								course.currNode = coursezTree.getNodeByParam("id",newNode.id);
								
							}
							else{
								course.currNode.name = newNode.name;
								course.currNode.hour = newNode.hour;
								course.currNode.credit = newNode.credit;
								course.currNode.remark = course.currNode.remark;
								coursezTree.updateNode(course.currNode);
							}
						});
					}});
				}
					
			</script>	

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>