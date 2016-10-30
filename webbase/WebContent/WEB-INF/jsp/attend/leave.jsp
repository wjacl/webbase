<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<form id="attend_add" method="post" action="${ctx }/attend/add">
	<table style="width:100%;border:0px solid #ccc;">
		<tr>
			<td style="width:70px"><s:message code="attend.apply.person"/>:</td>
			<td colspan="3">
				${sessionUser.name }
				<input type="hidden" name="personId" value="${personId }"/>               
				<input type="hidden" name="personType" value="${personType }" id="attend_personType"/>
				<input type="hidden" name="status" value="0" id="attendStatus"/>
				<input type="hidden" name="id" />
				<input type="hidden" name="version" />
			</td>	
			<td><s:message code="attend.type"/>:</td>
			<td>
				<input class="easyui-combobox" name="type" style="width: 140px"
					data-options="
                    data:I18N.attend_leave_type,
                    valueField:'value',
                    textField:'name',
                    panelHeight:'auto',
                    required:true
                   ">
			</td>
			<td><s:message code="attend.length"/>:</td>
			<td>
				<input class="easyui-numberbox" name="length" style="width: 140px"
				data-options="required:true,precision:1">
			</td>
		</tr>
		<tr>
			<td><s:message code="attend.startTime"/>:</td>
			<td>
				<input class="easyui-datetimebox" data-options="required:true,showSeconds:false" id="attend_startTime"
					name="startTime" style="width: 140px">
			</td>
			
			<td><s:message code="attend.endTime"/>:</td>
			<td>
				<input class="easyui-datetimebox" data-options="showSeconds:false" id="attend_endTime"
					name="endTime" style="width: 140px">
			</td>
		</tr>
		<tr>						
			<td><s:message code="attend.reason"/>:</td>
			<td colspan="3">
				<input class="easyui-textbox" name="reason" style="width: 100%"
				data-options="validType:'maxLength[200]',multiline:true">
			</td>
		</tr>
		<tr>						
			<td><s:message code="attend.remark"/>:</td>
			<td colspan="3">
				<input class="easyui-textbox" name="remark" style="width: 100%"
				data-options="validType:'maxLength[200]',multiline:true">
			</td>
		</tr>
	</table>
	<div style="text-align: center; padding: 5px 0">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="$.ad.submitForm('attend_add','attend_grid','attend_w')" style="width: 80px">
			<s:message code="comm.submit" /></a> 
	</div>
</form>