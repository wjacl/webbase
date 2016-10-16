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
				
				detailFormatter:function(index,row){
                    return '<div class="ddv" style="padding:5px 10px;height:80px"></div>';
                },
                onExpandRow: function(index,row){
                    var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
                    
                    if(row.addDetail){
                    
                    }else{
                    	var des = '<table class="dv-table" border="0">' +
						'<tr>' +
							'<th><s:message code="p.eduInfo"/></th>'+
							'<th class="dv-label"><s:message code="p.education"/>:</th>' +
							'<td>' + $.ad.getDictName('education',row.education) + '</td>' +
							
							'<th class="dv-label"><s:message code="p.school"/>:</th>' +
							'<td>' + $.ad.nvl(row.school) + '</td>' +
							
							'<th class="dv-label"><s:message code="p.major"/>:</th>' +
							'<td>' + $.ad.nvl(row.major) + '</td>' +
							
							'<th class="dv-label"><s:message code="p.graduateTime"/>:</th>' +
							'<td>' + $.ad.nvl(row.graduateTime) + '</td>' +
						'</tr>' +
						
						'<tr>' +
							'<th style="width:120px"><s:message code="p.emeContInfo"/></th>'+
							'<th class="dv-label" style="width:120px"><s:message code="p.emeContact"/>:</th>' +
							'<td>' + $.ad.nvl(row.emeContact) + '</td>' +
							
							'<th class="dv-label" style="width:120px"><s:message code="p.emeContactPhone"/>:</th>' +
							'<td>' + $.ad.nvl(row.emeContactPhone) + '</td>' +
							
							'<th class="dv-label"><s:message code="p.address"/>:</th>' +
							'<td>' + $.ad.nvl(row.address) + '</td>' +
						
						'</tr>' +
						
						'<tr>' +
							'<th style="width:120px"><s:message code="teacher.course"/></th>'+
							'<td colspan="8">';
							if(row.courses && row.courses.length > 0){
								var cnames = [];
								for(var i in row.courses){
									cnames.push(row.courses[i].name)
								}
								des += cnames.join(",");
							}
							
							des += '</td>' +
					
						'</tr>' +
					'</table>';
			
                    	ddv.append(des);
                    	row.addDetail = true;
                    	$('#dg').datagrid('fixDetailRowHeight',index);
                    }
                    $('#dg').datagrid('fixDetailRowHeight',index);
                },
                
                teacherUpdate:function(){
                	if(!$("#teacher_w").window("options").closed){

        				$("#teacher_courseIds").combobox('reload');
        				var selRows = $("#teacher_grid").datagrid("getSelections");
        				var courseIds = [];
        				var courses = selRows[0].courses;
        				if(courses && courses.length > 0){
        					for(var i in courses){
        						courseIds.push(courses[i].id);
        					}
        				}
        				$("#teacher_courseIds").combobox('setValues', courseIds);
        			}
                	
                }
								 
		};
		
		
	</script> 
	<div id="teacher_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<%-- <a href="javascript:$.ad.toAdd('teacher_w','<s:message code='teacher' />','teacher_add','${ctx }/teacher/add');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='comm.add' /></a>  --%>
			<a href="javascript:$.ad.toUpdate('teacher_grid','teacher_w','<s:message code='teacher' />','teacher_add','${ctx }/teacher/update',{oldname:'name'});teacher.teacherUpdate();"
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

	<table class="easyui-datagrid" id="teacher_grid" style="width: 916px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				view: detailview,detailFormatter:teacher.detailFormatter,onExpandRow:teacher.onExpandRow,
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
		style="width: 780px; height: 460px; padding: 10px;">
		
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
					                    url:'${ctx }/dict/get?pvalue=tea.status',
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
					
					<!-- 可授课课程 -->
					<h5><s:message code="teacher.course"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="teacher.course"/>:</td>
							<td>
								<input class="easyui-combobox" name="courseIds" style="width: 600px" id="teacher_courseIds"
									data-options="
				                    url:'${ctx }/course/list?sort=type&order=asc',
				                    method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    panelHeight:'auto',
	                    			multiple:true
			                    ">
							</td>
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