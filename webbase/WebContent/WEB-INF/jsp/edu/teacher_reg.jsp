<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript">
function submitOk(data){
	$("#teacher_w").panel("close");
	$("#content").append("<p><s:message code="teacher.info.reg.ok"/></p>")
}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>
	
	<div id="mainwrap">
		<div id="content" class="content min500h">
	<c:if test="${not empty data.sex }"> 
		<h3><s:message code="teacher.tip.audit"/></h3>
	</c:if>
	<c:if test="${empty data.sex }">
		<p><s:message code="p.reg.ok"/></p>
	<h3>
		<s:message code="p.info.reg" />
	</h3>
	
	<div id="teacher_w" class="easyui-panel"
		style="width: 780px; height: 380px; padding: 10px;">
		
				<form id="teacher_add" method="post" action="${ctx }/teacher/update">
					<h5><s:message code="p.base"/>:</h5>
					<table style="width:100%;border:1px solid #ccc;">
						<tr>
							<td><s:message code="p.name"/>:</td>
							<td>
								<input class="easyui-textbox" name="name" style="width: 120px" value="${data.name }"
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
							<td><s:message code="teacher.entryTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="entryTime" style="width: 120px"
								data-options="required:true">
							</td>
						</tr>
						<tr>
							<td><s:message code="p.remark"/>:</td>
							<td colspan="5">
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
					
                    <input type="hidden" name="id"  value="${data.id }"/>
                    <input type="hidden" name="version"  value="${data.version }"/>
				</form>
				<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$.ad.submitForm('teacher_add',null,null,submitOk)" style="width: 80px">
						<s:message code="comm.submit" /></a> 
					<a href="javascript:void(0)"
						class="easyui-linkbutton" onclick="$.ad.clearForm('teacher_add')"
						style="width: 80px"><s:message code="comm.clear" /></a>
				</div>
	</div>
	</c:if>
	</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>