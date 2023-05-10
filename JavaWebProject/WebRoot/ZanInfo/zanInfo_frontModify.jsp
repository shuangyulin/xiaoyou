<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ZanInfo" %>
<%@ page import="com.chengxusheji.po.PostInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的postObj信息
    List<PostInfo> postInfoList = (List<PostInfo>)request.getAttribute("postInfoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    ZanInfo zanInfo = (ZanInfo)request.getAttribute("zanInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改文章点赞信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">文章点赞信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="zanInfoEditForm" id="zanInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="zanInfo_zanId_edit" class="col-md-3 text-right">点赞id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="zanInfo_zanId_edit" name="zanInfo.zanId" class="form-control" placeholder="请输入点赞id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="zanInfo_postObj_postInfoId_edit" class="col-md-3 text-right">被点赞文章:</label>
		  	 <div class="col-md-9">
			    <select id="zanInfo_postObj_postInfoId_edit" name="zanInfo.postObj.postInfoId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zanInfo_userObj_user_name_edit" class="col-md-3 text-right">点赞人:</label>
		  	 <div class="col-md-9">
			    <select id="zanInfo_userObj_user_name_edit" name="zanInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="zanInfo_zanTime_edit" class="col-md-3 text-right">点赞时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date zanInfo_zanTime_edit col-md-12" data-link-field="zanInfo_zanTime_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="zanInfo_zanTime_edit" name="zanInfo.zanTime" size="16" type="text" value="" placeholder="请选择点赞时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxZanInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#zanInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改文章点赞界面并初始化数据*/
function zanInfoEdit(zanId) {
	$.ajax({
		url :  basePath + "ZanInfo/" + zanId + "/update",
		type : "get",
		dataType: "json",
		success : function (zanInfo, response, status) {
			if (zanInfo) {
				$("#zanInfo_zanId_edit").val(zanInfo.zanId);
				$.ajax({
					url: basePath + "PostInfo/listAll",
					type: "get",
					success: function(postInfos,response,status) { 
						$("#zanInfo_postObj_postInfoId_edit").empty();
						var html="";
		        		$(postInfos).each(function(i,postInfo){
		        			html += "<option value='" + postInfo.postInfoId + "'>" + postInfo.title + "</option>";
		        		});
		        		$("#zanInfo_postObj_postInfoId_edit").html(html);
		        		$("#zanInfo_postObj_postInfoId_edit").val(zanInfo.postObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#zanInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#zanInfo_userObj_user_name_edit").html(html);
		        		$("#zanInfo_userObj_user_name_edit").val(zanInfo.userObjPri);
					}
				});
				$("#zanInfo_zanTime_edit").val(zanInfo.zanTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交文章点赞信息表单给服务器端修改*/
function ajaxZanInfoModify() {
	$.ajax({
		url :  basePath + "ZanInfo/" + $("#zanInfo_zanId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#zanInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#zanInfoQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*点赞时间组件*/
    $('.zanInfo_zanTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    zanInfoEdit("<%=request.getParameter("zanId")%>");
 })
 </script> 
</body>
</html>

