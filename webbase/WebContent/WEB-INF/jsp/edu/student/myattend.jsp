<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="appfn" uri="http://wja.com/jsp/app/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript" src="${ctx }/js/app/edu/attend.js"></script>
<script type="text/javascript">
	var addData = {
			personId:'${personId}',
			personType:'${personType}',
			status:0,
			type:4,
			startTime:'${appfn:todayWorkStartTime()}'
	};
</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	
	<h3>
		<s:message code="student.myattend" />
	</h3>
	<div id="attend_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$.ad.openFormWin({wid:'attend_w',wTitle:'<s:message code='attend.leave.apply' />',
				formId:'attend_add',clear:true,initData:addData,url:'${ctx }/attend/add'});" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='attend.leave' /></a> 
			<a href="javascript:$.ad.toUpdate('attend_grid','attend_w','<s:message code='attend.leave.apply' />','attend_add','${ctx }/attend/update');"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('attend_grid','${ctx }/attend/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		
	</div>
	
	<table class="easyui-datagrid" id="attend_grid" 
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,width:758,
			toolbar:'#attend_tb',sortName:'startTime',sortOrder:'desc',url:'${ctx }/attend/query?personId=${personId }',
			onCheck:attend.leave.onCheck,
			view: detailview,detailFormatter:attend.detailFormatter,onExpandRow:attend.onExpandRow
      ">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'personId',sortable:'true',width:100,formatter:attend.nameFormatter"><s:message
						code="p.name" /></th>
				<th data-options="field:'type',width:60,align:'center',sortable:'true',formatter:attend.typeFormatter"><s:message
						code="attend.type" /></th>
				<th
					data-options="field:'length',width:100,align:'center'"><s:message
						code="attend.length" /></th>
				<th
					data-options="field:'startTime',width:120,align:'center'"><s:message
						code="attend.startTime" /></th>
				<th
					data-options="field:'endTime',width:120,align:'center'"><s:message
						code="attend.endTime" /></th>
				<th
					data-options="field:'status',width:100,align:'center',sortable:'true',formatter:attend.statusFormatter"><s:message
						code="attend.status" /></th>
			</tr>
		</thead>
	</table>
	<div id="attend_w" class="easyui-window" title="<s:message code='attend.leave.apply' />"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 520px; height: 300px; padding: 10px;">
		<%@ include file="/WEB-INF/jsp/attend/leave.jsp"%>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>