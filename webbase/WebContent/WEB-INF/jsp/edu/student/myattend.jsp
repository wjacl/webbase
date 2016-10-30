<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript" src="${ctx }/js/app/edu/attend.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	
	<h3>
		<s:message code="student.myattend" />
	</h3>
	<div id="attend_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:attend.toReg('<s:message code='attend' />');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='attend.reg' /></a> 
			<a href="javascript:attend.toUpdate('<s:message code='attend' />');"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('attend_grid','${ctx }/attend/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		
	</div>
	
	<table class="easyui-datagrid" id="attend_grid" 
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,width:758,
			toolbar:'#attend_tb',sortName:'startTime',sortOrder:'desc',url:'${ctx }/attend/query?personId=${studentId }',
			view: detailview,detailFormatter:attend.detailFormatter,onExpandRow:attend.onExpandRow
      ">
		<thead>
			<tr>
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
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>