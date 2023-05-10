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
import com.chengxusheji.service.ShuoshuoService;
import com.chengxusheji.po.Shuoshuo;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Shuoshuo管理控制层
@Controller
@RequestMapping("/Shuoshuo")
public class ShuoshuoController extends BaseController {

    /*业务层对象*/
    @Resource ShuoshuoService shuoshuoService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("shuoshuo")
	public void initBinderShuoshuo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shuoshuo.");
	}
	/*跳转到添加Shuoshuo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Shuoshuo());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Shuoshuo_add";
	}

	/*客户端ajax方式提交添加说说信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Shuoshuo shuoshuo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			shuoshuo.setPhoto1(this.handlePhotoUpload(request, "photo1File"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			shuoshuo.setPhoto2(this.handlePhotoUpload(request, "photo2File"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			shuoshuo.setPhoto3(this.handlePhotoUpload(request, "photo3File"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        shuoshuoService.addShuoshuo(shuoshuo);
        message = "说说添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询说说信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String shuoshuoContent,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (shuoshuoContent == null) shuoshuoContent = "";
		if (addTime == null) addTime = "";
		if(rows != 0)shuoshuoService.setRows(rows);
		List<Shuoshuo> shuoshuoList = shuoshuoService.queryShuoshuo(shuoshuoContent, userObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    shuoshuoService.queryTotalPageAndRecordNumber(shuoshuoContent, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = shuoshuoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shuoshuoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Shuoshuo shuoshuo:shuoshuoList) {
			JSONObject jsonShuoshuo = shuoshuo.getJsonObject();
			jsonArray.put(jsonShuoshuo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询说说信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Shuoshuo> shuoshuoList = shuoshuoService.queryAllShuoshuo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Shuoshuo shuoshuo:shuoshuoList) {
			JSONObject jsonShuoshuo = new JSONObject();
			jsonShuoshuo.accumulate("shuoshuoId", shuoshuo.getShuoshuoId());
			jsonShuoshuo.accumulate("shuoshuoContent", shuoshuo.getShuoshuoContent());
			jsonArray.put(jsonShuoshuo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询说说信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String shuoshuoContent,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (shuoshuoContent == null) shuoshuoContent = "";
		if (addTime == null) addTime = "";
		List<Shuoshuo> shuoshuoList = shuoshuoService.queryShuoshuo(shuoshuoContent, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    shuoshuoService.queryTotalPageAndRecordNumber(shuoshuoContent, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = shuoshuoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shuoshuoService.getRecordNumber();
	    request.setAttribute("shuoshuoList",  shuoshuoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("shuoshuoContent", shuoshuoContent);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Shuoshuo/shuoshuo_frontquery_result"; 
	}

     /*前台查询Shuoshuo信息*/
	@RequestMapping(value="/{shuoshuoId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer shuoshuoId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键shuoshuoId获取Shuoshuo对象*/
        Shuoshuo shuoshuo = shuoshuoService.getShuoshuo(shuoshuoId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("shuoshuo",  shuoshuo);
        return "Shuoshuo/shuoshuo_frontshow";
	}

	/*ajax方式显示说说修改jsp视图页*/
	@RequestMapping(value="/{shuoshuoId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer shuoshuoId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shuoshuoId获取Shuoshuo对象*/
        Shuoshuo shuoshuo = shuoshuoService.getShuoshuo(shuoshuoId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonShuoshuo = shuoshuo.getJsonObject();
		out.println(jsonShuoshuo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新说说信息*/
	@RequestMapping(value = "/{shuoshuoId}/update", method = RequestMethod.POST)
	public void update(@Validated Shuoshuo shuoshuo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String photo1FileName = this.handlePhotoUpload(request, "photo1File");
		if(!photo1FileName.equals("upload/NoImage.jpg"))shuoshuo.setPhoto1(photo1FileName); 


		String photo2FileName = this.handlePhotoUpload(request, "photo2File");
		if(!photo2FileName.equals("upload/NoImage.jpg"))shuoshuo.setPhoto2(photo2FileName); 


		String photo3FileName = this.handlePhotoUpload(request, "photo3File");
		if(!photo3FileName.equals("upload/NoImage.jpg"))shuoshuo.setPhoto3(photo3FileName); 


		try {
			shuoshuoService.updateShuoshuo(shuoshuo);
			message = "说说更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "说说更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除说说信息*/
	@RequestMapping(value="/{shuoshuoId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer shuoshuoId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  shuoshuoService.deleteShuoshuo(shuoshuoId);
	            request.setAttribute("message", "说说删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "说说删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条说说记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String shuoshuoIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = shuoshuoService.deleteShuoshuos(shuoshuoIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出说说信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String shuoshuoContent,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(shuoshuoContent == null) shuoshuoContent = "";
        if(addTime == null) addTime = "";
        List<Shuoshuo> shuoshuoList = shuoshuoService.queryShuoshuo(shuoshuoContent,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Shuoshuo信息记录"; 
        String[] headers = { "说说id","说说内容","图片1","图片2","图片3","发布人","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<shuoshuoList.size();i++) {
        	Shuoshuo shuoshuo = shuoshuoList.get(i); 
        	dataset.add(new String[]{shuoshuo.getShuoshuoId() + "",shuoshuo.getShuoshuoContent(),shuoshuo.getPhoto1(),shuoshuo.getPhoto2(),shuoshuo.getPhoto3(),shuoshuo.getUserObj().getName(),shuoshuo.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Shuoshuo.xls");//filename是下载的xls的名，建议最好用英文 
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
