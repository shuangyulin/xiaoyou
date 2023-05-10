package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Guanzhu;

public interface GuanzhuMapper {
	/*添加用户关注信息*/
	public void addGuanzhu(Guanzhu guanzhu) throws Exception;

	/*按照查询条件分页查询用户关注记录*/
	public ArrayList<Guanzhu> queryGuanzhu(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有用户关注记录*/
	public ArrayList<Guanzhu> queryGuanzhuList(@Param("where") String where) throws Exception;

	/*按照查询条件的用户关注记录数*/
	public int queryGuanzhuCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条用户关注记录*/
	public Guanzhu getGuanzhu(int guanzhuId) throws Exception;

	/*更新用户关注记录*/
	public void updateGuanzhu(Guanzhu guanzhu) throws Exception;

	/*删除用户关注记录*/
	public void deleteGuanzhu(int guanzhuId) throws Exception;

}
