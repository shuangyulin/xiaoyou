$(function () {
	$("#shuoshuoZan_shuoshuoObj_shuoshuoId").combobox({
	    url:'Shuoshuo/listAll',
	    valueField: "shuoshuoId",
	    textField: "shuoshuoContent",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#shuoshuoZan_shuoshuoObj_shuoshuoId").combobox("getData"); 
            if (data.length > 0) {
                $("#shuoshuoZan_shuoshuoObj_shuoshuoId").combobox("select", data[0].shuoshuoId);
            }
        }
	});
	$("#shuoshuoZan_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#shuoshuoZan_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#shuoshuoZan_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#shuoshuoZan_zanTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#shuoshuoZanAddButton").click(function () {
		//验证表单 
		if(!$("#shuoshuoZanAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#shuoshuoZanAddForm").form({
			    url:"ShuoshuoZan/add",
			    onSubmit: function(){
					if($("#shuoshuoZanAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#shuoshuoZanAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#shuoshuoZanAddForm").submit();
		}
	});

	//单击清空按钮
	$("#shuoshuoZanClearButton").click(function () { 
		$("#shuoshuoZanAddForm").form("clear"); 
	});
});
