<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zanInfo.css" />
<div id="zanInfo_editDiv">
	<form id="zanInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">点赞id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zanInfo_zanId_edit" name="zanInfo.zanId" value="<%=request.getParameter("zanId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="zanInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ZanInfo/js/zanInfo_modify.js"></script> 
