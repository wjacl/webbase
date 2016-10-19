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
		<s:message code="clazz.title" />
	</h3>
		
	<script type="text/javascript">
		var clazz = {
				majors:null,
				majorFormatter:function(value,row,index){
					if(!clazz.majors){
						clazz.majors = $('#major').combobox("getData");
					}
					return $.ad.getName(value,clazz.majors,'id');
				},
				
				schools:null,
				schoolLoadFilter:function(data){
					clazz.schools = data;
					return $.ad.easyTreeDefaultLoadFilter(data);
				},
				schoolFormatter:function(value,row,index){
					return $.ad.getName(value,clazz.schools);
				},
				
				status:null,
				statusFormatter:function(value,row,index){
					if(!clazz.status){
						clazz.status = $('#clazz_status').combobox("getData");
					}
					return $.ad.getName(value,clazz.status,'value');
				},
				
				admins:null,
				adminFormatter:function(value){
					if(!clazz.admins){
						clazz.admins = $('#clazz_admin').combobox("getData");
					}
					return $.ad.getName(value,clazz.admins);
				}				
		};
	</script>
	<div id="clazz_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$.ad.toAdd('clazz_w','<s:message code='clazz' />','clazz_add','${ctx }/clazz/add');" class="easyui-linkbutton"
				iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
			<a href="javascript:$.ad.toUpdate('clazz_grid','clazz_w','<s:message code='clazz' />','clazz_add','${ctx }/clazz/update',{oldname:'name'})"
				class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
			<a href="javascript:$.ad.doDelete('clazz_grid','${ctx }/clazz/delete')" class="easyui-linkbutton" iconCls="icon-remove"
				plain="true"><s:message code='comm.remove' /></a>
		</div>
		<div>
			<form id="clazz_query_form">
				<s:message code="clazz.name" />
				: <input class="easyui-textbox" style="width: 100px"
					name="name_like_string">
					
		             <s:message code="clazz.major"/>:
						<input class="easyui-combobox" name="major_in_string" id="major"
						style="width: 100px"
						data-options="
		                    url:'${ctx }/major/list?sort=ordno&order=asc',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
	                    
						<s:message code="clazz.school"/>:
						<select name="school_in_string" class="easyui-combotree" style="width: 160px" id="clazz_school"
						        data-options="url:'${ctx }/org/tree',
	                    		multiple:true,
						        loadFilter:clazz.schoolLoadFilter">
						</select>
						
						<s:message code="clazz.admin"/>:
						<input class="easyui-combobox" name="admin_in_string" id="clazz_admin"
						style="width: 100px"
						data-options="
		                    url:'${ctx }/user/find?type_eq_string=A',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
	                  <s:message code="clazz.status"/>:
						<input class="easyui-combobox" name="status_in_string" id="clazz_status"
						style="width: 80px;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=clazz.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
	                    	multiple:true
	                    ">
				<a
					href="javascript:$.ad.gridQuery('clazz_query_form','clazz_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>

	<table class="easyui-datagrid" id="clazz_grid" style="width: 820px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/clazz/query',method:'post',toolbar:'#clazz_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:100"><s:message
						code="clazz.name" /></th>
				<th data-options="field:'major',width:100,sortable:'true',formatter:clazz.majorFormatter"><s:message
						code="clazz.major" /></th>
				<th
					data-options="field:'school',width:100,sortable:'true',formatter:clazz.schoolFormatter"><s:message
						code="clazz.school" /></th>
				<th
					data-options="field:'status',width:100,align:'center',sortable:'true',formatter:clazz.statusFormatter"><s:message
						code="clazz.status" /></th>
				<th
					data-options="field:'admin',width:100,align:'left',formatter:clazz.adminFormatter"><s:message
						code="clazz.admin" /></th>
				<th
					data-options="field:'startTime',width:100,align:'center'"><s:message
						code="clazz.startTime" /></th>
				<th
					data-options="field:'finishTime',width:100,align:'center'"><s:message
						code="clazz.finishTime" /></th>
			</tr>
		</thead>
	</table>
	
	<div id="clazz_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 490px; padding: 10px;">
		<div class="content">
				<form id="clazz_add" method="post" action="${ctx }/clazz/add">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'<s:message code="clazz.name"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/clazz/nameExits','name','#clazz_oldname']},
							invalidMessage:'<s:message code="clazz.name.exits"/>'">
						<input type="hidden" name="oldname" id="clazz_oldname" />
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="major"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/major/list?sort=ordno&order=asc',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="clazz.major"/>:'
	                    ">
                    </div>
					<div style="margin-bottom: 20px">
						<select name="school" class="easyui-combotree" style="width: 100%"
						        data-options="url:'${ctx }/org/tree',required:true,
						        loadFilter:$.ad.easyTreeDefaultLoadFilter,
						        label:'<s:message code="clazz.school"/>:'">
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
		                    label:'<s:message code="clazz.admin"/>:'
	                    ">
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="status"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=clazz.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="clazz.status"/>:'
	                    ">
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-datebox" name="startTime" style="width: 100%"
							data-options="label:'<s:message code="clazz.startTime"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-datebox" name="finishTime" style="width: 100%"
							data-options="label:'<s:message code="clazz.finishTime"/>:'">
					</div>
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('clazz_add','clazz_grid','clazz_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('clazz_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>