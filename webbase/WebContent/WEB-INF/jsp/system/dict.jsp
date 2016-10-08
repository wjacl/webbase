<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:message code="dict.title" /></title>
<%@ include file="/WEB-INF/jsp/frame/comm_css_js.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/frame/header.jsp"%>

	<div id="mainwrap">
		<div id="content" class="content">
			<h3>
				<s:message code="dict.title" />
			</h3>
			<!-- <div style="margin: 20px 0;"></div> -->
			<div class="easyui-panel" style="padding: 5px">
				<ul id="dictTree" class="easyui-tree"
					data-options="
					url: '${ctx }/dict/getTree',
					method: 'get',
					animate: true
				">
				</ul>
				<div id="mm" class="easyui-menu" style="width: 120px;">
					<div onclick="append()" data-options="iconCls:'icon-add'"><s:message code="comm.add" /></div>
					<div onclick="doDelete()" data-options="iconCls:'icon-remove'"><s:message code="comm.remove" /></div>
				</div>
				
				
				<script type="text/javascript">
					// right click node and then display the context menu
					$('#dictTree').tree({
						onClick: function(node){
							if(node.type != 's'){
								node.oldText = node.text;
								$(this).tree('beginEdit',node.target);
							}
						},
						onContextMenu : function(e, node) {
							e.preventDefault();
							$('#dictTree').tree('select', node.target);

							$('#mm > div:last').show();
							$('#mm').menu('show', {
								left : e.pageX,
								top : e.pageY
							});
							
							if(node.id == 0){
								$('#mm > div:last').hide();
							}
						},
						onAfterEdit : function(node){
							if(node.text != node.oldText) {
								if(node.id){
									$.post('${ctx}/dict/update',{id:node.id,text:node.text},function(data){
										$.sm.handleResult(data);
									},'json');
								}
								else {
									$.post('${ctx}/dict/add',{text:node.text,"pid":node.pid},function(data){
										node.id = data.data.id;
										$.sm.handleResult(data);
									},'json');
								}
							}
						}
					});

					function append() {
						var node = $('#dictTree').tree('getSelected');
						$('#dictTree').tree('append', {
							parent : node.target,
							data : {
								text : '',
								pid : node.id
							}
						});
					}
					
					function doDelete(){
						var node = $('#dictTree').tree('getSelected');
						if(node.id == 0){
							$.messager.alert(I18N.dict_root_not_delete);
							return;
						}
						
						$.sm.confirmDelete(function(){
							var node = $('#dictTree').tree('getSelected');
							var ids=[];
							getAllChildrenIds(node,ids);
							$.post('${ctx}/dict/remove',{"ids":ids},function(data){
								$.sm.handleResult(data,function(data){
									$('#dictTree').tree('remove', node.target);
								});
							},'json');
						});
					}
					
					function getAllChildrenIds(node,ids){
						ids.push(node.id);
						if(node.children && node.children.length>0){
							for(var i in node.children){
								getAllChildrenIds(node.children[i],ids);
							}
						}
					}
				</script>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>