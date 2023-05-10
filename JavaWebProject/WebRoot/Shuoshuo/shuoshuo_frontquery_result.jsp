<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Shuoshuo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Shuoshuo> shuoshuoList = (List<Shuoshuo>)request.getAttribute("shuoshuoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String shuoshuoContent = (String)request.getAttribute("shuoshuoContent"); //说说内容查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>说说查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Shuoshuo/frontlist">说说信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Shuoshuo/shuoshuo_frontAdd.jsp" style="display:none;">添加说说</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<shuoshuoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Shuoshuo shuoshuo = shuoshuoList.get(i); //获取到说说对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Shuoshuo/<%=shuoshuo.getShuoshuoId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=shuoshuo.getPhoto1()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		说说id:<%=shuoshuo.getShuoshuoId() %>
			     	</div>
			     	<div class="field">
	            		说说内容:<%=shuoshuo.getShuoshuoContent() %>
			     	</div>
			     	<div class="field">
	            		发布人:<%=shuoshuo.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=shuoshuo.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Shuoshuo/<%=shuoshuo.getShuoshuoId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="shuoshuoEdit('<%=shuoshuo.getShuoshuoId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="shuoshuoDelete('<%=shuoshuo.getShuoshuoId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>说说查询</h1>
		</div>
		<form name="shuoshuoQueryForm" id="shuoshuoQueryForm" action="<%=basePath %>Shuoshuo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="shuoshuoContent">说说内容:</label>
				<input type="text" id="shuoshuoContent" name="shuoshuoContent" value="<%=shuoshuoContent %>" class="form-control" placeholder="请输入说说内容">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="shuoshuoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;说说信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#shuoshuoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxShuoshuoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.shuoshuoQueryForm.currentPage.value = currentPage;
    document.shuoshuoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.shuoshuoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.shuoshuoQueryForm.currentPage.value = pageValue;
    documentshuoshuoQueryForm.submit();
}

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
				$('#shuoshuoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除说说信息*/
function shuoshuoDelete(shuoshuoId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Shuoshuo/deletes",
			data : {
				shuoshuoIds : shuoshuoId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#shuoshuoQueryForm").submit();
					//location.href= basePath + "Shuoshuo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

