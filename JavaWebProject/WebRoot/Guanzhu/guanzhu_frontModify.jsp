<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Guanzhu" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj2信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Guanzhu guanzhu = (Guanzhu)request.getAttribute("guanzhu");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改用户关注信息</TITLE>
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
  		<li class="active">用户关注信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="guanzhuEditForm" id="guanzhuEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="guanzhu_guanzhuId_edit" class="col-md-3 text-right">关注id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="guanzhu_guanzhuId_edit" name="guanzhu.guanzhuId" class="form-control" placeholder="请输入关注id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="guanzhu_userObj1_user_name_edit" class="col-md-3 text-right">被关注人:</label>
		  	 <div class="col-md-9">
			    <select id="guanzhu_userObj1_user_name_edit" name="guanzhu.userObj1.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="guanzhu_userObj2_user_name_edit" class="col-md-3 text-right">关注人:</label>
		  	 <div class="col-md-9">
			    <select id="guanzhu_userObj2_user_name_edit" name="guanzhu.userObj2.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="guanzhu_guanzhuTime_edit" class="col-md-3 text-right">关注时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date guanzhu_guanzhuTime_edit col-md-12" data-link-field="guanzhu_guanzhuTime_edit">
                    <input class="form-control" id="guanzhu_guanzhuTime_edit" name="guanzhu.guanzhuTime" size="16" type="text" value="" placeholder="请选择关注时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxGuanzhuModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#guanzhuEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改用户关注界面并初始化数据*/
function guanzhuEdit(guanzhuId) {
	$.ajax({
		url :  basePath + "Guanzhu/" + guanzhuId + "/update",
		type : "get",
		dataType: "json",
		success : function (guanzhu, response, status) {
			if (guanzhu) {
				$("#guanzhu_guanzhuId_edit").val(guanzhu.guanzhuId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#guanzhu_userObj1_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#guanzhu_userObj1_user_name_edit").html(html);
		        		$("#guanzhu_userObj1_user_name_edit").val(guanzhu.userObj1Pri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#guanzhu_userObj2_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#guanzhu_userObj2_user_name_edit").html(html);
		        		$("#guanzhu_userObj2_user_name_edit").val(guanzhu.userObj2Pri);
					}
				});
				$("#guanzhu_guanzhuTime_edit").val(guanzhu.guanzhuTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交用户关注信息表单给服务器端修改*/
function ajaxGuanzhuModify() {
	$.ajax({
		url :  basePath + "Guanzhu/" + $("#guanzhu_guanzhuId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#guanzhuEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#guanzhuQueryForm").submit();
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
    /*关注时间组件*/
    $('.guanzhu_guanzhuTime_edit').datetimepicker({
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
    guanzhuEdit("<%=request.getParameter("guanzhuId")%>");
 })
 </script> 
</body>
</html>

