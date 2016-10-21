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
		<s:message code="org.title" />
	</h3>
	<div class="easyui-layout" style="width:720px;height:430px;">
		<div data-options="region:'west'" style="padding: 5px;width:300px;max-height:430px;">
		<ul id="orgTree" class="ztree"></ul>
	</div>
		<div data-options="region:'center',border:false" style="width:400px;max-height:430px;"> 
			<div class="content">
				<form id="org_add" method="post" action="${ctx }/org/save">		
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 300px"
							data-options="label:'<s:message code="org.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/org/nameCheck','name','#org_oldname','pid','#pid']},
							invalidMessage:'<s:message code="org.name.exits"/>'">
						<input type="hidden" name="oldname" id="org_oldname" />
					</div>			
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type" style="width: 300px"
							data-options="label:'<s:message code="org.type"/>:',
							url:'${ctx }/dict/get?pvalue=org.type',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true">
					</div>
					<input type="hidden" name="ordno" />
                    <input type="hidden" name="id" />
                    <input type="hidden" name="pid"  id="pid"/>
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0;width:240px;display:none" id="major_buttons">
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
		var org = {
			currNode:null,
			addHoverDom : function(treeId, treeNode) {
					
				var zTree = $.fn.zTree.getZTreeObj(treeId);
				var sObj = $("#" + treeNode.tId + "_span");
				if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
				var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
					+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
				sObj.after(addStr);
				var btn = $("#addBtn_"+treeNode.tId);
				if (btn) btn.bind("click", function(){
					org.currNode = treeNode;				
					if(treeNode.id == major.rootId){
						var ordno = 1;
						if(treeNode.children && treeNode.children.length > 0){
							ordno = treeNode.children[treeNode.children.length - 1].ordno + 100;
						}
						var da = {ordno:ordno};
						$("#major_add").form("clear");
						$("#major_add").form("load",da);
						$("#major_buttons").show();
					}
					else{
						//添加课程
						if(!treeNode.loaded){
							major.loadMajorCourse(treeNode,false);
						}
						$("#major_course_w").window("open");
						//清空选中
						majorCoursezTree.checkAllNodes(false);
						//选中已选择的
						if(treeNode.children){
							for(var i in treeNode.children){
								var nd = majorCoursezTree.getNodesByParam("id",treeNode.children[i].id);
								majorCoursezTree.checkNode(nd[0],true);
							}
						}
						
					}
					return false;
				});
			}
		};
		
				var orgTreeSetting = {
					view: {
						addHoverDom: ztreef.addHoverDom,
						removeHoverDom: ztreef.removeHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						showRenameBtn: false
					},
					data: {
						simpleData: {
							enable: true,
							pIdKey:"pid"						
						}
					},
					callback: {
						beforeRemove: ztreef.beforeRemove,
						beforeRename: ztreef.beforeRename,
						onClick: ztreef.clickToEdit
					}
				};

				var orgTreezNodes =[
					{ id:0, pid:null, name:I18N.org}
				];
				
				$.ajax({ url: "${ctx }/org/tree",async:false,dataType:'json', success: function(data){
					if(data && data.length > 0){
						data.push(orgTreezNodes[0]);
						orgTreezNodes = data;
					}
			      }});
				
				var orgzTree = $.fn.zTree.init($("#orgTree"), orgTreeSetting, orgTreezNodes);
				orgzTree.saveUrl = "${ctx}/org/save";
				orgzTree.deleteUrl = "${ctx}/org/delete";
				
				</script>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>