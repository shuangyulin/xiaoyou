<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/guanzhu.css" />
<div id="guanzhu_editDiv">
	<form id="guanzhuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">关注id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="guanzhu_guanzhuId_edit" name="guanzhu.guanzhuId" value="<%=request.getParameter("guanzhuId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="guanzhuModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Guanzhu/js/guanzhu_modify.js"></script> 
