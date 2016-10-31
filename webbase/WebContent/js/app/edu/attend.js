
var attend = {
	attend_w_load:false,
	perType_stu : '1',
	toReg:function(wTitle){
		$.ad.toAdd('attend_w',wTitle,'attend_add',ctx + '/attend/add')
		$('#attend_add_per').combobox({multiple:true});
		var da = $("#attend_personId").combobox('getData');
		$('#attend_add_per').combobox('loadData',da);
		$('#attend_personType').val(1);
		$('#attendStatus').val(1);
		$('#attend_startTime').datetimebox('setValue',todayWorkStartTime);
		$('#attend_endTime').datetimebox('setValue',todayWorkStartTime);
	},
	toUpdate:function(wTitle){
		var da = $("#attend_personId").combobox('getData');
		$('#attend_add_per').combobox({multiple:false});
		$('#attend_add_per').combobox('loadData',da);
		$.ad.toUpdate('attend_grid','attend_w',wTitle,'attend_add',ctx + '/attend/update');
	},
	nameFormatter : function(value,row){
		if(row.personType == attend.perType_stu){
			return row.stuName;
		}else{
			return row.teaName;
		}
	},
	typeFormatter : function(value,row){
		return $.ad.getDictName('attend.type',value);
	},
	statusFormatter : function(value,row){
		return $.ad.getDictName('attend.status',value);
	},
	detailFormatter:function(index,row){
        return '<div class="ddv" style="padding:5px 10px 5px 0px;height:60px"></div>';
    },
    onExpandRow: function(index,row){
        var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
        
        if(row.addDetail){
        
        }else{
        	var des = '<table class="dv-table" border="0">' +
			'<tr>' +
				'<th>' + I18N.attend_reason + '</th>' +
				'<td>' + $.ad.nvl(row.reason) + '</td>' +
			'</tr>' +
			'<tr>' +
				'<th>' + I18N.attend_remark + '</th>' +
				'<td>' + $.ad.nvl(row.remark) + '</td>' +
			'</tr>' +
		'</table>';

        	ddv.append(des);
        	row.addDetail = true;
        }
    },
    
    leave:{
    	apply:function(wTitle){
    		$("#attend_add").form({url:ctx + 'attend/add'});
    		$("#attend_add").form("clear");
    		$("#attend_add").form("load",addData);
    		var wid = "attend_w";
    		$("#" + wid).window({title:wTitle});
    		$("#" + wid).window("open");
    	},
    	onCheck:function(index,row){
			if(row.status != "0"){
				$("#attend_grid").datagrid("uncheckRow",index);
				$.sm.show(I18N.attend_leave_cannot_change);
			}
		}
    }
    
};