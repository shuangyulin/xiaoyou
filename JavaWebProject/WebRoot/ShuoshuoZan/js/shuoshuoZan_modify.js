$(function () {
	$.ajax({
		url : "ShuoshuoZan/" + $("#shuoshuoZan_zanId_edit").val() + "/update",
		type : "get",
		data : {
			//zanId : $("#shuoshuoZan_zanId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (shuoshuoZan, response, status) {
			$.messager.progress("close");
			if (shuoshuoZan) { 
				$("#shuoshuoZan_zanId_edit").val(shuoshuoZan.zanId);
				$("#shuoshuoZan_zanId_edit").validatebox({
					required : true,
					missingMessage : "请输入点赞id",
					editable: false
				});
				$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").combobox({
					url:"Shuoshuo/listAll",
					valueField:"shuoshuoId",
					textField:"shuoshuoContent",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").combobox("select", shuoshuoZan.shuoshuoObjPri);
						//var data = $("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").combobox("select", data[0].shuoshuoId);
						//}
					}
				});
				$("#shuoshuoZan_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#shuoshuoZan_userObj_user_name_edit").combobox("select", shuoshuoZan.userObjPri);
						//var data = $("#shuoshuoZan_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#shuoshuoZan_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#shuoshuoZan_zanTime_edit").datetimebox({
					value: shuoshuoZan.zanTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#shuoshuoZanModifyButton").click(function(){ 
		if ($("#shuoshuoZanEditForm").form("validate")) {
			$("#shuoshuoZanEditForm").form({
			    url:"ShuoshuoZan/" +  $("#shuoshuoZan_zanId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#shuoshuoZanEditForm").form("validate"))  {
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
			$("#shuoshuoZanEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
