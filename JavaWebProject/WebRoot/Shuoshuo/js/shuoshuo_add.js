$(function () {
	$("#shuoshuo_shuoshuoContent").validatebox({
		required : true, 
		missingMessage : '请输入说说内容',
	});

	$("#shuoshuo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#shuoshuo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#shuoshuo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#shuoshuo_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#shuoshuoAddButton").click(function () {
		//验证表单 
		if(!$("#shuoshuoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#shuoshuoAddForm").form({
			    url:"Shuoshuo/add",
			    onSubmit: function(){
					if($("#shuoshuoAddForm").form("validate"))  { 
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
                        $("#shuoshuoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#shuoshuoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#shuoshuoClearButton").click(function () { 
		$("#shuoshuoAddForm").form("clear"); 
	});
});
