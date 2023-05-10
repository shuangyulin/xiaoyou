var zanInfo_manage_tool = null; 
$(function () { 
	initZanInfoManageTool(); //建立ZanInfo管理对象
	zanInfo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#zanInfo_manage").datagrid({
		url : 'ZanInfo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "zanId",
		sortOrder : "desc",
		toolbar : "#zanInfo_manage_tool",
		columns : [[
			{
				field : "zanId",
				title : "点赞id",
				width : 70,
			},
			{
				field : "postObj",
				title : "被点赞文章",
				width : 140,
			},
			{
				field : "userObj",
				title : "点赞人",
				width : 140,
			},
			{
				field : "zanTime",
				title : "点赞时间",
				width : 140,
			},
		]],
	});

	$("#zanInfoEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#zanInfoEditForm").form("validate")) {
					//验证表单 
					if(!$("#zanInfoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#zanInfoEditForm").form({
						    url:"ZanInfo/" + $("#zanInfo_zanId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#zanInfoEditDiv").dialog("close");
			                        zanInfo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#zanInfoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#zanInfoEditDiv").dialog("close");
				$("#zanInfoEditForm").form("reset"); 
			},
		}],
	});
});

function initZanInfoManageTool() {
	zanInfo_manage_tool = {
		init: function() {
			$.ajax({
				url : "PostInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#postObj_postInfoId_query").combobox({ 
					    valueField:"postInfoId",
					    textField:"title",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{postInfoId:0,title:"不限制"});
					$("#postObj_postInfoId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#zanInfo_manage").datagrid("reload");
		},
		redo : function () {
			$("#zanInfo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#zanInfo_manage").datagrid("options").queryParams;
			queryParams["postObj.postInfoId"] = $("#postObj_postInfoId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["zanTime"] = $("#zanTime").datebox("getValue"); 
			$("#zanInfo_manage").datagrid("options").queryParams=queryParams; 
			$("#zanInfo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#zanInfoQueryForm").form({
			    url:"ZanInfo/OutToExcel",
			});
			//提交表单
			$("#zanInfoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#zanInfo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var zanIds = [];
						for (var i = 0; i < rows.length; i ++) {
							zanIds.push(rows[i].zanId);
						}
						$.ajax({
							type : "POST",
							url : "ZanInfo/deletes",
							data : {
								zanIds : zanIds.join(","),
							},
							beforeSend : function () {
								$("#zanInfo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#zanInfo_manage").datagrid("loaded");
									$("#zanInfo_manage").datagrid("load");
									$("#zanInfo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#zanInfo_manage").datagrid("loaded");
									$("#zanInfo_manage").datagrid("load");
									$("#zanInfo_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#zanInfo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ZanInfo/" + rows[0].zanId +  "/update",
					type : "get",
					data : {
						//zanId : rows[0].zanId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (zanInfo, response, status) {
						$.messager.progress("close");
						if (zanInfo) { 
							$("#zanInfoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
