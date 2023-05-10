package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ShuoshuoZan {
    /*点赞id*/
    private Integer zanId;
    public Integer getZanId(){
        return zanId;
    }
    public void setZanId(Integer zanId){
        this.zanId = zanId;
    }

    /*被点赞说说*/
    private Shuoshuo shuoshuoObj;
    public Shuoshuo getShuoshuoObj() {
        return shuoshuoObj;
    }
    public void setShuoshuoObj(Shuoshuo shuoshuoObj) {
        this.shuoshuoObj = shuoshuoObj;
    }

    /*点赞用户*/
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
    	JSONObject jsonShuoshuoZan=new JSONObject(); 
		jsonShuoshuoZan.accumulate("zanId", this.getZanId());
		jsonShuoshuoZan.accumulate("shuoshuoObj", this.getShuoshuoObj().getShuoshuoContent());
		jsonShuoshuoZan.accumulate("shuoshuoObjPri", this.getShuoshuoObj().getShuoshuoId());
		jsonShuoshuoZan.accumulate("userObj", this.getUserObj().getName());
		jsonShuoshuoZan.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonShuoshuoZan.accumulate("zanTime", this.getZanTime().length()>19?this.getZanTime().substring(0,19):this.getZanTime());
		return jsonShuoshuoZan;
    }}