<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuo.css" />
<div id="shuoshuoAddDiv">
	<form id="shuoshuoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">说说内容:</span>
			<span class="inputControl">
				<textarea id="shuoshuo_shuoshuoContent" name="shuoshuo.shuoshuoContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">图片1:</span>
			<span class="inputControl">
				<input id="photo1File" name="photo1File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图片2:</span>
			<span class="inputControl">
				<input id="photo2File" name="photo2File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图片3:</span>
			<span class="inputControl">
				<input id="photo3File" name="photo3File" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">发布人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuo_userObj_user_name" name="shuoshuo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuo_addTime" name="shuoshuo.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="shuoshuoAddButton" class="easyui-linkbutton">添加</a>
			<a id="shuoshuoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Shuoshuo/js/shuoshuo_add.js"></script> 
