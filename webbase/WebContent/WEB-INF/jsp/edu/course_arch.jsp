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
			<div class="easyui-layout" data-options="fit:true" >
        		 <div data-options="region:'west',border:false,collapsible:false" style="width:50%">
        		 	<h3>
						<s:message code="course.title" />
					</h3>
					<div class="easyui-panel" data-options="fit:true" >
		        		 <div class="easyui-layout" data-options="fit:true" >
			        		 <div data-options="region:'west',border:false,collapsible:false" style="width:100%">
								<ul id="treeDemo" class="ztree"></ul>
			        		 </div>
						</div>
					</div>
        		 </div>
				 <div data-options="region:'east',border:false"  style="width:49%">
					<h3>
						<s:message code="course.title" />
					</h3>
					<div class="easyui-panel" data-options="fit:true" >
		        		 <div class="easyui-layout" data-options="fit:true" >
			        		 <div data-options="region:'west',border:false,collapsible:false" style="width:100%">
								<ul id="treeDemo2" class="ztree"></ul>
			        		 </div>
						</div>
					</div>
				</div>
			</div>
			<SCRIPT type="text/javascript">
		<!--
		var setting = {
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false,
				drag:{isMove: false}
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeDrag: beforeDrag,
				beforeDrop: beforeDrop
			}
		};

		var zNodes =[
			{ id:1, pId:0, name:"父节点 1", open:true},
			{ id:11, pId:1, name:"叶子节点 1-1"},
			{ id:12, pId:1, name:"叶子节点 1-2"},
			{ id:13, pId:1, name:"叶子节点 1-3"},
			{ id:2, pId:0, name:"父节点 2", open:true},
			{ id:21, pId:2, name:"叶子节点 2-1"},
			{ id:22, pId:2, name:"叶子节点 2-2"},
			{ id:23, pId:2, name:"叶子节点 2-3"},
			{ id:3, pId:0, name:"父节点 3", open:true},
			{ id:31, pId:3, name:"叶子节点 3-1"},
			{ id:32, pId:3, name:"叶子节点 3-2"},
			{ id:33, pId:3, name:"叶子节点 3-3"}
		];

		function beforeDrag(treeId, treeNodes) {
			for (var i=0,l=treeNodes.length; i<l; i++) {
				if (treeNodes[i].drag === false) {
					return false;
				}
			}
			return true;
		}
		function beforeDrop(treeId, treeNodes, targetNode, moveType) {
			return targetNode ? targetNode.drop !== false : true;
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$.fn.zTree.init($("#treeDemo2"), setting);
			
		});
		//-->
	</SCRIPT>
		</div>
	</div>
	<%@ include file="/WEB-INF/jsp/frame/footer.jsp"%>
</body>
</html>