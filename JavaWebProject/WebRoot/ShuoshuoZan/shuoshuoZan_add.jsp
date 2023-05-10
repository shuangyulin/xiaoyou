<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuoZan.css" />
<div id="shuoshuoZanAddDiv">
	<form id="shuoshuoZanAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被点赞说说:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_shuoshuoObj_shuoshuoId" name="shuoshuoZan.shuoshuoObj.shuoshuoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_userObj_user_name" name="shuoshuoZan.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuoZan_zanTime" name="shuoshuoZan.zanTime" />

			</span>

		</div>
		<div class="operation">
			<a id="shuoshuoZanAddButton" class="easyui-linkbutton">添加</a>
			<a id="shuoshuoZanClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ShuoshuoZan/js/shuoshuoZan_add.js"></script> 
