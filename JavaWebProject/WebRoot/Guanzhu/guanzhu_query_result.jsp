<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/guanzhu.css" /> 

<div id="guanzhu_manage"></div>
<div id="guanzhu_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="guanzhu_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="guanzhu_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="guanzhu_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="guanzhu_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="guanzhu_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="guanzhuQueryForm" method="post">
			被关注人：<input class="textbox" type="text" id="userObj1_user_name_query" name="userObj1.user_name" style="width: auto"/>
			关注人：<input class="textbox" type="text" id="userObj2_user_name_query" name="userObj2.user_name" style="width: auto"/>
			关注时间：<input type="text" id="guanzhuTime" name="guanzhuTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="guanzhu_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="guanzhuEditDiv">
	<form id="guanzhuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">关注id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_guanzhuId_edit" name="guanzhu.guanzhuId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">被关注人:</span>
			<span class="inputControl">
				<input class="textbox"  id="guanzhu_userObj1_user_name_edit" name="guanzhu.userObj1.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注人:</span>
			<span class="inputControl">
				<input class="textbox"  id="guanzhu_userObj2_user_name_edit" name="guanzhu.userObj2.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_guanzhuTime_edit" name="guanzhu.guanzhuTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Guanzhu/js/guanzhu_manage.js"></script> 
