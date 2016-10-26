<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
<script type="text/javascript" src="${ctx }/js/jquery-easyui/datagrid-cellediting.js"></script>
<script type="text/javascript">
	var times = ${times};
	var yu = '<s:message code="clazzView.year.unit"/>';
	var schoolNodes = ${treeNodes}; 
	var rootName = '<s:message code="clazzView.year"/>';
	var courseTreeNodes = ${courseTreeNodes};
	var treeYears = ${treeYears};
	var abc = false;
	var edf = false;
</script>

<app:author path="/clazz/add">
<script type="text/javascript">
	abc = true;
</script>
</app:author>
<app:author path="/clazz/delete">
<script type="text/javascript">
	edf = true;
</script>
</app:author>
<script type="text/javascript" src="${ctx }/js/app/edu/clazz_view.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<h3>
		<s:message code="clazz.title" />
	</h3>
			<div class="easyui-layout" style="width: 100%; height: 500px;">
				<div data-options="region:'west'"
					style="padding: 5px; width: 200px; max-height: 500px;">
					<ul id="clazzViewTree" class="ztree"></ul>
				</div>
				<div data-options="region:'center',border:false"
					style="width: 800px; max-height: 500px; padding: 0px 10px">

					<div class="easyui-panel" data-options="collapsible:true,width:760"
						title='<s:message code="clazzView.info" />'>

						<form id="clazz" method="post" action="${ctx }/clazz/add"
							style="margin-bottom: 0px; padding: 5px 5px 5px 0px">
							<table class="dv-table">
								<tr>
									<th class="dv-label"><s:message code="clazz.name" />:</th>
									<td><input class="easyui-textbox" name="name"
										style="width: 100%"
										data-options="required:true,
											validType:{length:[1,30],myRemote:['${ctx }/clazz/nameExits','name','#clazz_oldname']},
											invalidMessage:'<s:message code="clazz.name.exits"/>'">
										<input type="hidden" name="oldname" id="clazz_oldname" /></td>
									<th class="dv-label"><s:message code="clazz.major" />:</th>
									<td><input class="easyui-combobox" name="major" id="major"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/major/list?sort=ordno&order=asc',
						                    method:'get',
						                    valueField:'id',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.school" />:</th>
									<td><select name="school" class="easyui-combotree"
										style="width: 100%"
										data-options="url:'${ctx }/org/tree',required:true,
						        loadFilter:$.ad.easyTreeDefaultLoadFilter">
									</select></td>
								</tr>
								<tr>
									<th class="dv-label"><s:message code="clazz.admin" />:</th>
									<td><input class="easyui-combobox" name="admin"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/teacher/list?status=s',
						                    method:'get',
						                    valueField:'id',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.status" />:</th>
									<td><input class="easyui-combobox" name="status"
										style="width: 100%;"
										data-options="
						                    url:'${ctx }/dict/get?pvalue=clazz.status',
						                    method:'get',
						                    valueField:'value',
						                    textField:'name',
						                    panelHeight:'auto',
						                    required:true
					                    ">
									</td>
									<th class="dv-label"><s:message code="clazz.startTime" />:</th>
									<td><input class="easyui-datebox" name="startTime"
										data-options="required:true"></td>
								</tr>
								<tr>
									<th class="dv-label"><s:message code="clazz.finishTime" />:</th>
									<td><input class="easyui-datebox" name="finishTime"
										style="width: 100%"></td>
									<th><input type="hidden" name="id" /> <input
										type="hidden" name="version" /></th>
									<td></td>
									<th></th>
									<td>
										<app:author path="/clazz/update">
										<a href="javascript:clazzView.saveClazz()"
											class="easyui-linkbutton" iconCls="icon-save"><s:message code='comm.save' />
										</a>
										</app:author>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div style="height: 9px"></div>
					
					<div class="easyui-panel" data-options="collapsible:true,width:760,
								onBeforeExpand:function(){$('#cour_panel').panel('collapse');return true;}" id="stu_panel"
						title='<s:message code="clazzView.studentInfo" />'>
					
						<div id="student_tb1">
							<app:author path="/student/update">
								<a href="javascript:$.ad.toUpdate('student_grid','student_w','<s:message code='student' />','student_add','${ctx }/student/update',{oldname:'name'})"
									class="easyui-linkbutton" iconCls="icon-edit" plain="true"><s:message code='comm.update' /></a>
							</app:author>
							<app:author path="/student/delete">
								<a href="javascript:$.ad.doDelete('student_grid','${ctx }/student/delete')" class="easyui-linkbutton" iconCls="icon-remove"
									plain="true"><s:message code='comm.remove' /></a>
							</app:author>						
						</div>
					
						<table class="easyui-datagrid" id="student_grid" 
							data-options="rownumbers:true,singleSelect:false,multiSort:true,selectOnCheck:true,width:758,
								height:298,toolbar:'#student_tb1',border:0,
								view: detailview,detailFormatter:student.detailFormatter,onExpandRow:student.onExpandRow
					      ">
							<thead>
								<tr>
									<th data-options="field:'ck',checkbox:true"></th>
									<th data-options="field:'name',width:100"><s:message
											code="p.name" /></th>
									<th data-options="field:'sex',width:60,sortable:'true',formatter:student.sexFormatter"><s:message
											code="p.sex" /></th>
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
					</div>	
					<div style="height: 9px"></div>
					
					<div class="easyui-panel" data-options="collapsible:true,width:760,collapsed:true,
								onBeforeExpand:function(){$('#stu_panel').panel('collapse',true);return true;}" id="cour_panel"
						 title='<s:message code="clazzView.courseInfo" />'>
					<!-- 班级课程计划 -->
					<div id="student_tb2">
						<app:author path="/clazz/saveCourses">
							<app:author path="/clazz/addCourses">
							<a href="javascript:clazzView.course.toAddCourse();" class="easyui-linkbutton"
								iconCls="icon-add" plain="true"><s:message code='comm.add' /></a> 
							</app:author>
							<a href="javascript:clazzView.course.doDelete()" class="easyui-linkbutton" iconCls="icon-remove"
								plain="true"><s:message code='comm.remove' /></a>
							<a href="javascript:clazzView.course.up()"
								class="easyui-linkbutton" iconCls="icon-up" plain="true"><s:message code='comm.up' /></a>	
							<a href="javascript:clazzView.course.down()"
								class="easyui-linkbutton" iconCls="icon-down" plain="true"><s:message code='comm.down' /></a>				
							<a href="javascript:clazzView.course.saveClazzCourse()"
								class="easyui-linkbutton" iconCls="icon-save" plain="true"><s:message code='comm.save' /></a>	
						</app:author>
					</div>
				
					<table class="easyui-datagrid" id="clazz_course"
						data-options="rownumbers:true,singleSelect:false,selectOnCheck:true,width:758,border:0,
								height:298,toolbar:'#student_tb2',
									onEndEdit:function (index, row){
							            var ed = $(this).datagrid('getEditor', {
							                index: index,
							                field: 'teacher'
							            });
							            if(ed){
							            	row.teacherName = $(ed.target).combobox('getText');
							            }
							        }">
						<thead>
							<tr>
								<th data-options="field:'ck',checkbox:true"></th>
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
									},
									editor:{
			                            type:'combobox',
			                            options:{
			                                url:'${ctx }/teacher/list?status=s',
						                    method:'get',
						                    valueField:'id',
						                    textField:'name'
			                              }
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
									},
									editor:{
			                            type:'combobox',
			                            options:{
			                                valueField:'value',
			                                textField:'name',
			                                method:'get',
			                                url:'${ctx }/dict/get?pvalue=c.c.sta',
			                                required:true
			                                }
		                            }"><s:message
										code="clazz.course.status" /></th>
							</tr>
						</thead>
					</table>
				</div>
				</div>
			</div>
	<div id="course_w" class="easyui-window" title='<s:message code="major.course.select" />'
		data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
		style="width: 400px; height: 490px; padding: 10px;">
		
			<div class="easyui-panel" style="padding: 5px;width:360px;height:390px;">
			<ul id="courseTree" class="ztree"></ul>
			</div>	
			<div style="text-align: center; padding: 5px 0">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="clazzView.courseSelectOk()" style="width: 80px">
						<s:message code="comm.ok" /></a> 
			</div>
	</div>
	<%@ include file="/WEB-INF/jsp/edu/student_update_win.jsp"%>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>