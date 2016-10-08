<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="dict.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<div id="mainwrap">
		<div id="content" class="content">
			<h3>
				<s:message code="dict.title" />
			</h3>
			<div class="easyui-panel" style="padding: 5px;width:300px">
				<ul id="dictTree" class="ztree"></ul>
					
				<script type="text/javascript">
				var dictTreeSetting = {
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
				
				var dictreezNodes =[
									{ id:0, pid:null, name:I18N.dict}
								];
								
				$.ajax({ url: "${ctx }/dict/tree",async:false,dataType:'json', success: function(data){
					if(data && data.length > 0){
						dictreezNodes = data;
					}
			      }});
				
				var dictzTree = $.fn.zTree.init($("#dictTree"), dictTreeSetting,dictreezNodes);
				dictzTree.saveUrl = "${ctx}/dict/save";
				dictzTree.deleteUrl = "${ctx}/dict/remove";
				
				
				</script>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>