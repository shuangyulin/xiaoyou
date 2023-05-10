var guanzhu_manage_tool = null; 
$(function () { 
	initGuanzhuManageTool(); //建立Guanzhu管理对象
	guanzhu_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#guanzhu_manage").datagrid({
		url : 'Guanzhu/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "guanzhuId",
		sortOrder : "desc",
		toolbar : "#guanzhu_manage_tool",
		columns : [[
			{
				field : "guanzhuId",
				title : "关注id",
				width : 70,
			},
			{
				field : "userObj1",
				title : "被关注人",
				width : 140,
			},
			{
				field : "userObj2",
				title : "关注人",
				width : 140,
			},
			{
				field : "guanzhuTime",
				title : "关注时间",
				width : 140,
			},
		]],
	});

	$("#guanzhuEditDiv").dialog({
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
				if ($("#guanzhuEditForm").form("validate")) {
					//验证表单 
					if(!$("#guanzhuEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#guanzhuEditForm").form({
						    url:"Guanzhu/" + $("#guanzhu_guanzhuId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#guanzhuEditDiv").dialog("close");
			                        guanzhu_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#guanzhuEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#guanzhuEditDiv").dialog("close");
				$("#guanzhuEditForm").form("reset"); 
			},
		}],
	});
});

function initGuanzhuManageTool() {
	guanzhu_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj1_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj1_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj2_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj2_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#guanzhu_manage").datagrid("reload");
		},
		redo : function () {
			$("#guanzhu_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#guanzhu_manage").datagrid("options").queryParams;
			queryParams["userObj1.user_name"] = $("#userObj1_user_name_query").combobox("getValue");
			queryParams["userObj2.user_name"] = $("#userObj2_user_name_query").combobox("getValue");
			queryParams["guanzhuTime"] = $("#guanzhuTime").datebox("getValue"); 
			$("#guanzhu_manage").datagrid("options").queryParams=queryParams; 
			$("#guanzhu_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#guanzhuQueryForm").form({
			    url:"Guanzhu/OutToExcel",
			});
			//提交表单
			$("#guanzhuQueryForm").submit();
		},
		remove : function () {
			var rows = $("#guanzhu_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var guanzhuIds = [];
						for (var i = 0; i < rows.length; i ++) {
							guanzhuIds.push(rows[i].guanzhuId);
						}
						$.ajax({
							type : "POST",
							url : "Guanzhu/deletes",
							data : {
								guanzhuIds : guanzhuIds.join(","),
							},
							beforeSend : function () {
								$("#guanzhu_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#guanzhu_manage").datagrid("loaded");
									$("#guanzhu_manage").datagrid("load");
									$("#guanzhu_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#guanzhu_manage").datagrid("loaded");
									$("#guanzhu_manage").datagrid("load");
									$("#guanzhu_manage").datagrid("unselectAll");
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
			var rows = $("#guanzhu_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Guanzhu/" + rows[0].guanzhuId +  "/update",
					type : "get",
					data : {
						//guanzhuId : rows[0].guanzhuId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (guanzhu, response, status) {
						$.messager.progress("close");
						if (guanzhu) { 
							$("#guanzhuEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
