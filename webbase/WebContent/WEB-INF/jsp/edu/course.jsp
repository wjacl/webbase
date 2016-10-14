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
		<s:message code="course.title" />
	</h3>
	
	<div id="course_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$.ad.toAdd('course_w','<s:message code='course' />','course_add','${ctx }/course/add');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='comm.add' /></a>
			<a href="javascript:$.ad.toUpdate('course_grid','course_w','<s:message code='course' />','course_add','${ctx }/course/update',{oldname:'name'})"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('course_grid','${ctx }/course/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		<div>
			<form id="course_query_form">
				<s:message code="course.name" />
				: <input class="easyui-textbox" style="width: 100px" 
					name="name_like_string">
				<s:message code="course.type" />
				: <input class="easyui-combobox" style="width: 100px" id="course_type"
					name="type_in_string"
					data-options="url:'${ctx }/dict/get?pvalue=cour.type',method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true">
				
				<a
					href="javascript:$.ad.gridQuery('course_query_form','course_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>

	<table class="easyui-datagrid" id="course_grid" style="width: 880px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/course/query',method:'post',toolbar:'#course_tb'">
		<thead>
			<tr> 
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:140"><s:message
						code="course.name" /></th>
				<th
					data-options="field:'hour',align:'right',width:60,sortable:'true'"><s:message
						code="course.hour" /></th>
				<th
					data-options="field:'credit',align:'right',width:60,sortable:'true'"><s:message
						code="course.credit" /></th>
				<th
					data-options="field:'type',width:80,sortable:'true',formatter:course.typeFormatter"><s:message
						code="course.type" /></th>
				<th data-options="field:'createTime',align:'center',sortable:'true',width:80,formatter:$.ad.dateFormatter"><s:message
						code="course.createTime" /></th>
				<th data-options="field:'descr',width:400"><s:message
						code="course.descr" /></th>
				
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		var course = {
			types:false,
			typeFormatter:function(value,row,index){
				if(!course.types){
					course.types = $('#course_type').combobox("getData");
				}
				return $.ad.getName(value,course.types,'value');
			}
		};
	</script>
	
	<div id="course_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 430px; padding: 10px;">
		<div class="content">
				<form id="course_add" method="post" action="${ctx }/course/add">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'<s:message code="course.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/course/nameCheck','name','#course_oldname']},
							invalidMessage:'<s:message code="course.name.exits"/>'">
						<input type="hidden" name="oldname" id="course_oldname" />
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-numberbox" name="hour" style="width: 100%"
							data-options="label:'<s:message code="course.hour"/>:',required:true,
							max:999">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-numberbox" name="credit" style="width: 100%"
							data-options="label:'<s:message code="course.credit"/>:',required:true,
							max:999">
					</div>			
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" style="width: 100%" 
							name="type"
							data-options="url:'${ctx }/dict/get?pvalue=cour.type',method:'get',
				                    valueField:'value',
				                    textField:'name',
				                    panelHeight:'auto',
			                    	label:'<s:message code="course.type"/>:'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="descr" style="width: 100%"
							data-options="label:'<s:message code="course.descr"/>:',
							validType:{length:[0,300]},multiline:true,height:60">
					</div>
					
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('course_add','course_grid','course_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('course_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>