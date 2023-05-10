package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Shuoshuo;

import com.chengxusheji.mapper.ShuoshuoMapper;
@Service
public class ShuoshuoService {

	@Resource ShuoshuoMapper shuoshuoMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加说说记录*/
    public void addShuoshuo(Shuoshuo shuoshuo) throws Exception {
    	shuoshuoMapper.addShuoshuo(shuoshuo);
    }

    /*按照查询条件分页查询说说记录*/
    public ArrayList<Shuoshuo> queryShuoshuo(String shuoshuoContent,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!shuoshuoContent.equals("")) where = where + " and t_shuoshuo.shuoshuoContent like '%" + shuoshuoContent + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_shuoshuo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_shuoshuo.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return shuoshuoMapper.queryShuoshuo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Shuoshuo> queryShuoshuo(String shuoshuoContent,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!shuoshuoContent.equals("")) where = where + " and t_shuoshuo.shuoshuoContent like '%" + shuoshuoContent + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shuoshuo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_shuoshuo.addTime like '%" + addTime + "%'";
    	return shuoshuoMapper.queryShuoshuoList(where);
    }

    /*查询所有说说记录*/
    public ArrayList<Shuoshuo> queryAllShuoshuo()  throws Exception {
        return shuoshuoMapper.queryShuoshuoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String shuoshuoContent,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!shuoshuoContent.equals("")) where = where + " and t_shuoshuo.shuoshuoContent like '%" + shuoshuoContent + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shuoshuo.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_shuoshuo.addTime like '%" + addTime + "%'";
        recordNumber = shuoshuoMapper.queryShuoshuoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取说说记录*/
    public Shuoshuo getShuoshuo(int shuoshuoId) throws Exception  {
        Shuoshuo shuoshuo = shuoshuoMapper.getShuoshuo(shuoshuoId);
        return shuoshuo;
    }

    /*更新说说记录*/
    public void updateShuoshuo(Shuoshuo shuoshuo) throws Exception {
        shuoshuoMapper.updateShuoshuo(shuoshuo);
    }

    /*删除一条说说记录*/
    public void deleteShuoshuo (int shuoshuoId) throws Exception {
        shuoshuoMapper.deleteShuoshuo(shuoshuoId);
    }

    /*删除多条说说信息*/
    public int deleteShuoshuos (String shuoshuoIds) throws Exception {
    	String _shuoshuoIds[] = shuoshuoIds.split(",");
    	for(String _shuoshuoId: _shuoshuoIds) {
    		shuoshuoMapper.deleteShuoshuo(Integer.parseInt(_shuoshuoId));
    	}
    	return _shuoshuoIds.length;
    }
}
