<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ZanInfo" %>
<%@ page import="com.chengxusheji.po.PostInfo" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ZanInfo> zanInfoList = (List<ZanInfo>)request.getAttribute("zanInfoList");
    //获取所有的postObj信息
    List<PostInfo> postInfoList = (List<PostInfo>)request.getAttribute("postInfoList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    PostInfo postObj = (PostInfo)request.getAttribute("postObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String zanTime = (String)request.getAttribute("zanTime"); //点赞时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>文章点赞查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#zanInfoListPanel" aria-controls="zanInfoListPanel" role="tab" data-toggle="tab">文章点赞列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ZanInfo/zanInfo_frontAdd.jsp" style="display:none;">添加文章点赞</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="zanInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>点赞id</td><td>被点赞文章</td><td>点赞人</td><td>点赞时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<zanInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ZanInfo zanInfo = zanInfoList.get(i); //获取到文章点赞对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=zanInfo.getZanId() %></td>
 											<td><%=zanInfo.getPostObj().getTitle() %></td>
 											<td><%=zanInfo.getUserObj().getName() %></td>
 											<td><%=zanInfo.getZanTime() %></td>
 											<td>
 												<a href="<%=basePath  %>ZanInfo/<%=zanInfo.getZanId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="zanInfoEdit('<%=zanInfo.getZanId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="zanInfoDelete('<%=zanInfo.getZanId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>文章点赞查询</h1>
		</div>
		<form name="zanInfoQueryForm" id="zanInfoQueryForm" action="<%=basePath %>ZanInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="postObj_postInfoId">被点赞文章：</label>
                <select id="postObj_postInfoId" name="postObj.postInfoId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(PostInfo postInfoTemp:postInfoList) {
	 					String selected = "";
 					if(postObj!=null && postObj.getPostInfoId()!=null && postObj.getPostInfoId().intValue()==postInfoTemp.getPostInfoId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=postInfoTemp.getPostInfoId() %>" <%=selected %>><%=postInfoTemp.getTitle() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">点赞人：</label>
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
				<label for="zanTime">点赞时间:</label>
				<input type="text" id="zanTime" name="zanTime" class="form-control"  placeholder="请选择点赞时间" value="<%=zanTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="zanInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;文章点赞信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date zanInfo_zanTime_edit col-md-12" data-link-field="zanInfo_zanTime_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="zanInfo_zanTime_edit" name="zanInfo.zanTime" size="16" type="text" value="" placeholder="请选择点赞时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#zanInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxZanInfoModify();">提交</button>
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
    document.zanInfoQueryForm.currentPage.value = currentPage;
    document.zanInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.zanInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.zanInfoQueryForm.currentPage.value = pageValue;
    documentzanInfoQueryForm.submit();
}

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
				$('#zanInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除文章点赞信息*/
function zanInfoDelete(zanId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ZanInfo/deletes",
			data : {
				zanIds : zanId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#zanInfoQueryForm").submit();
					//location.href= basePath + "ZanInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

