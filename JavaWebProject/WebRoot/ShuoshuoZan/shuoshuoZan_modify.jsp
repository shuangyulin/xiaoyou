<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuoZan.css" />
<div id="shuoshuoZan_editDiv">
	<form id="shuoshuoZanEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">点赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_zanId_edit" name="shuoshuoZan.zanId" value="<%=request.getParameter("zanId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="shuoshuoZanModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ShuoshuoZan/js/shuoshuoZan_modify.js"></script> 
