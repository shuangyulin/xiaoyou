$(function () {
	$("#zanInfo_postObj_postInfoId").combobox({
	    url:'PostInfo/listAll',
	    valueField: "postInfoId",
	    textField: "title",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#zanInfo_postObj_postInfoId").combobox("getData"); 
            if (data.length > 0) {
                $("#zanInfo_postObj_postInfoId").combobox("select", data[0].postInfoId);
            }
        }
	});
	$("#zanInfo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#zanInfo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#zanInfo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#zanInfo_zanTime").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#zanInfoAddButton").click(function () {
		//验证表单 
		if(!$("#zanInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#zanInfoAddForm").form({
			    url:"ZanInfo/add",
			    onSubmit: function(){
					if($("#zanInfoAddForm").form("validate"))  { 
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
                        $("#zanInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#zanInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#zanInfoClearButton").click(function () { 
		$("#zanInfoAddForm").form("clear"); 
	});
});
