$(function () {
	$.ajax({
		url : "Shuoshuo/" + $("#shuoshuo_shuoshuoId_edit").val() + "/update",
		type : "get",
		data : {
			//shuoshuoId : $("#shuoshuo_shuoshuoId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (shuoshuo, response, status) {
			$.messager.progress("close");
			if (shuoshuo) { 
				$("#shuoshuo_shuoshuoId_edit").val(shuoshuo.shuoshuoId);
				$("#shuoshuo_shuoshuoId_edit").validatebox({
					required : true,
					missingMessage : "请输入说说id",
					editable: false
				});
				$("#shuoshuo_shuoshuoContent_edit").val(shuoshuo.shuoshuoContent);
				$("#shuoshuo_shuoshuoContent_edit").validatebox({
					required : true,
					missingMessage : "请输入说说内容",
				});
				$("#shuoshuo_photo1").val(shuoshuo.photo1);
				$("#shuoshuo_photo1Img").attr("src", shuoshuo.photo1);
				$("#shuoshuo_photo2").val(shuoshuo.photo2);
				$("#shuoshuo_photo2Img").attr("src", shuoshuo.photo2);
				$("#shuoshuo_photo3").val(shuoshuo.photo3);
				$("#shuoshuo_photo3Img").attr("src", shuoshuo.photo3);
				$("#shuoshuo_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#shuoshuo_userObj_user_name_edit").combobox("select", shuoshuo.userObjPri);
						//var data = $("#shuoshuo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#shuoshuo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#shuoshuo_addTime_edit").datetimebox({
					value: shuoshuo.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#shuoshuoModifyButton").click(function(){ 
		if ($("#shuoshuoEditForm").form("validate")) {
			$("#shuoshuoEditForm").form({
			    url:"Shuoshuo/" +  $("#shuoshuo_shuoshuoId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#shuoshuoEditForm").form("validate"))  {
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
			$("#shuoshuoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
