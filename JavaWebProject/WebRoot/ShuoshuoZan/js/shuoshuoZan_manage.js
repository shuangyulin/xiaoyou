var shuoshuoZan_manage_tool = null; 
$(function () { 
	initShuoshuoZanManageTool(); //建立ShuoshuoZan管理对象
	shuoshuoZan_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#shuoshuoZan_manage").datagrid({
		url : 'ShuoshuoZan/list',
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
		toolbar : "#shuoshuoZan_manage_tool",
		columns : [[
			{
				field : "zanId",
				title : "点赞id",
				width : 70,
			},
			{
				field : "shuoshuoObj",
				title : "被点赞说说",
				width : 140,
			},
			{
				field : "userObj",
				title : "点赞用户",
				width : 140,
			},
			{
				field : "zanTime",
				title : "点赞时间",
				width : 140,
			},
		]],
	});

	$("#shuoshuoZanEditDiv").dialog({
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
				if ($("#shuoshuoZanEditForm").form("validate")) {
					//验证表单 
					if(!$("#shuoshuoZanEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#shuoshuoZanEditForm").form({
						    url:"ShuoshuoZan/" + $("#shuoshuoZan_zanId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#shuoshuoZanEditDiv").dialog("close");
			                        shuoshuoZan_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#shuoshuoZanEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#shuoshuoZanEditDiv").dialog("close");
				$("#shuoshuoZanEditForm").form("reset"); 
			},
		}],
	});
});

function initShuoshuoZanManageTool() {
	shuoshuoZan_manage_tool = {
		init: function() {
			$.ajax({
				url : "Shuoshuo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#shuoshuoObj_shuoshuoId_query").combobox({ 
					    valueField:"shuoshuoId",
					    textField:"shuoshuoContent",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{shuoshuoId:0,shuoshuoContent:"不限制"});
					$("#shuoshuoObj_shuoshuoId_query").combobox("loadData",data); 
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
			$("#shuoshuoZan_manage").datagrid("reload");
		},
		redo : function () {
			$("#shuoshuoZan_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#shuoshuoZan_manage").datagrid("options").queryParams;
			queryParams["shuoshuoObj.shuoshuoId"] = $("#shuoshuoObj_shuoshuoId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["zanTime"] = $("#zanTime").datebox("getValue"); 
			$("#shuoshuoZan_manage").datagrid("options").queryParams=queryParams; 
			$("#shuoshuoZan_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#shuoshuoZanQueryForm").form({
			    url:"ShuoshuoZan/OutToExcel",
			});
			//提交表单
			$("#shuoshuoZanQueryForm").submit();
		},
		remove : function () {
			var rows = $("#shuoshuoZan_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var zanIds = [];
						for (var i = 0; i < rows.length; i ++) {
							zanIds.push(rows[i].zanId);
						}
						$.ajax({
							type : "POST",
							url : "ShuoshuoZan/deletes",
							data : {
								zanIds : zanIds.join(","),
							},
							beforeSend : function () {
								$("#shuoshuoZan_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#shuoshuoZan_manage").datagrid("loaded");
									$("#shuoshuoZan_manage").datagrid("load");
									$("#shuoshuoZan_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#shuoshuoZan_manage").datagrid("loaded");
									$("#shuoshuoZan_manage").datagrid("load");
									$("#shuoshuoZan_manage").datagrid("unselectAll");
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
			var rows = $("#shuoshuoZan_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "ShuoshuoZan/" + rows[0].zanId +  "/update",
					type : "get",
					data : {
						//zanId : rows[0].zanId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (shuoshuoZan, response, status) {
						$.messager.progress("close");
						if (shuoshuoZan) { 
							$("#shuoshuoZanEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
