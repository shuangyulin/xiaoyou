var shuoshuo_manage_tool = null; 
$(function () { 
	initShuoshuoManageTool(); //建立Shuoshuo管理对象
	shuoshuo_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#shuoshuo_manage").datagrid({
		url : 'Shuoshuo/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "shuoshuoId",
		sortOrder : "desc",
		toolbar : "#shuoshuo_manage_tool",
		columns : [[
			{
				field : "shuoshuoId",
				title : "说说id",
				width : 70,
			},
			{
				field : "shuoshuoContent",
				title : "说说内容",
				width : 140,
			},
			{
				field : "photo1",
				title : "图片1",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "photo2",
				title : "图片2",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "photo3",
				title : "图片3",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "userObj",
				title : "发布人",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
		]],
	});

	$("#shuoshuoEditDiv").dialog({
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
				if ($("#shuoshuoEditForm").form("validate")) {
					//验证表单 
					if(!$("#shuoshuoEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#shuoshuoEditForm").form({
						    url:"Shuoshuo/" + $("#shuoshuo_shuoshuoId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#shuoshuoEditDiv").dialog("close");
			                        shuoshuo_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#shuoshuoEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#shuoshuoEditDiv").dialog("close");
				$("#shuoshuoEditForm").form("reset"); 
			},
		}],
	});
});

function initShuoshuoManageTool() {
	shuoshuo_manage_tool = {
		init: function() {
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
			$("#shuoshuo_manage").datagrid("reload");
		},
		redo : function () {
			$("#shuoshuo_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#shuoshuo_manage").datagrid("options").queryParams;
			queryParams["shuoshuoContent"] = $("#shuoshuoContent").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#shuoshuo_manage").datagrid("options").queryParams=queryParams; 
			$("#shuoshuo_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#shuoshuoQueryForm").form({
			    url:"Shuoshuo/OutToExcel",
			});
			//提交表单
			$("#shuoshuoQueryForm").submit();
		},
		remove : function () {
			var rows = $("#shuoshuo_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var shuoshuoIds = [];
						for (var i = 0; i < rows.length; i ++) {
							shuoshuoIds.push(rows[i].shuoshuoId);
						}
						$.ajax({
							type : "POST",
							url : "Shuoshuo/deletes",
							data : {
								shuoshuoIds : shuoshuoIds.join(","),
							},
							beforeSend : function () {
								$("#shuoshuo_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#shuoshuo_manage").datagrid("loaded");
									$("#shuoshuo_manage").datagrid("load");
									$("#shuoshuo_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#shuoshuo_manage").datagrid("loaded");
									$("#shuoshuo_manage").datagrid("load");
									$("#shuoshuo_manage").datagrid("unselectAll");
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
			var rows = $("#shuoshuo_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Shuoshuo/" + rows[0].shuoshuoId +  "/update",
					type : "get",
					data : {
						//shuoshuoId : rows[0].shuoshuoId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (shuoshuo, response, status) {
						$.messager.progress("close");
						if (shuoshuo) { 
							$("#shuoshuoEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
