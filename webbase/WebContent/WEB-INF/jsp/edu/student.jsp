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
					return $.ad.getName(value,student.majors,'value');
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
		                    url:'${ctx }/dict/get?pvalue=major',
		                    method:'get',
		                    valueField:'value',
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
	
	<div id="student_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 780px; height: 430px; padding: 10px;">
		
				<form id="student_add" method="post" action="${ctx }/student/add">
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
							<td><s:message code="p.address"/>:</td>
							<td colspan="3">
								<input class="easyui-textbox" name="address" style="width: 300px"
								data-options="required:true,validType:'maxLength[50]'">
							</td>
							
							<td><s:message code="clazz"/>:</td>
							<td>
								<input class="easyui-combobox" name="clazz" style="width: 120px"
								data-options="url:'${ctx }/clazz/registGet',
				                    method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    required:true">
							</td>
						</tr>
						<tr>
							
							<td><s:message code="p.major"/>:</td>
							<td>
								<input class="easyui-combobox" name="learnMajor"
									style="width: 120px;"
									data-options="
					                    url:'${ctx }/dict/get?pvalue=major',
					                    method:'get',
					                    valueField:'value',
					                    textField:'name',
					                    panelHeight:'auto',
					                    required:true
				                    ">
	                    	</td>
							
							<td><s:message code="student.startTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="startTime" style="width: 120px"
								data-options="required:true">
							</td>
							
							<td><s:message code="p.graduateTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="finishTime" style="width: 120px">
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
							
							<td><s:message code="p.remark"/>:</td>
							<td colspan="3">
								<input class="easyui-textbox" name="remark" style="width: 300px"
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
					<h5><s:message code="p.homeInfo"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="p.parent"/>:</td>
							<td>
								<input class="easyui-textbox" name="parent" style="width: 140px"
								data-options="required:true,
								validType:'maxLength[40]'">
							</td>
						
							<td><s:message code="p.phone"/>:</td>				
							<td>
								<input class="easyui-textbox" name="homePhone" style="width: 140px"
								data-options="required:true,
								validType:'maxLength[40]'">
							</td>
							
							<td><s:message code="p.address"/>:</td>
							<td>
								<input class="easyui-textbox" name="home" style="width: 300px"
								data-options="required:true,
								validType:'maxLength[80]'">
							</td>
						</tr>
					</table>
					
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
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>