<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Shuoshuo" %>
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
<title>说说点赞添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>ShuoshuoZan/frontlist">说说点赞列表</a></li>
			    	<li role="presentation" class="active"><a href="#shuoshuoZanAdd" aria-controls="shuoshuoZanAdd" role="tab" data-toggle="tab">添加说说点赞</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="shuoshuoZanList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="shuoshuoZanAdd"> 
				      	<form class="form-horizontal" name="shuoshuoZanAddForm" id="shuoshuoZanAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="shuoshuoZan_shuoshuoObj_shuoshuoId" class="col-md-2 text-right">被点赞说说:</label>
						  	 <div class="col-md-8">
							    <select id="shuoshuoZan_shuoshuoObj_shuoshuoId" name="shuoshuoZan.shuoshuoObj.shuoshuoId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="shuoshuoZan_userObj_user_name" class="col-md-2 text-right">点赞用户:</label>
						  	 <div class="col-md-8">
							    <select id="shuoshuoZan_userObj_user_name" name="shuoshuoZan.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="shuoshuoZan_zanTimeDiv" class="col-md-2 text-right">点赞时间:</label>
						  	 <div class="col-md-8">
				                <div id="shuoshuoZan_zanTimeDiv" class="input-group date shuoshuoZan_zanTime col-md-12" data-link-field="shuoshuoZan_zanTime">
				                    <input class="form-control" id="shuoshuoZan_zanTime" name="shuoshuoZan.zanTime" size="16" type="text" value="" placeholder="请选择点赞时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxShuoshuoZanAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#shuoshuoZanAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
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
	//提交添加说说点赞信息
	function ajaxShuoshuoZanAdd() { 
		//提交之前先验证表单
		$("#shuoshuoZanAddForm").data('bootstrapValidator').validate();
		if(!$("#shuoshuoZanAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "ShuoshuoZan/add",
			dataType : "json" , 
			data: new FormData($("#shuoshuoZanAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#shuoshuoZanAddForm").find("input").val("");
					$("#shuoshuoZanAddForm").find("textarea").val("");
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
	//验证说说点赞添加表单字段
	$('#shuoshuoZanAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"shuoshuoZan.zanTime": {
				validators: {
					notEmpty: {
						message: "点赞时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被点赞说说下拉框值 
	$.ajax({
		url: basePath + "Shuoshuo/listAll",
		type: "get",
		success: function(shuoshuos,response,status) { 
			$("#shuoshuoZan_shuoshuoObj_shuoshuoId").empty();
			var html="";
    		$(shuoshuos).each(function(i,shuoshuo){
    			html += "<option value='" + shuoshuo.shuoshuoId + "'>" + shuoshuo.shuoshuoContent + "</option>";
    		});
    		$("#shuoshuoZan_shuoshuoObj_shuoshuoId").html(html);
    	}
	});
	//初始化点赞用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#shuoshuoZan_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#shuoshuoZan_userObj_user_name").html(html);
    	}
	});
	//点赞时间组件
	$('#shuoshuoZan_zanTimeDiv').datetimepicker({
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
		$('#shuoshuoZanAddForm').data('bootstrapValidator').updateStatus('shuoshuoZan.zanTime', 'NOT_VALIDATED',null).validateField('shuoshuoZan.zanTime');
	});
})
</script>
</body>
</html>
