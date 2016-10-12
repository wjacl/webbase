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
		<s:message code="teacher.title" />
	</h3>
		
	<script type="text/javascript">
		var teacher = {
				sexs:false,
				sexFormatter :function(value,row,index){
					if(!teacher.sexs){
						$.ajax({url:'${ctx}/dict/get?pvalue=sex',async:false,dataType:'json',
							success:function(data){
							teacher.sexs = data;
						}});
					}
					return $.ad.getName(value,teacher.sexs,'value');
				},
				
				status:false,
				statusFormatter:function(value,row,index){
					if(!teacher.status){
						teacher.status = $('#teacher_status').combobox("getData");
					}
					return $.ad.getName(value,teacher.status,'value');
				},
								
		};
	</script>
	<div id="teacher_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<%-- <a href="javascript:$.ad.toAdd('teacher_w','<s:message code='teacher' />','teacher_add','${ctx }/teacher/add');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='comm.add' /></a>  --%>
			<a href="javascript:$.ad.toUpdate('teacher_grid','teacher_w','<s:message code='teacher' />','teacher_add','${ctx }/teacher/update',{oldname:'name'})"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('teacher_grid','${ctx }/teacher/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		<div>
			<form id="teacher_query_form">
				<s:message code="p.name" />
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
						
	                  <s:message code="p.status"/>:
						<input class="easyui-combobox" name="status_in_string" id="teacher_status"
						style="width: 80px;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=tea.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
				<a
					href="javascript:$.ad.gridQuery('teacher_query_form','teacher_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>

	<table class="easyui-datagrid" id="teacher_grid" style="width: 890px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/teacher/query',method:'post',toolbar:'#teacher_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:90"><s:message
						code="p.name" /></th>
				<th data-options="field:'sex',width:60,sortable:'true',formatter:teacher.sexFormatter"><s:message
						code="p.sex" /></th>
				<th
					data-options="field:'birthday',align:'center',width:100,sortable:'true'"><s:message
						code="p.birthday" /></th>
				<th
					data-options="field:'phone',width:100"><s:message
						code="p.phone" /></th>
				<th
					data-options="field:'qq',width:100">QQ</th>
				<th
					data-options="field:'email',width:100">Email</th>
				<th
					data-options="field:'status',width:80,align:'center',sortable:'true',formatter:teacher.statusFormatter"><s:message
						code="p.status" /></th>
				<th
					data-options="field:'entryTime',align:'center',width:100"><s:message
						code="teacher.entryTime" /></th>
				<th
					data-options="field:'leaveTime',align:'center',width:100"><s:message
						code="teacher.leaveTime" /></th>
			</tr>
		</thead>
	</table>
	
	<div id="teacher_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 780px; height: 430px; padding: 10px;">
		
				<form id="teacher_add" method="post" action="${ctx }/teacher/add">
					<h5><s:message code="p.base"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="p.name"/>:</td>
							<td>
								<input class="easyui-textbox" name="name" style="width: 120px"
								data-options="required:true,
								validType:{length:[1,30]}">
							</td>
							
							<td><s:message code="p.sex"/>:</td>
							<td>
								<input class="easyui-combobox" name="sex" style="width: 120px"
									data-options="
				                    url:'${ctx }/dict/get?pvalue=sex',
				                    method:'get',
				                    valueField:'value',
				                    textField:'name',
				                    panelHeight:'auto',
				                    required:true
			                    ">
							</td>
							
							<td><s:message code="p.birthday"/>:</td>
							<td>
								<input class="easyui-datebox" name="birthday" style="width: 120px"
								data-options="required:true">
							</td>
						</tr>
						<tr>						
							<td><s:message code="p.phone"/>:</td>
							<td>
								<input class="easyui-textbox" name="phone" style="width: 120px"
								data-options="required:true,validType:'maxLength[30]'">
							</td>
							
							<td>QQ:</td>	
							<td>
								<input class="easyui-textbox" name="qq" style="width: 120px"
								data-options="required:true,validType:'maxLength[20]'">
							</td>
							
							<td>Email:</td>
							<td>
								<input class="easyui-textbox" name="email" style="width: 120px"
								data-options="required:true,validType:['email','maxLength[30]']">
							</td>
						</tr>
						<tr>		
							<td><s:message code="p.status"/>:</td>
							<td>
								<input class="easyui-combobox" name="status"
									style="width: 120px;"
									data-options="
					                    url:'${ctx }/dict/get?pvalue=stu.status',
					                    method:'get',
					                    valueField:'value',
					                    textField:'name',
					                    panelHeight:'auto',
					                    required:true
				                    ">
	                    	</td>
							
							<td><s:message code="teacher.entryTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="entryTime" style="width: 120px"
								data-options="required:true">
							</td>
							
							<td><s:message code="teacher.leaveTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="leaveTime" style="width: 120px">
							</td>
						</tr>
						<tr>
							<td><s:message code="p.address"/>:</td>
							<td colspan="2">
								<input class="easyui-textbox" name="address" style="width: 240px"
								data-options="required:true,validType:'maxLength[50]',multiline:true">
							</td>
							
							<td align="right"><s:message code="p.remark"/>:</td>
							<td colspan="2">
								<input class="easyui-textbox" name="remark" style="width: 240px"
								data-options="validType:'maxLength[200]',multiline:true">
							</td>
						</tr>
					</table>
					
					<!-- 学历信息 -->
					<h5><s:message code="p.eduInfo"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="p.education"/>:</td>
							<td>
								<input class="easyui-combobox" name="education" style="width: 120px"
									data-options="
				                    url:'${ctx }/dict/get?pvalue=education',
				                    method:'get',
				                    valueField:'value',
				                    textField:'name',
				                    panelHeight:'auto',
				                    required:true
			                    ">
							</td>
							
							<td><s:message code="p.school"/>:</td>
							<td>
								<input class="easyui-textbox" name="school" style="width: 120px"
									data-options="required:true,validType:'maxLength[60]'">
							</td>
							
							<td><s:message code="p.major"/>:</td>
							<td>
								<input class="easyui-textbox" name="major" style="width: 120px"
									data-options="required:true,validType:'maxLength[30]'">
							</td>
							
							<td><s:message code="p.graduateTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="graduateTime" style="width: 120px"
								data-options="required:true">
							</td>
						</tr>
					</table>
					
					<!-- 家庭信息 -->
					<h5><s:message code="p.emeContInfo"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="p.emeContact"/>:</td>
							<td>
								<input class="easyui-textbox" name="emeContact" style="width: 140px"
								data-options="required:true,
								validType:'maxLength[30]'">
							</td>
						
							<td><s:message code="p.emeContactPhone"/>:</td>				
							<td>
								<input class="easyui-textbox" name="emeContactPhone" style="width: 140px"
								data-options="required:true,
								validType:'maxLength[40]'">
							</td>
							<td width="200px">&nbsp;</td>
						</tr>
					</table>
					
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('teacher_add','teacher_grid','teacher_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('teacher_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
	</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>