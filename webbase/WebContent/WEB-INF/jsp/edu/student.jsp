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
	
	<div id="mainwrap">
		<div id="content" class="content">
	<h3>
		<s:message code="student.title" />
	</h3>
		
	<script type="text/javascript">
		var student = {
				majors:null,
				majorFormatter:function(value,row,index){
					if(!student.majors){
						student.majors = $('#major').combobox("getData");
					}
					return $.ad.getName(value,student.majors,'value');
				},
				
				schools:null,
				schoolLoadFilter:function(data){
					student.schools = data;
					return $.ad.easyTreeDefaultLoadFilter(data);
				},
				schoolFormatter:function(value,row,index){
					return $.ad.getName(value,student.schools);
				},
				
				status:null,
				statusFormatter:function(value,row,index){
					if(!student.status){
						student.status = $('#student_status').combobox("getData");
					}
					return $.ad.getName(value,student.status,'value');
				},
				
				admins:null,
				adminFormatter:function(value){
					if(!student.admins){
						student.admins = $('#student_admin').combobox("getData");
					}
					return $.ad.getName(value,student.admins);
				}				
		};
	</script>
	<div id="student_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$.ad.toAdd('student_w','<s:message code='student' />','student_add','${ctx }/student/add');" class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.add' />"
				iconCls="icon-add" plain="true"></a> 
			<a href="javascript:$.ad.toUpdate('student_grid','student_w','<s:message code='student' />','student_add','${ctx }/student/update',{oldname:'name'})"
				class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.update' />" iconCls="icon-edit" plain="true"></a>
			<a href="javascript:$.ad.doDelete('student_grid','${ctx }/student/delete')" class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.remove' />" iconCls="icon-remove"
				plain="true"></a>
		</div>
		<div>
			<form id="student_query_form">
				<s:message code="student.name" />
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
					
		             <s:message code="student.major"/>:
						<input class="easyui-combobox" name="major_in_string" id="major"
						style="width: 100px"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=major',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
	                    
						<s:message code="student.school"/>:
						<select name="school_in_string" class="easyui-combotree" style="width: 160px" id="student_school"
						        data-options="url:'${ctx }/org/tree',
	                    		multiple:true,
						        loadFilter:student.schoolLoadFilter">
						</select>
						
						<s:message code="student.admin"/>:
						<input class="easyui-combobox" name="admin_in_string" id="student_admin"
						style="width: 100px"
						data-options="
		                    url:'${ctx }/user/find?type_eq_string=A',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
	                  <s:message code="student.status"/>:
						<input class="easyui-combobox" name="status_in_string" id="student_status"
						style="width: 80px;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=student.status',
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
				<th data-options="field:'sex',width:100,sortable:'true',formatter:student.sexFormatter"><s:message
						code="p.sex" /></th>
				<th
					data-options="field:'clazz',width:100,sortable:'true',formatter:student.clazzFormatter"><s:message
						code="clazz" /></th>
				<th
					data-options="field:'phone',width:100"><s:message
						code="p.phone" /></th>
				<th
					data-options="field:'qq',width:100"><s:message
						code="p.qq" /></th>
				<th
					data-options="field:'email',width:100"><s:message
						code="p.email" /></th>
				<th
					data-options="field:'auditStatus',width:100,align:'center',sortable:'true',formatter:student.auditStatusFormatter"><s:message
						code="p.auditStatus" /></th>
			</tr>
		</thead>
	</table>
	
	<div id="student_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 490px; padding: 10px;">
		<div class="content">
				<form id="student_add" method="post" action="${ctx }/student/add">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'<s:message code="student.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/student/nameExits','name','#student_oldname']},
							invalidMessage:'<s:message code="student.name.exits"/>'">
						<input type="hidden" name="oldname" id="student_oldname" />
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="major"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=major',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="student.major"/>:'
	                    ">
                    </div>
					<div style="margin-bottom: 20px">
						<select name="school" class="easyui-combotree" style="width: 100%"
						        data-options="url:'${ctx }/org/tree',required:true,
						        loadFilter:$.ad.easyTreeDefaultLoadFilter,
						        label:'<s:message code="student.school"/>:'">
						</select>
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="admin"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/user/find?type_eq_string=A',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="student.admin"/>:'
	                    ">
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="status"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=student.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="student.status"/>:'
	                    ">
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-datebox" name="startTime" style="width: 100%"
							data-options="label:'<s:message code="student.startTime"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-datebox" name="finishTime" style="width: 100%"
							data-options="label:'<s:message code="student.finishTime"/>:'">
					</div>
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('student_add','student_grid','student_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('student_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>