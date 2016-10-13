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
		<s:message code="user.title" />
	</h3>
	
	<div id="user_tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:$('#userRoleComb').combobox('reload');$.ad.toAdd('user_w',I18N.user,'user_add','${ctx }/user/add');" class="easyui-linkbutton easyui-tooltip" title="<s:message code='comm.add' />"
				iconCls="icon-add" plain="true"></a> 
			<a href="javascript:$.ad.toUpdate('user_grid','user_w',I18N.user,'user_add','${ctx }/user/update',{oldUsername:'username'});userUpdate()"
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
	                    url:'${ctx }/dict/get?pvalue=user.type',
	                    method:'get',
	                    valueField:'value',
	                    textField:'name',
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

	<table class="easyui-datagrid" id="user_grid" style="width: 720px;"
		data-options="rownumbers:true,singleSelect:false,pagination:true,multiSort:true,selectOnCheck:true,
				url:'${ctx }/user/query',method:'post',toolbar:'#user_tb',loadFilter:userDataProcess">
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
				<th
					data-options="field:'roles',width:260,align:'left',formatter:userRoleFormatter"><s:message
						code="role" /></th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	
		function userDataProcess(data){
			if(data && data.rows){
				var rows = data.rows;
				for(var i in rows){
					if(rows[i].roles){
						var roles = rows[i].roles;
						for(var j in roles){
							if(roles[j].$ref){
								roles[j] = eval(roles[j].$ref.replace('$',"data"));
							}
						}
					}
				}
			}
			return data;
		}
		
		function userRoleFormatter(value,row,index){
			var text = "";
			var names = [];
			if(value && value.length > 0){
				for(var i in value){
					names.push(value[i].name);
				}
				text = names.join(",");
			}
				
			return text;
		}
	
		var userTypes;	
		function userTypeFormatter(value,row,index){
			if(!userTypes){
				userTypes = $('#userType').combobox("getData");
			}
		
			for(var i in userTypes){
				if(userTypes[i].value == value){
					return userTypes[i].name;
				}
			}
		}
		var userStatus;
		function userStatusFormatter(value,row,index){
			if(!userStatus){
				$.ajax({ url: "${ctx }/dict/get?pvalue=user.status",async:false, success: function(data){
			        userStatus = data;
			      },dataType:'json'});
			}
			
			for(var i in userStatus){
				if(userStatus[i].value == value){
					return userStatus[i].name;
				}
			}
		}
		
		function userUpdate(){
			if(!$("#user_w").window("options").closed){

				$("#userRoleComb").combobox('reload');
				var selRows = $("#user_grid").datagrid("getSelections");
				var roleIds = [];
				var roles = selRows[0].roles;
				if(roles && roles.length > 0){
					for(var i in roles){
						roleIds.push(roles[i].id);
					}
				}
				$("#userRoleComb").combobox('setValues', roleIds);
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
							data-options="label:'<s:message code="user.name"/>:',required:true,validType:'length[1,30]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="username" style="width: 100%"
							data-options="label:'<s:message code="user.username"/>:',required:true,
							validType:{length:[1,30],myRemote:['${ctx }/user/unameCheck','username','#oldUsername']},
							invalidMessage:I18N.user_uname_exits">
						<input type="hidden" name="oldUsername" id="oldUsername" />
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password"  id="pwd"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd"/>:',required:true,validType:'length[6,32]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="type"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=user.type',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="user.type"/>:'
	                    ">
                    </div>
					<div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="status"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/dict/get?pvalue=user.status',
		                    method:'get',
		                    valueField:'value',
		                    textField:'name',
		                    panelHeight:'auto',
		                    required:true,
		                    label:'<s:message code="user.status"/>:'
	                    ">
                    </div>
                    <div style="margin-bottom: 20px">
						<input class="easyui-combobox" name="roleIds"  id="userRoleComb"
						style="width: 100%;"
						data-options="
		                    url:'${ctx }/user/roles',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    panelHeight:'auto',
		                    label:'<s:message code="role"/>:',
	                    	multiple:true
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