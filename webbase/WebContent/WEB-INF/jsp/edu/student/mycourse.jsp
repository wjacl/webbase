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
	
	<h3>
		<s:message code="student.mycourse" />
	</h3>
	<table class="easyui-datagrid" id="clazz_course"
		data-options="rownumbers:true,singleSelect:false,width:652,
				url:'${ctx }/clazz/courses?clazzId=${clazzId }'">
		<thead>
			<tr>
				<th data-options="field:'course',width:100,formatter:function(value,row){
						if(value){
							return value.name;
						}
						return '';
					}
				"><s:message
						code="course.name" /></th>
				<th data-options="field:'hour',width:60,formatter:function(value,row){
						if(row.course){
							return row.course.hour;
						}
						return '';
					}
				"><s:message
						code="course.hour" /></th>
				<th data-options="field:'credit',width:60,formatter:function(value,row){
						if(row.course){
							return row.course.credit;
						}
						return '';
					}"><s:message
						code="course.credit" /></th>
				<th
					data-options="field:'teacher',width:100,formatter:function(value,row){
							return row.teacherName;
					}"><s:message
						code="clazz.course.teacher" /></th>
				<th
					data-options="field:'startTime',width:100,editor:'datebox'"><s:message
						code="clazz.course.startTime" /></th>
				<th
					data-options="field:'finishTime',width:100,editor:'datebox'"><s:message
						code="clazz.course.finishTime" /></th>
				<th
					data-options="field:'status',width:100,formatter:function(value){
						return $.ad.getDictName('c.c.sta',value);
					}"><s:message
						code="clazz.course.status" /></th>
			</tr>
		</thead>
	</table>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>