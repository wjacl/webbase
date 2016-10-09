/**
	jquery ajax 全局设置
	在此js中主要设置当用户session失效、鉴权不通过时的ajax请求的处理。
*/
$.ajaxSetup({traditional:true});

$( document ).ajaxComplete(function( event, xhr, settings ) {
	
	if(xhr.status == 401){ //未认证
		$('#dd').dialog({
		    title: '请登录',
		    width: 600,
		    height: 500,
		    closed: false,
		    cache: false,
		    href: xhr.responseText,
		    modal: true,
		    extractor : function(data) {
				data = $.fn.panel.defaults.extractor(data);
				var tmp = $('<div></div>').html(data);
				data = tmp.find('#content').html();
				tmp.remove();
				return data;
			} 
		});
	}
	else if(xhr.status == 403){//没有权限
		$.messager.alert('警告','您没有权限进行此项操作！','warning');
		return false;
	}
 
});

/**
 * 扩展的提示、结果处理方法插件
 */
$.sm = {
		alert:function(mess){
			$.messager.alert(I18N.ALERT_TITLE,mess);
		},
		
		show:function(mess){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:mess,
                showType:'show'
            });
		},
		
		showAddOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_ADD_OK,
                showType:'show'
            });
		},
		showUpdateOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_UPDATE_OK,
                showType:'show'
            });
		},
		showDeleteOK : function(){
			$.messager.show({
                title:I18N.SHOW_TITLE,
                msg:I18N.OPER_DELETE_OK,
                showType:'show'
            });
		},
		showSysError:function(error){
			$.messager.show({
                title:I18N.ALERT_TITLE,
                msg:I18N.OPER_SYS_ERROR + (error ? ":" + error : ""),
                showType:'show'
            });
		},
		confirmDelete:function(fun){
			 $.messager.confirm(I18N.CONFIRM_TITLE, I18N.CONFIRM_DELETE_MESS, function(r){		 
				 if(r){
	                fun.apply();
				 }
	           });
		},
		
		ResultStatus_Ok:200,   //操作结果码：成功
		ResultStatus_Eorror : 500,  //操作结果码：失败
		
		/**通用的操作结果处理方法 <br> 
		 * 参数:res:结果对象 {status:200,operate:1,mess:"",data:{}}<br>
		 * status表示操作结果200成功，500失败；<br>
		 * operate表示操作：0操作，1新增，2修改，3删除<br>
		 * mess表示结果信息<br>
		 * data表示服务器返回的操作数据<br>
		 * success：成功的回调处理方法 function(data){} <br>
		 * faild的回调处理方法 function(data){}
		 * 
		 */
		handleResult:function(res,success,faild){
			if(res.status == this.ResultStatus_Ok){
				var content = "";
				if(res.mess){
					content = mess;
				}
				else{
					content = I18N.operate_ok[res.operate];
				}
				
				$.messager.show({
	                title:I18N.SHOW_TITLE,
	                msg:content,
	                showType:'show'
	            });
				
				if(success){
					if(typeof success == "function"){
						success.apply(res.data);
					}
				}
			}
			else{
				var content = I18N.operate_faild[res.operate];
				if(res.mess){
					content += mess;
				}
				else{
					content += I18N.OPER_SYS_ERROR;
				}
				
				$.messager.alert(content);
				
				if(faild){
					if(typeof faild == "function"){
						faild.apply(res.data);
					}
				}
			}
		}		
};


/**
 * 将表单序列化为json对象的jquery插件
 */
(function($){  
    $.fn.serializeJson=function(){  
        var serializeObj={};  
        var array=this.serializeArray();  
        var str=this.serialize();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    };  
})(jQuery);  


/**
 * easyui中的组件的ajax数据的通用处理方法
 */
