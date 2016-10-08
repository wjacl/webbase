<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="org.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<div id="mainwrap">
		<div id="content" class="content">
			<h3>
				<s:message code="org.title" />
			</h3>
			<div class="easyui-panel" style="padding: 5px;width:400px">
				<ul id="orgTree" class="ztree"></ul>
				
				<script type="text/javascript">
				var orgTreeSetting = {
					view: {
						addHoverDom: orgAddHoverDom,
						removeHoverDom: orgRemoveHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						renameTitle:I18N.update
					},
					data: {
						simpleData: {
							enable: true,
							pIdKey:"pid"						
						}
					},
					callback: {
						beforeRemove: orgzTreeBeforeRemove,
						beforeRename: orgzTreeBeforeRename
					}
				};

				var orgTreezNodes =[
					{ id:0, pid:0, name:"组织机构"}
				];
				
				$.ajax({ url: "${ctx }/org/tree",async:false, success: function(data){
					if(data && data.length > 0){
						data.push(orgTreezNodes[0]);
						orgTreezNodes = data;
					}
			      }});
				
				function orgzTreeBeforeRename(treeId, treeNode, newName, isCancel) {
					if(newName.length == 0){
						orgzTree.cancelEditName();
						$.sm.alert(I18N.org_name_not_null);
						return false;
					}
					
					if(treeNode.name == newName){
						return true;
					}
					
					var res = false;
					
					$.ajax({ url: "${ctx }/org/save",data:{id:treeNode.id,name:newName,pid:treeNode.pid},async:false, 
						success: function(data){
							$.sm.handleResult(data);
							if(!treeNode.id){
								treeNode.id = data.data;
							}
							res = true;
					      }});
					
					return res;
				}
				
				function orgzTreeBeforeRemove(treeId, treeNode) {
					orgzTree.selectNode(treeNode);
					$.sm.confirmDelete(function(){
						var ids = [];
						orgzTreeGetAllChildrenIds(treeNode,ids);
						if(ids.length == 0){
							orgzTree.removeNode(treeNode);
							return;
						}
						
						$.ajax({ url: "${ctx }/org/delete",method:"post",data:{ids:ids},async:false, 
							success: function(data){
								$.sm.handleResult(data);
								orgzTree.removeNode(treeNode);
						      }});
					});
					return false;
				}
				
				function orgzTreeGetAllChildrenIds(node,ids){
					if(node.id){
						ids.push(node.id);
					}
					if(node.children && node.children.length>0){
						for(var i in node.children){
							orgzTreeGetAllChildrenIds(node.children[i],ids);
						}
					}
				}
				
				function orgAddHoverDom(treeId, treeNode) {
					var sObj = $("#" + treeNode.tId + "_span");
					if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
					var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
						+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
					sObj.after(addStr);
					var btn = $("#addBtn_"+treeNode.tId);
					if (btn) btn.bind("click", function(){
						var zTree = $.fn.zTree.getZTreeObj("orgTree");
						zTree.addNodes(treeNode, {pid:treeNode.id, name:I18N.org_new});
						return false;
					});
				};
				function orgRemoveHoverDom(treeId, treeNode) {
					$("#addBtn_"+treeNode.tId).unbind().remove();
				};
				
				var orgzTree = $.fn.zTree.init($("#orgTree"), orgTreeSetting, orgTreezNodes);
				
				
				</script>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>