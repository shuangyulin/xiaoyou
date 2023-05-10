package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ZanInfo {
    /*点赞id*/
    private Integer zanId;
    public Integer getZanId(){
        return zanId;
    }
    public void setZanId(Integer zanId){
        this.zanId = zanId;
    }

    /*被点赞文章*/
    private PostInfo postObj;
    public PostInfo getPostObj() {
        return postObj;
    }
    public void setPostObj(PostInfo postObj) {
        this.postObj = postObj;
    }

    /*点赞人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*点赞时间*/
    @NotEmpty(message="点赞时间不能为空")
    private String zanTime;
    public String getZanTime() {
        return zanTime;
    }
    public void setZanTime(String zanTime) {
        this.zanTime = zanTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonZanInfo=new JSONObject(); 
		jsonZanInfo.accumulate("zanId", this.getZanId());
		jsonZanInfo.accumulate("postObj", this.getPostObj().getTitle());
		jsonZanInfo.accumulate("postObjPri", this.getPostObj().getPostInfoId());
		jsonZanInfo.accumulate("userObj", this.getUserObj().getName());
		jsonZanInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonZanInfo.accumulate("zanTime", this.getZanTime().length()>19?this.getZanTime().substring(0,19):this.getZanTime());
		return jsonZanInfo;
    }}