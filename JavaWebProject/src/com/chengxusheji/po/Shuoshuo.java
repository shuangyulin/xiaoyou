package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Shuoshuo {
    /*说说id*/
    private Integer shuoshuoId;
    public Integer getShuoshuoId(){
        return shuoshuoId;
    }
    public void setShuoshuoId(Integer shuoshuoId){
        this.shuoshuoId = shuoshuoId;
    }

    /*说说内容*/
    @NotEmpty(message="说说内容不能为空")
    private String shuoshuoContent;
    public String getShuoshuoContent() {
        return shuoshuoContent;
    }
    public void setShuoshuoContent(String shuoshuoContent) {
        this.shuoshuoContent = shuoshuoContent;
    }

    /*图片1*/
    private String photo1;
    public String getPhoto1() {
        return photo1;
    }
    public void setPhoto1(String photo1) {
        this.photo1 = photo1;
    }

    /*图片2*/
    private String photo2;
    public String getPhoto2() {
        return photo2;
    }
    public void setPhoto2(String photo2) {
        this.photo2 = photo2;
    }

    /*图片3*/
    private String photo3;
    public String getPhoto3() {
        return photo3;
    }
    public void setPhoto3(String photo3) {
        this.photo3 = photo3;
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
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonShuoshuo=new JSONObject(); 
		jsonShuoshuo.accumulate("shuoshuoId", this.getShuoshuoId());
		jsonShuoshuo.accumulate("shuoshuoContent", this.getShuoshuoContent());
		jsonShuoshuo.accumulate("photo1", this.getPhoto1());
		jsonShuoshuo.accumulate("photo2", this.getPhoto2());
		jsonShuoshuo.accumulate("photo3", this.getPhoto3());
		jsonShuoshuo.accumulate("userObj", this.getUserObj().getName());
		jsonShuoshuo.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonShuoshuo.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonShuoshuo;
    }}