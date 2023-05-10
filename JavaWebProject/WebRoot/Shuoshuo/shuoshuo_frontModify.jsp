<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Shuoshuo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Shuoshuo shuoshuo = (Shuoshuo)request.getAttribute("shuoshuo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改说说信息</TITLE>
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
  		<li class="active">说说信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="shuoshuoEditForm" id="shuoshuoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="shuoshuo_shuoshuoId_edit" class="col-md-3 text-right">说说id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="shuoshuo_shuoshuoId_edit" name="shuoshuo.shuoshuoId" class="form-control" placeholder="请输入说说id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="shuoshuo_shuoshuoContent_edit" class="col-md-3 text-right">说说内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="shuoshuo_shuoshuoContent_edit" name="shuoshuo.shuoshuoContent" rows="8" class="form-control" placeholder="请输入说说内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuo_photo1_edit" class="col-md-3 text-right">图片1:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="shuoshuo_photo1Img" border="0px"/><br/>
			    <input type="hidden" id="shuoshuo_photo1" name="shuoshuo.photo1"/>
			    <input id="photo1File" name="photo1File" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuo_photo2_edit" class="col-md-3 text-right">图片2:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="shuoshuo_photo2Img" border="0px"/><br/>
			    <input type="hidden" id="shuoshuo_photo2" name="shuoshuo.photo2"/>
			    <input id="photo2File" name="photo2File" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuo_photo3_edit" class="col-md-3 text-right">图片3:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="shuoshuo_photo3Img" border="0px"/><br/>
			    <input type="hidden" id="shuoshuo_photo3" name="shuoshuo.photo3"/>
			    <input id="photo3File" name="photo3File" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuo_userObj_user_name_edit" class="col-md-3 text-right">发布人:</label>
		  	 <div class="col-md-9">
			    <select id="shuoshuo_userObj_user_name_edit" name="shuoshuo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="shuoshuo_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date shuoshuo_addTime_edit col-md-12" data-link-field="shuoshuo_addTime_edit">
                    <input class="form-control" id="shuoshuo_addTime_edit" name="shuoshuo.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxShuoshuoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#shuoshuoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改说说界面并初始化数据*/
function shuoshuoEdit(shuoshuoId) {
	$.ajax({
		url :  basePath + "Shuoshuo/" + shuoshuoId + "/update",
		type : "get",
		dataType: "json",
		success : function (shuoshuo, response, status) {
			if (shuoshuo) {
				$("#shuoshuo_shuoshuoId_edit").val(shuoshuo.shuoshuoId);
				$("#shuoshuo_shuoshuoContent_edit").val(shuoshuo.shuoshuoContent);
				$("#shuoshuo_photo1").val(shuoshuo.photo1);
				$("#shuoshuo_photo1Img").attr("src", basePath +　shuoshuo.photo1);
				$("#shuoshuo_photo2").val(shuoshuo.photo2);
				$("#shuoshuo_photo2Img").attr("src", basePath +　shuoshuo.photo2);
				$("#shuoshuo_photo3").val(shuoshuo.photo3);
				$("#shuoshuo_photo3Img").attr("src", basePath +　shuoshuo.photo3);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#shuoshuo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#shuoshuo_userObj_user_name_edit").html(html);
		        		$("#shuoshuo_userObj_user_name_edit").val(shuoshuo.userObjPri);
					}
				});
				$("#shuoshuo_addTime_edit").val(shuoshuo.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交说说信息表单给服务器端修改*/
function ajaxShuoshuoModify() {
	$.ajax({
		url :  basePath + "Shuoshuo/" + $("#shuoshuo_shuoshuoId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#shuoshuoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#shuoshuoQueryForm").submit();
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
    /*发布时间组件*/
    $('.shuoshuo_addTime_edit').datetimepicker({
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
    shuoshuoEdit("<%=request.getParameter("shuoshuoId")%>");
 })
 </script> 
</body>
</html>

