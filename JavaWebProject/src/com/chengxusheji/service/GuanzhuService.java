package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Guanzhu;

import com.chengxusheji.mapper.GuanzhuMapper;
@Service
public class GuanzhuService {

	@Resource GuanzhuMapper guanzhuMapper;
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

    /*添加用户关注记录*/
    public void addGuanzhu(Guanzhu guanzhu) throws Exception {
    	guanzhuMapper.addGuanzhu(guanzhu);
    }

    /*按照查询条件分页查询用户关注记录*/
    public ArrayList<Guanzhu> queryGuanzhu(UserInfo userObj1,UserInfo userObj2,String guanzhuTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null  && !userObj1.getUser_name().equals(""))  where += " and t_guanzhu.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null  && !userObj2.getUser_name().equals(""))  where += " and t_guanzhu.userObj2='" + userObj2.getUser_name() + "'";
    	if(!guanzhuTime.equals("")) where = where + " and t_guanzhu.guanzhuTime like '%" + guanzhuTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return guanzhuMapper.queryGuanzhu(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Guanzhu> queryGuanzhu(UserInfo userObj1,UserInfo userObj2,String guanzhuTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_guanzhu.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_guanzhu.userObj2='" + userObj2.getUser_name() + "'";
    	if(!guanzhuTime.equals("")) where = where + " and t_guanzhu.guanzhuTime like '%" + guanzhuTime + "%'";
    	return guanzhuMapper.queryGuanzhuList(where);
    }

    /*查询所有用户关注记录*/
    public ArrayList<Guanzhu> queryAllGuanzhu()  throws Exception {
        return guanzhuMapper.queryGuanzhuList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj1,UserInfo userObj2,String guanzhuTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj1 &&  userObj1.getUser_name() != null && !userObj1.getUser_name().equals(""))  where += " and t_guanzhu.userObj1='" + userObj1.getUser_name() + "'";
    	if(null != userObj2 &&  userObj2.getUser_name() != null && !userObj2.getUser_name().equals(""))  where += " and t_guanzhu.userObj2='" + userObj2.getUser_name() + "'";
    	if(!guanzhuTime.equals("")) where = where + " and t_guanzhu.guanzhuTime like '%" + guanzhuTime + "%'";
        recordNumber = guanzhuMapper.queryGuanzhuCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取用户关注记录*/
    public Guanzhu getGuanzhu(int guanzhuId) throws Exception  {
        Guanzhu guanzhu = guanzhuMapper.getGuanzhu(guanzhuId);
        return guanzhu;
    }

    /*更新用户关注记录*/
    public void updateGuanzhu(Guanzhu guanzhu) throws Exception {
        guanzhuMapper.updateGuanzhu(guanzhu);
    }

    /*删除一条用户关注记录*/
    public void deleteGuanzhu (int guanzhuId) throws Exception {
        guanzhuMapper.deleteGuanzhu(guanzhuId);
    }

    /*删除多条用户关注信息*/
    public int deleteGuanzhus (String guanzhuIds) throws Exception {
    	String _guanzhuIds[] = guanzhuIds.split(",");
    	for(String _guanzhuId: _guanzhuIds) {
    		guanzhuMapper.deleteGuanzhu(Integer.parseInt(_guanzhuId));
    	}
    	return _guanzhuIds.length;
    }
}
