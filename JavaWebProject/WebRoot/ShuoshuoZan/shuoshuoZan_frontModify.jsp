<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ShuoshuoZan" %>
<%@ page import="com.chengxusheji.po.Shuoshuo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的shuoshuoObj信息
    List<Shuoshuo> shuoshuoList = (List<Shuoshuo>)request.getAttribute("shuoshuoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    ShuoshuoZan shuoshuoZan = (ShuoshuoZan)request.getAttribute("shuoshuoZan");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改说说点赞信息</TITLE>
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
  		<li class="active">说说点赞信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="shuoshuoZanEditForm" id="shuoshuoZanEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="shuoshuoZan_zanId_edit" class="col-md-3 text-right">点赞id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="shuoshuoZan_zanId_edit" name="shuoshuoZan.zanId" class="form-control" placeholder="请输入点赞id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="shuoshuoZan_shuoshuoObj_shuoshuoId_edit" class="col-md-3 text-right">被点赞说说:</label>
		  	 <div class="col-md-9">
			    <select id="shuoshuoZan_shuoshuoObj_shuoshuoId_edit" name="shuoshuoZan.shuoshuoObj.shuoshuoId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuoZan_userObj_user_name_edit" class="col-md-3 text-right">点赞用户:</label>
		  	 <div class="col-md-9">
			    <select id="shuoshuoZan_userObj_user_name_edit" name="shuoshuoZan.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuoZan_zanTime_edit" class="col-md-3 text-right">点赞时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date shuoshuoZan_zanTime_edit col-md-12" data-link-field="shuoshuoZan_zanTime_edit">
                    <input class="form-control" id="shuoshuoZan_zanTime_edit" name="shuoshuoZan.zanTime" size="16" type="text" value="" placeholder="请选择点赞时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxShuoshuoZanModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#shuoshuoZanEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改说说点赞界面并初始化数据*/
function shuoshuoZanEdit(zanId) {
	$.ajax({
		url :  basePath + "ShuoshuoZan/" + zanId + "/update",
		type : "get",
		dataType: "json",
		success : function (shuoshuoZan, response, status) {
			if (shuoshuoZan) {
				$("#shuoshuoZan_zanId_edit").val(shuoshuoZan.zanId);
				$.ajax({
					url: basePath + "Shuoshuo/listAll",
					type: "get",
					success: function(shuoshuos,response,status) { 
						$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").empty();
						var html="";
		        		$(shuoshuos).each(function(i,shuoshuo){
		        			html += "<option value='" + shuoshuo.shuoshuoId + "'>" + shuoshuo.shuoshuoContent + "</option>";
		        		});
		        		$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").html(html);
		        		$("#shuoshuoZan_shuoshuoObj_shuoshuoId_edit").val(shuoshuoZan.shuoshuoObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#shuoshuoZan_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#shuoshuoZan_userObj_user_name_edit").html(html);
		        		$("#shuoshuoZan_userObj_user_name_edit").val(shuoshuoZan.userObjPri);
					}
				});
				$("#shuoshuoZan_zanTime_edit").val(shuoshuoZan.zanTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交说说点赞信息表单给服务器端修改*/
function ajaxShuoshuoZanModify() {
	$.ajax({
		url :  basePath + "ShuoshuoZan/" + $("#shuoshuoZan_zanId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#shuoshuoZanEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#shuoshuoZanQueryForm").submit();
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
    $('.shuoshuoZan_zanTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    shuoshuoZanEdit("<%=request.getParameter("zanId")%>");
 })
 </script> 
</body>
</html>

