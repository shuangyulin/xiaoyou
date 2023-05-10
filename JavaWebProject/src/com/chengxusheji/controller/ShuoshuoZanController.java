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
import com.chengxusheji.service.ShuoshuoZanService;
import com.chengxusheji.po.ShuoshuoZan;
import com.chengxusheji.service.ShuoshuoService;
import com.chengxusheji.po.Shuoshuo;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//ShuoshuoZan管理控制层
@Controller
@RequestMapping("/ShuoshuoZan")
public class ShuoshuoZanController extends BaseController {

    /*业务层对象*/
    @Resource ShuoshuoZanService shuoshuoZanService;

    @Resource ShuoshuoService shuoshuoService;
    @Resource UserInfoService userInfoService;
	@InitBinder("shuoshuoObj")
	public void initBindershuoshuoObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shuoshuoObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("shuoshuoZan")
	public void initBinderShuoshuoZan(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shuoshuoZan.");
	}
	/*跳转到添加ShuoshuoZan视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ShuoshuoZan());
		/*查询所有的Shuoshuo信息*/
		List<Shuoshuo> shuoshuoList = shuoshuoService.queryAllShuoshuo();
		request.setAttribute("shuoshuoList", shuoshuoList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "ShuoshuoZan_add";
	}

	/*客户端ajax方式提交添加说说点赞信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ShuoshuoZan shuoshuoZan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        shuoshuoZanService.addShuoshuoZan(shuoshuoZan);
        message = "说说点赞添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询说说点赞信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("shuoshuoObj") Shuoshuo shuoshuoObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (zanTime == null) zanTime = "";
		if(rows != 0)shuoshuoZanService.setRows(rows);
		List<ShuoshuoZan> shuoshuoZanList = shuoshuoZanService.queryShuoshuoZan(shuoshuoObj, userObj, zanTime, page);
	    /*计算总的页数和总的记录数*/
	    shuoshuoZanService.queryTotalPageAndRecordNumber(shuoshuoObj, userObj, zanTime);
	    /*获取到总的页码数目*/
	    int totalPage = shuoshuoZanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shuoshuoZanService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ShuoshuoZan shuoshuoZan:shuoshuoZanList) {
			JSONObject jsonShuoshuoZan = shuoshuoZan.getJsonObject();
			jsonArray.put(jsonShuoshuoZan);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询说说点赞信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ShuoshuoZan> shuoshuoZanList = shuoshuoZanService.queryAllShuoshuoZan();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ShuoshuoZan shuoshuoZan:shuoshuoZanList) {
			JSONObject jsonShuoshuoZan = new JSONObject();
			jsonShuoshuoZan.accumulate("zanId", shuoshuoZan.getZanId());
			jsonArray.put(jsonShuoshuoZan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询说说点赞信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("shuoshuoObj") Shuoshuo shuoshuoObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (zanTime == null) zanTime = "";
		List<ShuoshuoZan> shuoshuoZanList = shuoshuoZanService.queryShuoshuoZan(shuoshuoObj, userObj, zanTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    shuoshuoZanService.queryTotalPageAndRecordNumber(shuoshuoObj, userObj, zanTime);
	    /*获取到总的页码数目*/
	    int totalPage = shuoshuoZanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shuoshuoZanService.getRecordNumber();
	    request.setAttribute("shuoshuoZanList",  shuoshuoZanList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("shuoshuoObj", shuoshuoObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("zanTime", zanTime);
	    List<Shuoshuo> shuoshuoList = shuoshuoService.queryAllShuoshuo();
	    request.setAttribute("shuoshuoList", shuoshuoList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "ShuoshuoZan/shuoshuoZan_frontquery_result"; 
	}

     /*前台查询ShuoshuoZan信息*/
	@RequestMapping(value="/{zanId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer zanId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键zanId获取ShuoshuoZan对象*/
        ShuoshuoZan shuoshuoZan = shuoshuoZanService.getShuoshuoZan(zanId);

        List<Shuoshuo> shuoshuoList = shuoshuoService.queryAllShuoshuo();
        request.setAttribute("shuoshuoList", shuoshuoList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("shuoshuoZan",  shuoshuoZan);
        return "ShuoshuoZan/shuoshuoZan_frontshow";
	}

	/*ajax方式显示说说点赞修改jsp视图页*/
	@RequestMapping(value="/{zanId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer zanId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键zanId获取ShuoshuoZan对象*/
        ShuoshuoZan shuoshuoZan = shuoshuoZanService.getShuoshuoZan(zanId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonShuoshuoZan = shuoshuoZan.getJsonObject();
		out.println(jsonShuoshuoZan.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新说说点赞信息*/
	@RequestMapping(value = "/{zanId}/update", method = RequestMethod.POST)
	public void update(@Validated ShuoshuoZan shuoshuoZan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			shuoshuoZanService.updateShuoshuoZan(shuoshuoZan);
			message = "说说点赞更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "说说点赞更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除说说点赞信息*/
	@RequestMapping(value="/{zanId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer zanId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  shuoshuoZanService.deleteShuoshuoZan(zanId);
	            request.setAttribute("message", "说说点赞删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "说说点赞删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条说说点赞记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String zanIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = shuoshuoZanService.deleteShuoshuoZans(zanIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出说说点赞信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("shuoshuoObj") Shuoshuo shuoshuoObj,@ModelAttribute("userObj") UserInfo userObj,String zanTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(zanTime == null) zanTime = "";
        List<ShuoshuoZan> shuoshuoZanList = shuoshuoZanService.queryShuoshuoZan(shuoshuoObj,userObj,zanTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ShuoshuoZan信息记录"; 
        String[] headers = { "点赞id","被点赞说说","点赞用户","点赞时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<shuoshuoZanList.size();i++) {
        	ShuoshuoZan shuoshuoZan = shuoshuoZanList.get(i); 
        	dataset.add(new String[]{shuoshuoZan.getZanId() + "",shuoshuoZan.getShuoshuoObj().getShuoshuoContent(),shuoshuoZan.getUserObj().getName(),shuoshuoZan.getZanTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ShuoshuoZan.xls");//filename是下载的xls的名，建议最好用英文 
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
