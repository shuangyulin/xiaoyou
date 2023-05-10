<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuoZan.css" /> 

<div id="shuoshuoZan_manage"></div>
<div id="shuoshuoZan_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="shuoshuoZan_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="shuoshuoZan_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="shuoshuoZan_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="shuoshuoZan_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="shuoshuoZan_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="shuoshuoZanQueryForm" method="post">
			被点赞说说：<input class="textbox" type="text" id="shuoshuoObj_shuoshuoId_query" name="shuoshuoObj.shuoshuoId" style="width: auto"/>
			点赞用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			点赞时间：<input type="text" id="zanTime" name="zanTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="shuoshuoZan_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="shuoshuoZanEditDiv">
	<form id="shuoshuoZanEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">点赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_zanId_edit" name="shuoshuoZan.zanId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被点赞说说:</span>
			<span class="inputControl">
				<input class="textbox"  id="shuoshuoZan_shuoshuoObj_shuoshuoId_edit" name="shuoshuoZan.shuoshuoObj.shuoshuoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="shuoshuoZan_userObj_user_name_edit" name="shuoshuoZan.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_zanTime_edit" name="shuoshuoZan.zanTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ShuoshuoZan/js/shuoshuoZan_manage.js"></script> 
