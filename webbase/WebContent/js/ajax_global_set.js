/**
	jquery ajax 全局设置
	在此js中主要设置当用户session失效、鉴权不通过时的ajax请求的处理。
*/
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
		showAddOK : function(){
			$.messager.show({
                title:I18N_MESS.SHOW_TITLE,
                msg:I18N_MESS.OPER_ADD_OK,
                showType:'show'
            });
		},
		showUpdateOK : function(){
			$.messager.show({
                title:I18N_MESS.SHOW_TITLE,
                msg:I18N_MESS.OPER_UPDATE_OK,
                showType:'show'
            });
		},
		showDeleteOK : function(){
			$.messager.show({
                title:I18N_MESS.SHOW_TITLE,
                msg:I18N_MESS.OPER_DELETE_OK,
                showType:'show'
            });
		},
		showSysError:function(error){
			$.messager.show({
                title:I18N_MESS.ALERT_TITLE,
                msg:I18N_MESS.OPER_SYS_ERROR + (error ? ":" + error : ""),
                showType:'show'
            });
		},
		confirmDelete:function(fun){
			 $.messager.confirm(I18N_MESS.CONFIRM_TITLE, I18N_MESS.CONFIRM_DELETE_MESS, function(r){		 
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
					content = I18N_MESS.operate_ok[res.operate];
				}
				
				$.messager.show({
	                title:I18N_MESS.SHOW_TITLE,
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
				var content = I18N_MESS.operate_faild[res.operate];
				if(res.mess){
					content += mess;
				}
				else{
					content += OPER_SYS_ERROR;
				}
				
				$.messager.alert(content);
				
				if(faild){
					if(typeof faild == "function"){
						faild.apply(res.data);
					}
				}
			}
		}
		
}