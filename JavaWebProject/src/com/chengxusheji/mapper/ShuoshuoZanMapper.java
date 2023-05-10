package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ShuoshuoZan;

public interface ShuoshuoZanMapper {
	/*添加说说点赞信息*/
	public void addShuoshuoZan(ShuoshuoZan shuoshuoZan) throws Exception;

	/*按照查询条件分页查询说说点赞记录*/
	public ArrayList<ShuoshuoZan> queryShuoshuoZan(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有说说点赞记录*/
	public ArrayList<ShuoshuoZan> queryShuoshuoZanList(@Param("where") String where) throws Exception;

	/*按照查询条件的说说点赞记录数*/
	public int queryShuoshuoZanCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条说说点赞记录*/
	public ShuoshuoZan getShuoshuoZan(int zanId) throws Exception;

	/*更新说说点赞记录*/
	public void updateShuoshuoZan(ShuoshuoZan shuoshuoZan) throws Exception;

	/*删除说说点赞记录*/
	public void deleteShuoshuoZan(int zanId) throws Exception;

}
