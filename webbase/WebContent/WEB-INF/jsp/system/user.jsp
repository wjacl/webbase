<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="user.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<div id="mainwrap">
		<div id="content" class="content">
			<h2>
				<s:message code="user.title" />
			</h2>
			<div style="margin: 20px 0;"></div>

			<table class="easyui-datagrid" id="user_grid"
				style="width: 700px;"
				data-options="rownumbers:true,singleSelect:true,pagination:true,multiSort:true,
				url:'${ctx }/user/query',method:'post',toolbar:'#tb'">
				<thead>
					<tr>
						<th data-options="field:'name',width:100"><s:message code="user.name" /></th>
						<th data-options="field:'username',width:100,sortable:'true'"><s:message code="user.username" /></th>
						<th data-options="field:'type',width:100,align:'center',sortable:'true'"><s:message code="user.type" /></th>
						<th data-options="field:'status',width:100,align:'center',sortable:'true'"><s:message code="user.status" /></th>
					</tr>
				</thead>
			</table>
			<div id="tb" style="padding: 5px; height: auto">
				<div style="margin-bottom: 5px">
					<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"></a> 
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true"></a> 
					<!-- <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true"></a> 
					<a href="#" class="easyui-linkbutton" iconCls="icon-cut" plain="true"></a> -->
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"></a>
				</div>
				<div>
					<form id="user_query_form">
					<s:message code="user.name" />: <input class="easyui-textbox" style="width: 120px" name="name_like_string">
					<s:message code="user.username" />: <input class="easyui-textbox" style="width: 120px" name="username_like_string">
					<s:message code="user.type" />: <input class="easyui-combobox" name="type_in_string" style="width:120px;" data-options="
	                    url:'${ctx }/dict/get?pid=user.type',
	                    method:'get',
	                    valueField:'id',
	                    textField:'text',
	                    panelHeight:'auto',
	                    multiple:true,
	                    loadFilter:$.ajaxData.addAllOption
                    ">
					<a href="javascript:$.ajaxData.gridQuery('user_query_form','user_grid')" class="easyui-linkbutton" iconCls="icon-search"><s:message code="comm.query" /></a>
					</form>
				</div>
			</div>

				<script type="text/javascript">
					
						function xxx(node) {
							if (node.text != node.oldText) {
								if (node.id) {
									$.post('${ctx}/dict/update', {
										id : node.id,
										text : node.text
									}, function(data) {
										$.sm.handleResult(data);
									}, 'json');
								} else {
									$.post('${ctx}/dict/add', {
										text : node.text,
										"pid" : node.pid
									}, function(data) {
										node.id = data.data.id;
										$.sm.handleResult(data);
									}, 'json');
								}
							}
						}
				</script>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>