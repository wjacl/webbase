<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
	<div id="header" class="group wrap header">
		<div class="content">
			<div class="navigation-toggle" data-tools="navigation-toggle"
				data-target="#navbar-1">
				<span><s:message code="sys.app.name"/></span>
			</div>
			<div id="elogo" class="navbar navbar-left">
				<ul>
					<!-- <li>
					<a href="/index.php"><img src="/images/logo2.png" alt="jQuery EasyUI"/></a>
				</li> -->
					<li style="font-size: 28px; font-weight: bold;"><a
						href="index.jsp"><s:message code="sys.app.name"/></a></li>
				</ul>
			</div>
			<div id="navbar-1" class="navbar navbar-right">
				<ul>
					<c:if test="${not empty session_user }">
					<li><a href="javascrit:void(0)"><s:message code="sys.header.hello"/>,${session_user.name }！</a></li>
					<li><a href="${ctx }/logout"><s:message code="sys.logout"/></a></li>
					<li><a href="javascript:pwdUpdate()"><s:message code="user.pwd.update"/></a></li>
					</c:if>
				</ul>
			</div>
			<div style="clear: both"></div>
		</div>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/header.js"></script>
			
		<div id="sys_pwd_update_w" class="easyui-window" title='<s:message code="user.pwd.update" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 400px; padding: 10px;">
		<div class="content">
				<form id="sys_pwd_update_form" method="post" action="${ctx }/user/pwdupdate">
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="oldpassword" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.oldpwd"/>:',required:true,
							validType:{length:[6,20],remote:['${ctx }/user/oldPwdCheck','pwd']},
							invalidMessage:'<s:message code="user.oldpwd.error"/>'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password" type="password"  id="pwd"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd"/>:',required:true,validType:'length[6,20]'">
					</div>
					<div style="margin-bottom: 20px">
						<input class="easyui-textbox" name="password2" type="password"
							style="width: 100%"
							data-options="label:'<s:message code="user.pwd.match"/>:',required:true,
								validType:{equals:['#pwd','<s:message code="user.pwd"/>']}">
					</div>
                    <input type="hidden" name="id" value="${session_user.id }"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('sys_pwd_update_form',null,'sys_pwd_update_w')" style="width: 80px">
						<s:message code="comm.update" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('user_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
		</div>
	</div>
	</div>
	
	