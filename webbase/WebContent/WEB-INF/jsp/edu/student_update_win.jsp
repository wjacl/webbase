<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
	<div id="student_w" class="easyui-window"
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 780px; height: 470px; padding: 10px;">
		
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
							<td><s:message code="p.secondContact"/>:</td> 
							<td>
								<input class="easyui-textbox" name=secondContact style="width: 120px"
								data-options="required:true,validType:'maxLength[50]'">
							</td>
						</tr>
						<tr>				
							<td><s:message code="clazz"/>:</td>
							<td>
								<input class="easyui-combobox" name="clazz" style="width: 120px"
								data-options="url:'${ctx }/clazz/registGet',
				                    method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    required:true">
							</td>
							<td><s:message code="p.major"/>:</td>
							<td>
								<input class="easyui-combobox" name="learnMajor"
									style="width: 120px;"
									data-options="
					                    url:'${ctx }/major/list?sort=ordno&order=asc',
					                    method:'get',
					                    valueField:'id',
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
						</tr>
						<tr>
							
							
							<td><s:message code="p.graduateTime"/>:</td>
							<td>
								<input class="easyui-datebox" name="finishTime" style="width: 120px">
							</td>
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
							</tr>
							<tr>
							<td><s:message code="p.remark"/>:</td>
							<td colspan="5">
								<input class="easyui-textbox" name="remark" style="width: 500px"
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
				</div>
	</div>
