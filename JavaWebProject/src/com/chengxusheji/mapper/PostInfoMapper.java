package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.PostInfo;

public interface PostInfoMapper {
	/*添加文章信息*/
	public void addPostInfo(PostInfo postInfo) throws Exception;

	/*按照查询条件分页查询文章记录*/
	public ArrayList<PostInfo> queryPostInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有文章记录*/
	public ArrayList<PostInfo> queryPostInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的文章记录数*/
	public int queryPostInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条文章记录*/
	public PostInfo getPostInfo(int postInfoId) throws Exception;

	/*更新文章记录*/
	public void updatePostInfo(PostInfo postInfo) throws Exception;

	/*删除文章记录*/
	public void deletePostInfo(int postInfoId) throws Exception;

}
