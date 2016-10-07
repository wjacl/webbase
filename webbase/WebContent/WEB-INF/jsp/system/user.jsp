<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="user.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	
	<div id="mainwrap">
		<div id="content" class="content">
	<h3>
		<s:message code="user.title" />
	</h3>
	
	<div id="user_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$.ad.toAdd('user_w',I18N.user,'user_add','${ctx }/user/add')" class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.add' />"
				iconCls="icon-add" plain="true"></a> 
			<a href="javascript:$.ad.toUpdate('user_grid','user_w',I18N.user,'user_add','${ctx }/user/update')"
				class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.update' />" iconCls="icon-edit" plain="true"></a>
			<a href="javascript:$.ad.doDelete('user_grid','${ctx }/user/remove')" class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.remove' />" iconCls="icon-remove"
				plain="true"></a>
		</div>
		<div>
			<form id="user_query_form">
				<s:message code="user.name" />
				: <input class="easyui-textbox" style="width: 120px"
					name="name_like_string">
				<s:message code="user.username" />
				: <input class="easyui-textbox" style="width: 120px"
					name="username_like_string">
				<s:message code="user.type" />
				: <input class="easyui-combobox" name="type_in_string" id="userType"
					style="width: 120px;"
					data-options="
	                    url:'${ctx }/dict/get?pid=user.type',
	                    method:'get',
	                    valueField:'id',
	                    textField:'text',
	                    panelHeight:'auto',
	                    multiple:true
                    ">
				<a
					href="javascript:$.ad.gridQuery('user_query_form','user_grid')"
					class="easyui-linkbutton" iconCls="icon-search"><s:message
						code="comm.query" /></a>
			</form>
		</div>
	</div>

	<table class="easyui-datagrid" id="user_grid" style="width: 700px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/user/query',method:'post',toolbar:'#user_tb'">
		<thead>
			<tr>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'name',width:100"><s:message
						code="user.name" /></th>
				<th data-options="field:'username',width:100,sortable:'true'"><s:message
						code="user.username" /></th>
				<th
					data-options="field:'type',width:100,sortable:'true',formatter:userTypeFormatter"><s:message
						code="user.type" /></th>
				<th
					data-options="field:'status',width:100,align:'center',sortable:'true',formatter:userStatusFormatter"><s:message
						code="user.status" /></th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
		var userTypes;	
		function userTypeFormatter(value,row,index){
			if(!userTypes){
				userTypes = $('#userType').combobox("getData");
			}
		
			for(var i in userTypes){
				if(userTypes[i].id == value){
					return userTypes[i].text;
				}
			}
		}
		var userStatus;
		function userStatusFormatter(value,row,index){
			if(!userStatus){
				$.ajax({ url: "${ctx }/dict/get?pid=user.status",async:false, success: function(data){
			        userStatus = data;
			      }});
			}
			
			for(var i in userStatus){
				if(userStatus[i].id == value){
					return userStatus[i].text;
				}
			}
		}
	</script>
	
	<div id="user_w" class="easyui-window" title='<s:message code="user.add" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 400px; padding: 10px;">
		<div class="content">
				<form id="user_add" method="post" action="${ctx }/user/add">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="name" style="width: 100%"
							data-options="label:'<s:message code="user.name"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="username" style="width: 100%"
							data-options="label:'<s:message code="user.username"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd"/>:',required:true">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pid=user.type',
		                    method:'get',
		                    valueField:'id',
		                    textField:'text',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="user.type"/>:'
	                    ">
                    </div>
                    <input type="hidden" name="id" />
                    <input type="hidden" name="version" />
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('user_add','user_grid','user_w')" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('user_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>