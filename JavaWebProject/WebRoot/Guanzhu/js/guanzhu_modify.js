$(function () {
	$.ajax({
		url : "Guanzhu/" + $("#guanzhu_guanzhuId_edit").val() + "/update",
		type : "get",
		data : {
			//guanzhuId : $("#guanzhu_guanzhuId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (guanzhu, response, status) {
			$.messager.progress("close");
			if (guanzhu) { 
				$("#guanzhu_guanzhuId_edit").val(guanzhu.guanzhuId);
				$("#guanzhu_guanzhuId_edit").validatebox({
					required : true,
					missingMessage : "请输入关注id",
					editable: false
				});
				$("#guanzhu_userObj1_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#guanzhu_userObj1_user_name_edit").combobox("select", guanzhu.userObj1Pri);
						//var data = $("#guanzhu_userObj1_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#guanzhu_userObj1_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#guanzhu_userObj2_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#guanzhu_userObj2_user_name_edit").combobox("select", guanzhu.userObj2Pri);
						//var data = $("#guanzhu_userObj2_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#guanzhu_userObj2_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#guanzhu_guanzhuTime_edit").datetimebox({
					value: guanzhu.guanzhuTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#guanzhuModifyButton").click(function(){ 
		if ($("#guanzhuEditForm").form("validate")) {
			$("#guanzhuEditForm").form({
			    url:"Guanzhu/" +  $("#guanzhu_guanzhuId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#guanzhuEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#guanzhuEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