$.ad = {
	/**
	 * 往下来框框中增加全部选项，要求 值字段名为id,文本字段名为text
	 */
	addAllOption : function(data){
		data.splice(0,0,{id:"",text:I18N.option_all});
		return data;
	},
	addChooseOption : function(data){
		data.splice(0,0,{id:"",text:I18N.option_choose});
		return data;
	},
	
	gridQuery:function(formId,gridId){
		var jsonData = $("#" + formId).serializeJson();
		
		$('#' + gridId).datagrid('load',{params:JSON.stringify(jsonData)});
		
	},
	
	submitForm:function(formId,gridId,wid,success){
		var succ;
		if(success && (typeof success == "function")){
			succ = success;
		}
		else{
			succ = function(data){
				var data = eval('(' + data + ')');
				$.sm.handleResult(data,function(data){
					$('#' + wid).window('close');
					$('#' + formId).form('clear');
					$('#' + gridId).datagrid('load'); 
				});
			};
		}
		$('#' + formId).form('submit',{success:succ});
	},
	
	clearForm: function (formId) {
		$('#' + formId).form('clear');
	},
	
	toAdd:function(wid,wTitle,formId,url){
		$('#' + formId).form('clear');
		if(url){
			$('#' + formId).form({url:url});
		}
		$("#" + wid).window({title:I18N.add + wTitle});
		$("#" + wid).window("open");
	},
	
	toUpdate:function(gridId,wid,wTitle,formId,url){
		var selRows = $("#" + gridId).datagrid("getSelections");
		if(selRows.length != 1){
			$.sm.alert(I18N.alert_select_one);
			return;
		}

		$('#' + formId).form('load',selRows[0]);
		
		if(url){
			$('#' + formId).form({url:url});
		}
		$("#" + wid).window({title:I18N.update + wTitle});
		$("#" + wid).window("open");
	},
	
	doDelete:function(gridId,url){
		var selRows = $("#" + gridId).datagrid("getChecked");
		if(selRows.length == 0){
			$.sm.alert(I18N.alert_select);
			return;
		}
		var ids = "";
		for(var i in selRows){
			ids += "&id=" + selRows[i].id;
		}
		
		$.post(url,ids,function(data){
			$.sm.handleResult(data,function(data){
				$("#" + gridId).datagrid("reload");
			});
		},'json');
	}
}

var ztreef = {
		clickToEdit:function (event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).editName(treeNode);
		},
		
		beforeRename:function (treeId, treeNode, newName, isCancel){
			var ztree = $.fn.zTree.getZTreeObj(treeId);
			if(newName.length == 0){
				ztree.cancelEditName();
				$.sm.alert(I18N.org_name_not_null);
				return false;
			}
			
			if(treeNode.name == newName){
				return true;
			}
			
			var res = false;
			
			$.ajax({ url: ztree.saveUrl,dataType:'json',data:{id:treeNode.id,name:newName,pid:treeNode.pid},async:false, 
				success: function(data){
					$.sm.handleResult(data);
					if(!treeNode.id){
						treeNode.id = data.data;
					}
					res = true;
			      }});
			
			return res;
		},
		
		beforeRemove:function (treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj(treeId);
			zTree.selectNode(treeNode);
			$.sm.confirmDelete(function(){
				var ids = [];
				ztreef.getAllChildrenIds(treeNode,ids);
				if(ids.length == 0){
					zTree.removeNode(treeNode);
					return;
				}
				
				$.ajax({ url: zTree.deleteUrl,dataType:'json',method:"post",data:{ids:ids},async:false, 
					success: function(data){
						$.sm.handleResult(data);
						zTree.removeNode(treeNode);
				      }});
			});
			return false;
		},
		
		getAllChildrenIds:function (node,ids){
			if(node.id){
				ids.push(node.id);
			}
			if(node.children && node.children.length>0){
				for(var i in node.children){
					this.getAllChildrenIds(node.children[i],ids);
				}
			}
		},
		
		addHoverDom:function (treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='" + I18N.add + "' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj(treeId);
				zTree.addNodes(treeNode, {pid:treeNode.id, name:I18N.ztree_node_new});
				return false;
			});
		},
		
		removeHoverDom:function orgRemoveHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		}
}


/**
 * easyui校验扩展
 */
$.extend($.fn.validatebox.defaults.rules, {
    equals: {
        validator: function(value,param){
            return value == $(param[0]).val();
        },
        message: I18N.validator_equals
    }
});
$.extend($.fn.validatebox.defaults.rules, {
    minLength: {
        validator: function(value, param){
            return value.length >= param[0];
        },
        message: I18N.validator_minLength
    }
});
$.extend($.fn.validatebox.defaults.rules, {
    maxLength: {
        validator: function(value, param){
            return value.length <= param[0];
        },
        message: I18N.validator_maxLength
    }
});
