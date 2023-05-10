<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/shuoshuo.css" />
<div id="shuoshuo_editDiv">
	<form id="shuoshuoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">说说id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="shuoshuo_shuoshuoId_edit" name="shuoshuo.shuoshuoId" value="<%=request.getParameter("shuoshuoId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="shuoshuoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Shuoshuo/js/shuoshuo_modify.js"></script> 
