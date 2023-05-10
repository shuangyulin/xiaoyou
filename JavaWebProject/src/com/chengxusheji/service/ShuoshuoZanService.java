package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Shuoshuo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.ShuoshuoZan;

import com.chengxusheji.mapper.ShuoshuoZanMapper;
@Service
public class ShuoshuoZanService {

	@Resource ShuoshuoZanMapper shuoshuoZanMapper;
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

    /*添加说说点赞记录*/
    public void addShuoshuoZan(ShuoshuoZan shuoshuoZan) throws Exception {
    	shuoshuoZanMapper.addShuoshuoZan(shuoshuoZan);
    }

    /*按照查询条件分页查询说说点赞记录*/
    public ArrayList<ShuoshuoZan> queryShuoshuoZan(Shuoshuo shuoshuoObj,UserInfo userObj,String zanTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != shuoshuoObj && shuoshuoObj.getShuoshuoId()!= null && shuoshuoObj.getShuoshuoId()!= 0)  where += " and t_shuoshuoZan.shuoshuoObj=" + shuoshuoObj.getShuoshuoId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_shuoshuoZan.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_shuoshuoZan.zanTime like '%" + zanTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return shuoshuoZanMapper.queryShuoshuoZan(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ShuoshuoZan> queryShuoshuoZan(Shuoshuo shuoshuoObj,UserInfo userObj,String zanTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != shuoshuoObj && shuoshuoObj.getShuoshuoId()!= null && shuoshuoObj.getShuoshuoId()!= 0)  where += " and t_shuoshuoZan.shuoshuoObj=" + shuoshuoObj.getShuoshuoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shuoshuoZan.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_shuoshuoZan.zanTime like '%" + zanTime + "%'";
    	return shuoshuoZanMapper.queryShuoshuoZanList(where);
    }

    /*查询所有说说点赞记录*/
    public ArrayList<ShuoshuoZan> queryAllShuoshuoZan()  throws Exception {
        return shuoshuoZanMapper.queryShuoshuoZanList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Shuoshuo shuoshuoObj,UserInfo userObj,String zanTime) throws Exception {
     	String where = "where 1=1";
    	if(null != shuoshuoObj && shuoshuoObj.getShuoshuoId()!= null && shuoshuoObj.getShuoshuoId()!= 0)  where += " and t_shuoshuoZan.shuoshuoObj=" + shuoshuoObj.getShuoshuoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_shuoshuoZan.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_shuoshuoZan.zanTime like '%" + zanTime + "%'";
        recordNumber = shuoshuoZanMapper.queryShuoshuoZanCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取说说点赞记录*/
    public ShuoshuoZan getShuoshuoZan(int zanId) throws Exception  {
        ShuoshuoZan shuoshuoZan = shuoshuoZanMapper.getShuoshuoZan(zanId);
        return shuoshuoZan;
    }

    /*更新说说点赞记录*/
    public void updateShuoshuoZan(ShuoshuoZan shuoshuoZan) throws Exception {
        shuoshuoZanMapper.updateShuoshuoZan(shuoshuoZan);
    }

    /*删除一条说说点赞记录*/
    public void deleteShuoshuoZan (int zanId) throws Exception {
        shuoshuoZanMapper.deleteShuoshuoZan(zanId);
    }

    /*删除多条说说点赞信息*/
    public int deleteShuoshuoZans (String zanIds) throws Exception {
    	String _zanIds[] = zanIds.split(",");
    	for(String _zanId: _zanIds) {
    		shuoshuoZanMapper.deleteShuoshuoZan(Integer.parseInt(_zanId));
    	}
    	return _zanIds.length;
    }
}
