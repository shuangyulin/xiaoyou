$(function () {
	$.ajax({
		url : "ZanInfo/" + $("#zanInfo_zanId_edit").val() + "/update",
		type : "get",
		data : {
			//zanId : $("#zanInfo_zanId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (zanInfo, response, status) {
			$.messager.progress("close");
			if (zanInfo) { 
				$("#zanInfo_zanId_edit").val(zanInfo.zanId);
				$("#zanInfo_zanId_edit").validatebox({
					required : true,
					missingMessage : "请输入点赞id",
					editable: false
				});
				$("#zanInfo_postObj_postInfoId_edit").combobox({
					url:"PostInfo/listAll",
					valueField:"postInfoId",
					textField:"title",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#zanInfo_postObj_postInfoId_edit").combobox("select", zanInfo.postObjPri);
						//var data = $("#zanInfo_postObj_postInfoId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#zanInfo_postObj_postInfoId_edit").combobox("select", data[0].postInfoId);
						//}
					}
				});
				$("#zanInfo_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#zanInfo_userObj_user_name_edit").combobox("select", zanInfo.userObjPri);
						//var data = $("#zanInfo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#zanInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#zanInfo_zanTime_edit").datebox({
					value: zanInfo.zanTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#zanInfoModifyButton").click(function(){ 
		if ($("#zanInfoEditForm").form("validate")) {
			$("#zanInfoEditForm").form({
			    url:"ZanInfo/" +  $("#zanInfo_zanId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#zanInfoEditForm").form("validate"))  {
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
			$("#zanInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
