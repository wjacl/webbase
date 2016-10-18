<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
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
				<s:message code="dict.title" />
			</h3>
			<div class="easyui-panel" style="padding: 5px;width:400px;max-height:430px;">
				<ul id="dictTree" class="ztree"></ul>
					
				<script type="text/javascript">
				var dictTreeSetting = {
					view: {
						addHoverDom: dictAddHoverDom,
						removeHoverDom: ztreef.removeHoverDom,
						selectedMulti: false
					},
					edit: {
						enable: true,
						removeTitle:I18N.remove,
						renameTitle:I18N.update,
						showRenameBtn: function(treeId,treeNode){
							if(treeNode.type == 's'){
								return false;
							}
							return true;
						},
						showRemoveBtn:function(treeId,treeNode){
							if(treeNode.type == 's'){
								return false;
							}
							return true;
						}
					},
					data: {
						simpleData: {
							enable: true,
							pIdKey:"pid"						
						}
					},
					callback: {
						beforeRemove: ztreef.beforeRemove,
						beforeEditName: dictBeforeEditName
					}
				};
				
				var dictreezNodes =[
									{ id:0, pid:null, name:I18N.dict}
								];
								
				$.ajax({ url: "${ctx }/dict/tree",async:false,dataType:'json', success: function(data){
					if(data && data.length > 0){
						dictreezNodes = data;
					}
			      }});
				
				function dictAddHoverDom(treeId, treeNode) {
					var zTree = $.fn.zTree.getZTreeObj(treeId);
					var sObj = $("#" + treeNode.tId + "_span");
					if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
					var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
						+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
					sObj.after(addStr);
					var btn = $("#addBtn_"+treeNode.tId);
					if (btn) btn.bind("click", function(){
						dictCurrNode = treeNode;
						$.ad.toAdd("dict_w",'<s:message code="dict"/>','dict_add');
						var ordno = 1;
						if(treeNode.children && treeNode.children.length > 0){
							if(treeNode.children[treeNode.children.length - 1].ordno){
								ordno = treeNode.children[treeNode.children.length - 1].ordno + 1;
							}
						}
						var da = {pid:treeNode.id,pname:treeNode.name,ordno:ordno};					
						$("#dict_add").form("load",da);
						return false;
					});
				}
				
				function dictBeforeEditName(treeId, treeNode){
					dictCurrNode = treeNode;
					var zTree = $.fn.zTree.getZTreeObj(treeId);
					var formId = "dict_add";
					var wid = "dict_w";
					treeNode.oldDictName = treeNode.name;
					treeNode.oldDictValue = treeNode.value;
					$('#' + formId).form('load',treeNode);	
					$("#" + wid).window({title:I18N.update + '<s:message code="dict"/>'});
					$("#" + wid).window("open");
					return false;
				}
				
				var dictzTree = $.fn.zTree.init($("#dictTree"), dictTreeSetting,dictreezNodes);
				//dictzTree.saveUrl = "${ctx}/dict/save";
				dictzTree.deleteUrl = "${ctx}/dict/remove";
				var dictCurrNode;
				
				function dictSubmitForm(formId,wid){
					$('#' + formId).form('submit',{success:function(data){
						var data = eval('(' + data + ')');
						$.sm.handleResult(data,function(node){
							$('#' + wid).window('close');
							$('#' + formId).form('clear');
							var newNode = node;
							if(newNode.pid == dictCurrNode.id){
								dictzTree.addNodes(dictCurrNode,newNode);
							}
							else{
								dictCurrNode.name = newNode.name;
								dictCurrNode.value = newNode.value;
								dictCurrNode.ordno = newNode.ordno;
								dictzTree.updateNode(dictCurrNode);
							}
						});
					}});
				}
					
				</script>
			</div>
			
			<div id="dict_w" class="easyui-window" 
				data-options="modal:true,closed:true,minimizable:false,maximizable:false,collapsible:false"
				style="width: 400px; height: 400px; padding: 10px;">
				<div class="content">
						<form id="dict_add" method="post" action="${ctx }/dict/save">
							<div style="margin-bottom: 20px">
								<input class="easyui-textbox" name="name" style="width: 100%"
									data-options="label:'<s:message code="dict.name"/>:',required:true,
									validType:{length:[1,20],myRemote:['${ctx }/dict/nameCheck','name','#oldDictName','pid',$('#dictpid').val()]}">
								<input type="hidden" name="oldDictName" id="oldDictName"/>
							</div>
							<div style="margin-bottom: 20px">
								<input class="easyui-textbox" name="value" style="width: 100%"
									data-options="label:'<s:message code="dict.value"/>:',required:true,
									validType:{length:[1,20],myRemote:['${ctx }/dict/valueCheck','value','#oldDictValue','pid',$('#dictpid').val()]}">
								<input type="hidden" name="oldDictValue" id="oldDictValue" />
							</div>
							<div style="margin-bottom: 20px">
								<input class="easyui-numberbox" name="ordno" 
									style="width: 100%"
									data-options="label:'<s:message code="dict.ordno"/>:',required:true">
							</div>
		                    <input type="hidden" name="id" />
		                    <input type="hidden" name="pid" id="dictpid"/>
		                    <input type="hidden" name="version" />
						</form>
						<div style="text-align: center; padding: 5px 0">
							<a href="javascript:void(0)" class="easyui-linkbutton"
								onclick="dictSubmitForm('dict_add','dict_w')" style="width: 80px">
								<s:message code="comm.submit" /></a> 
							<a href="javascript:void(0)"
								class="easyui-linkbutton" onclick="$.ad.clearForm('dict_add')"
								style="width: 80px"><s:message code="comm.clear" /></a>
						</div>
				</div>
			</div>
			
		</div>
	</div>

	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>