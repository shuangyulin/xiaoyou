<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/postInfo.css" />
<div id="postInfoAddDiv">
	<form id="postInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">文章标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_title" name="postInfo.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">文章图片:</span>
			<span class="inputControl">
				<input id="postPhotoFile" name="postPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">文章内容:</span>
			<span class="inputControl">
				<script name="postInfo.content" id="postInfo_content" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">浏览量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_hitNum" name="postInfo.hitNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">发布人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_userObj_user_name" name="postInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="postInfo_addTime" name="postInfo.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="postInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="postInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/PostInfo/js/postInfo_add.js"></script> 
