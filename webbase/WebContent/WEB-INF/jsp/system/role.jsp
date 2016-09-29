<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="role.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<div id="mainwrap">
		<div id="content" class="content">
			<h2>
				<s:message code="role.title" />
			</h2>
			<div style="margin: 20px 0;"></div>

			<table class="easyui-datagrid" 
				style="width: 700px;"
				data-options="rownumbers:true,singleSelect:true,pagination:true,url:'${ctx }/role/query',method:'get',toolbar:'#tb'">
				<thead>
					<tr>
						<th data-options="field:'id',width:80">Item ID</th>
						<th data-options="field:'name',width:100">Product</th>
						<th data-options="field:'type',width:80,align:'center'">List
							Price</th>
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
					Date From: <input class="easyui-datebox" style="width: 80px">
					To: <input class="easyui-datebox" style="width: 80px">
					Language: <select class="easyui-combobox" panelHeight="auto"
						style="width: 100px">
						<option value="java">Java</option>
						<option value="c">C</option>
						<option value="basic">Basic</option>
						<option value="perl">Perl</option>
						<option value="python">Python</option>
					</select> 
					<a href="#" class="easyui-linkbutton" iconCls="icon-search">Search</a>
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