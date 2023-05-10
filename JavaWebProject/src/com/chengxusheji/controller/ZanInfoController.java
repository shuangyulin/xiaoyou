package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.ZanInfoService;
import com.chengxusheji.po.ZanInfo;
import com.chengxusheji.service.PostInfoService;
import com.chengxusheji.po.PostInfo;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//ZanInfo管理控制层
@Controller
@RequestMapping("/ZanInfo")
public class ZanInfoController extends BaseController {

    /*业务层对象*/
    @Resource ZanInfoService zanInfoService;

    @Resource PostInfoService postInfoService;
    @Resource UserInfoService userInfoService;
	@InitBinder("postObj")
	public void initBinderpostObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("postObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("zanInfo")
	public void initBinderZanInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("zanInfo.");
	}
	/*跳转到添加ZanInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ZanInfo());
		/*查询所有的PostInfo信息*/
		List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
		request.setAttribute("postInfoList", postInfoList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "ZanInfo_add";
	}

	/*客户端ajax方式提交添加文章点赞信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ZanInfo zanInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        zanInfoService.addZanInfo(zanInfo);
        message = "文章点赞添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询文章点赞信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("postObj") PostInfo postObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (zanTime == null) zanTime = "";
		if(rows != 0)zanInfoService.setRows(rows);
		List<ZanInfo> zanInfoList = zanInfoService.queryZanInfo(postObj, userObj, zanTime, page);
	    /*计算总的页数和总的记录数*/
	    zanInfoService.queryTotalPageAndRecordNumber(postObj, userObj, zanTime);
	    /*获取到总的页码数目*/
	    int totalPage = zanInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zanInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ZanInfo zanInfo:zanInfoList) {
			JSONObject jsonZanInfo = zanInfo.getJsonObject();
			jsonArray.put(jsonZanInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询文章点赞信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ZanInfo> zanInfoList = zanInfoService.queryAllZanInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ZanInfo zanInfo:zanInfoList) {
			JSONObject jsonZanInfo = new JSONObject();
			jsonZanInfo.accumulate("zanId", zanInfo.getZanId());
			jsonArray.put(jsonZanInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询文章点赞信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("postObj") PostInfo postObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (zanTime == null) zanTime = "";
		List<ZanInfo> zanInfoList = zanInfoService.queryZanInfo(postObj, userObj, zanTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    zanInfoService.queryTotalPageAndRecordNumber(postObj, userObj, zanTime);
	    /*获取到总的页码数目*/
	    int totalPage = zanInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zanInfoService.getRecordNumber();
	    request.setAttribute("zanInfoList",  zanInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("postObj", postObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("zanTime", zanTime);
	    List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
	    request.setAttribute("postInfoList", postInfoList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ZanInfo/zanInfo_frontquery_result"; 
	}

     /*前台查询ZanInfo信息*/
	@RequestMapping(value="/{zanId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer zanId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键zanId获取ZanInfo对象*/
        ZanInfo zanInfo = zanInfoService.getZanInfo(zanId);

        List<PostInfo> postInfoList = postInfoService.queryAllPostInfo();
        request.setAttribute("postInfoList", postInfoList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("zanInfo",  zanInfo);
        return "ZanInfo/zanInfo_frontshow";
	}

	/*ajax方式显示文章点赞修改jsp视图页*/
	@RequestMapping(value="/{zanId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer zanId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键zanId获取ZanInfo对象*/
        ZanInfo zanInfo = zanInfoService.getZanInfo(zanId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonZanInfo = zanInfo.getJsonObject();
		out.println(jsonZanInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新文章点赞信息*/
	@RequestMapping(value = "/{zanId}/update", method = RequestMethod.POST)
	public void update(@Validated ZanInfo zanInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			zanInfoService.updateZanInfo(zanInfo);
			message = "文章点赞更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "文章点赞更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除文章点赞信息*/
	@RequestMapping(value="/{zanId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer zanId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  zanInfoService.deleteZanInfo(zanId);
	            request.setAttribute("message", "文章点赞删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "文章点赞删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条文章点赞记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String zanIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = zanInfoService.deleteZanInfos(zanIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出文章点赞信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("postObj") PostInfo postObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(zanTime == null) zanTime = "";
        List<ZanInfo> zanInfoList = zanInfoService.queryZanInfo(postObj,userObj,zanTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ZanInfo信息记录"; 
        String[] headers = { "点赞id","被点赞文章","点赞人","点赞时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<zanInfoList.size();i++) {
        	ZanInfo zanInfo = zanInfoList.get(i); 
        	dataset.add(new String[]{zanInfo.getZanId() + "",zanInfo.getPostObj().getTitle(),zanInfo.getUserObj().getName(),zanInfo.getZanTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"ZanInfo.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
