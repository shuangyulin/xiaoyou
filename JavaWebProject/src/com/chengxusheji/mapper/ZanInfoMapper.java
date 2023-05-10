package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ZanInfo;

public interface ZanInfoMapper {
	/*添加文章点赞信息*/
	public void addZanInfo(ZanInfo zanInfo) throws Exception;

	/*按照查询条件分页查询文章点赞记录*/
	public ArrayList<ZanInfo> queryZanInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有文章点赞记录*/
	public ArrayList<ZanInfo> queryZanInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的文章点赞记录数*/
	public int queryZanInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条文章点赞记录*/
	public ZanInfo getZanInfo(int zanId) throws Exception;

	/*更新文章点赞记录*/
	public void updateZanInfo(ZanInfo zanInfo) throws Exception;

	/*删除文章点赞记录*/
	public void deleteZanInfo(int zanId) throws Exception;

}
