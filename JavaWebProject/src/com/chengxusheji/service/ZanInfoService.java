package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.PostInfo;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.ZanInfo;

import com.chengxusheji.mapper.ZanInfoMapper;
@Service
public class ZanInfoService {

	@Resource ZanInfoMapper zanInfoMapper;
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

    /*添加文章点赞记录*/
    public void addZanInfo(ZanInfo zanInfo) throws Exception {
    	zanInfoMapper.addZanInfo(zanInfo);
    }

    /*按照查询条件分页查询文章点赞记录*/
    public ArrayList<ZanInfo> queryZanInfo(PostInfo postObj,UserInfo userObj,String zanTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != postObj && postObj.getPostInfoId()!= null && postObj.getPostInfoId()!= 0)  where += " and t_zanInfo.postObj=" + postObj.getPostInfoId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_zanInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_zanInfo.zanTime like '%" + zanTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return zanInfoMapper.queryZanInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ZanInfo> queryZanInfo(PostInfo postObj,UserInfo userObj,String zanTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != postObj && postObj.getPostInfoId()!= null && postObj.getPostInfoId()!= 0)  where += " and t_zanInfo.postObj=" + postObj.getPostInfoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_zanInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_zanInfo.zanTime like '%" + zanTime + "%'";
    	return zanInfoMapper.queryZanInfoList(where);
    }

    /*查询所有文章点赞记录*/
    public ArrayList<ZanInfo> queryAllZanInfo()  throws Exception {
        return zanInfoMapper.queryZanInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(PostInfo postObj,UserInfo userObj,String zanTime) throws Exception {
     	String where = "where 1=1";
    	if(null != postObj && postObj.getPostInfoId()!= null && postObj.getPostInfoId()!= 0)  where += " and t_zanInfo.postObj=" + postObj.getPostInfoId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_zanInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!zanTime.equals("")) where = where + " and t_zanInfo.zanTime like '%" + zanTime + "%'";
        recordNumber = zanInfoMapper.queryZanInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取文章点赞记录*/
    public ZanInfo getZanInfo(int zanId) throws Exception  {
        ZanInfo zanInfo = zanInfoMapper.getZanInfo(zanId);
        return zanInfo;
    }

    /*更新文章点赞记录*/
    public void updateZanInfo(ZanInfo zanInfo) throws Exception {
        zanInfoMapper.updateZanInfo(zanInfo);
    }

    /*删除一条文章点赞记录*/
    public void deleteZanInfo (int zanId) throws Exception {
        zanInfoMapper.deleteZanInfo(zanId);
    }

    /*删除多条文章点赞信息*/
    public int deleteZanInfos (String zanIds) throws Exception {
    	String _zanIds[] = zanIds.split(",");
    	for(String _zanId: _zanIds) {
    		zanInfoMapper.deleteZanInfo(Integer.parseInt(_zanId));
    	}
    	return _zanIds.length;
    }
}
