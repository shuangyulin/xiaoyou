package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class PostInfo {
    /*文章id*/
    private Integer postInfoId;
    public Integer getPostInfoId(){
        return postInfoId;
    }
    public void setPostInfoId(Integer postInfoId){
        this.postInfoId = postInfoId;
    }

    /*文章标题*/
    @NotEmpty(message="文章标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*文章图片*/
    private String postPhoto;
    public String getPostPhoto() {
        return postPhoto;
    }
    public void setPostPhoto(String postPhoto) {
        this.postPhoto = postPhoto;
    }

    /*文章内容*/
    @NotEmpty(message="文章内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*浏览量*/
    @NotNull(message="必须输入浏览量")
    private Integer hitNum;
    public Integer getHitNum() {
        return hitNum;
    }
    public void setHitNum(Integer hitNum) {
        this.hitNum = hitNum;
    }

    /*发布人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPostInfo=new JSONObject(); 
		jsonPostInfo.accumulate("postInfoId", this.getPostInfoId());
		jsonPostInfo.accumulate("title", this.getTitle());
		jsonPostInfo.accumulate("postPhoto", this.getPostPhoto());
		jsonPostInfo.accumulate("content", this.getContent());
		jsonPostInfo.accumulate("hitNum", this.getHitNum());
		jsonPostInfo.accumulate("userObj", this.getUserObj().getName());
		jsonPostInfo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonPostInfo.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonPostInfo;
    }}