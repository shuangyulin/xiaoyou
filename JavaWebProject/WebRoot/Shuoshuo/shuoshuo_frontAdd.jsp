<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>说说添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Shuoshuo/frontlist">说说管理</a></li>
  			<li class="active">添加说说</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="shuoshuoAddForm" id="shuoshuoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="shuoshuo_shuoshuoContent" class="col-md-2 text-right">说说内容:</label>
				  	 <div class="col-md-8">
					    <textarea id="shuoshuo_shuoshuoContent" name="shuoshuo.shuoshuoContent" rows="8" class="form-control" placeholder="请输入说说内容"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="shuoshuo_photo1" class="col-md-2 text-right">图片1:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="shuoshuo_photo1Img" border="0px"/><br/>
					    <input type="hidden" id="shuoshuo_photo1" name="shuoshuo.photo1"/>
					    <input id="photo1File" name="photo1File" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="shuoshuo_photo2" class="col-md-2 text-right">图片2:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="shuoshuo_photo2Img" border="0px"/><br/>
					    <input type="hidden" id="shuoshuo_photo2" name="shuoshuo.photo2"/>
					    <input id="photo2File" name="photo2File" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="shuoshuo_photo3" class="col-md-2 text-right">图片3:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="shuoshuo_photo3Img" border="0px"/><br/>
					    <input type="hidden" id="shuoshuo_photo3" name="shuoshuo.photo3"/>
					    <input id="photo3File" name="photo3File" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="shuoshuo_userObj_user_name" class="col-md-2 text-right">发布人:</label>
				  	 <div class="col-md-8">
					    <select id="shuoshuo_userObj_user_name" name="shuoshuo.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="shuoshuo_addTimeDiv" class="col-md-2 text-right">发布时间:</label>
				  	 <div class="col-md-8">
		                <div id="shuoshuo_addTimeDiv" class="input-group date shuoshuo_addTime col-md-12" data-link-field="shuoshuo_addTime">
		                    <input class="form-control" id="shuoshuo_addTime" name="shuoshuo.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxShuoshuoAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#shuoshuoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加说说信息
	function ajaxShuoshuoAdd() { 
		//提交之前先验证表单
		$("#shuoshuoAddForm").data('bootstrapValidator').validate();
		if(!$("#shuoshuoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Shuoshuo/add",
			dataType : "json" , 
			data: new FormData($("#shuoshuoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#shuoshuoAddForm").find("input").val("");
					$("#shuoshuoAddForm").find("textarea").val("");
				} else {
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
	//验证说说添加表单字段
	$('#shuoshuoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"shuoshuo.shuoshuoContent": {
				validators: {
					notEmpty: {
						message: "说说内容不能为空",
					}
				}
			},
			"shuoshuo.addTime": {
				validators: {
					notEmpty: {
						message: "发布时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化发布人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#shuoshuo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#shuoshuo_userObj_user_name").html(html);
    	}
	});
	//发布时间组件
	$('#shuoshuo_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#shuoshuoAddForm').data('bootstrapValidator').updateStatus('shuoshuo.addTime', 'NOT_VALIDATED',null).validateField('shuoshuo.addTime');
	});
})
</script>
</body>
</html>
