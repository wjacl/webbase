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
		<s:message code="student.title" />
	</h3>
		
	<script type="text/javascript">
		var student = {
				sexs:false,
				sexFormatter :function(value,row,index){
					if(!student.sexs){
						$.ajax({url:'${ctx}/dict/get?pvalue=sex',async:false,dataType:'json',
							success:function(data){
							student.sexs = data;
						}});
					}
					return $.ad.getName(value,student.sexs,'value');
				},
				majors:false,
				majorFormatter:function(value,row,index){
					if(!student.majors){
						student.majors = $('#studentMajor').combobox("getData");
					}
					return $.ad.getName(value,student.majors,'id');
				},
				
				clazz:false,
				clazzFormatter:function(value,row,index){ 
					if(!student.clazz){
						student.clazz = $('#student_clazz').combobox("getData");
					}
					return $.ad.getName(value,student.clazz);
				},
				
				status:false,
				statusFormatter:function(value,row,index){
					if(!student.status){
						student.status = $('#student_status').combobox("getData");
					}
					return $.ad.getName(value,student.status,'value');
				},
								
		};
	</script>
	<div id="student_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px"> 
			<%-- <a href="javascript:$.ad.toAdd('student_w','<s:message code='student' />','student_add','${ctx }/student/add');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='comm.add' /></a>  --%>
			<a href="javascript:$.ad.toUpdate('student_grid','student_w','<s:message code='student' />','student_add','${ctx }/student/update',{oldname:'name'})"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('student_grid','${ctx }/student/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		<div>
			<form id="student_query_form">
				<s:message code="p.name" />
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
					
		             <s:message code="p.major"/>:
						<input class="easyui-combobox" name="learnMajor_in_string" id="studentMajor"
						style="width: 140px"
						data-options="
		                    url:'${ctx }/major/list?sort=ordno&order=asc',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
	                    
						<s:message code="clazz"/>:
						<select name="clazz_in_string" class="easyui-combobox" style="width: 140px" id="student_clazz"
						        data-options="url:'${ctx }/clazz/list?sort=startTime&order=desc',
		                    	method:'get',
				                valueField:'id',
				                textField:'name',
				                multiple:true">
						</select> 
						
	                  <s:message code="p.status"/>:
						<input class="easyui-combobox" name="status_in_string" id="student_status"
						style="width: 80px;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=stu.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
				<a
					href="javascript:$.ad.gridQuery('student_query_form','student_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>

	<table class="easyui-datagrid" id="student_grid" style="width: 820px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/student/query',method:'post',toolbar:'#student_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:100"><s:message
						code="p.name" /></th>
				<th data-options="field:'sex',width:60,sortable:'true',formatter:student.sexFormatter"><s:message
						code="p.sex" /></th>
				<th
					data-options="field:'clazz',width:100,sortable:'true',formatter:student.clazzFormatter"><s:message
						code="clazz" /></th>
				<th
					data-options="field:'learnMajor',width:100,sortable:'true',formatter:student.majorFormatter"><s:message
						code="p.major" /></th>
				<th
					data-options="field:'phone',width:100"><s:message
						code="p.phone" /></th>
				<th
					data-options="field:'startTime',width:100"><s:message
						code="student.startTime" /></th>
				<th
					data-options="field:'status',width:100,align:'center',sortable:'true',formatter:student.statusFormatter"><s:message
						code="p.status" /></th>
				<th
					data-options="field:'finishTime',width:100"><s:message
						code="p.graduateTime" /></th>
			</tr>
		</thead>
	</table>
	<%@ include file="/WEB-INF/jsp/edu/student_update_win.jsp"%>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>