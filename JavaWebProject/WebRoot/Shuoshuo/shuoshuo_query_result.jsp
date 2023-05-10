<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuo.css" /> 

<div id="shuoshuo_manage"></div>
<div id="shuoshuo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="shuoshuo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="shuoshuo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="shuoshuo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="shuoshuo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="shuoshuo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="shuoshuoQueryForm" method="post">
			说说内容：<input type="text" class="textbox" id="shuoshuoContent" name="shuoshuoContent" style="width:110px" />
			发布人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			发布时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="shuoshuo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="shuoshuoEditDiv">
	<form id="shuoshuoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">说说id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuo_shuoshuoId_edit" name="shuoshuo.shuoshuoId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">说说内容:</span>
			<span class="inputControl">
				<textarea id="shuoshuo_shuoshuoContent_edit" name="shuoshuo.shuoshuoContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">图片1:</span>
			<span class="inputControl">
				<img id="shuoshuo_photo1Img" width="200px" border="0px"/><br/>
    			<input type="hidden" id="shuoshuo_photo1" name="shuoshuo.photo1"/>
				<input id="photo1File" name="photo1File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图片2:</span>
			<span class="inputControl">
				<img id="shuoshuo_photo2Img" width="200px" border="0px"/><br/>
    			<input type="hidden" id="shuoshuo_photo2" name="shuoshuo.photo2"/>
				<input id="photo2File" name="photo2File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图片3:</span>
			<span class="inputControl">
				<img id="shuoshuo_photo3Img" width="200px" border="0px"/><br/>
    			<input type="hidden" id="shuoshuo_photo3" name="shuoshuo.photo3"/>
				<input id="photo3File" name="photo3File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">发布人:</span>
			<span class="inputControl">
				<input class="textbox"  id="shuoshuo_userObj_user_name_edit" name="shuoshuo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuo_addTime_edit" name="shuoshuo.addTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Shuoshuo/js/shuoshuo_manage.js"></script> 
