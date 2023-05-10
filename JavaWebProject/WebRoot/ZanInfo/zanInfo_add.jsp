<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zanInfo.css" />
<div id="zanInfoAddDiv">
	<form id="zanInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被点赞文章:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_postObj_postInfoId" name="zanInfo.postObj.postInfoId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_userObj_user_name" name="zanInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">点赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_zanTime" name="zanInfo.zanTime" />

			</span>

		</div>
		<div class="operation">
			<a id="zanInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="zanInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ZanInfo/js/zanInfo_add.js"></script> 
