<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zanInfo.css" /> 

<div id="zanInfo_manage"></div>
<div id="zanInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="zanInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="zanInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="zanInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="zanInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="zanInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="zanInfoQueryForm" method="post">
			被点赞文章：<input class="textbox" type="text" id="postObj_postInfoId_query" name="postObj.postInfoId" style="width: auto"/>
			点赞人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			点赞时间：<input type="text" id="zanTime" name="zanTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="zanInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="zanInfoEditDiv">
	<form id="zanInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">点赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_zanId_edit" name="zanInfo.zanId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被点赞文章:</span>
			<span class="inputControl">
				<input class="textbox"  id="zanInfo_postObj_postInfoId_edit" name="zanInfo.postObj.postInfoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞人:</span>
			<span class="inputControl">
				<input class="textbox"  id="zanInfo_userObj_user_name_edit" name="zanInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_zanTime_edit" name="zanInfo.zanTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ZanInfo/js/zanInfo_manage.js"></script> 
