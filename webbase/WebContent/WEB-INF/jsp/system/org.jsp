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
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>