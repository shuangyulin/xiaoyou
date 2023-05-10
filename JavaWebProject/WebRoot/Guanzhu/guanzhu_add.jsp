<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/guanzhu.css" />
<div id="guanzhuAddDiv">
	<form id="guanzhuAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被关注人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_userObj1_user_name" name="guanzhu.userObj1.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_userObj2_user_name" name="guanzhu.userObj2.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">关注时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_guanzhuTime" name="guanzhu.guanzhuTime" />

			</span>

		</div>
		<div class="operation">
			<a id="guanzhuAddButton" class="easyui-linkbutton">添加</a>
			<a id="guanzhuClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Guanzhu/js/guanzhu_add.js"></script> 
