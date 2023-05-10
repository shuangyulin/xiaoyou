package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Guanzhu {
    /*关注id*/
    private Integer guanzhuId;
    public Integer getGuanzhuId(){
        return guanzhuId;
    }
    public void setGuanzhuId(Integer guanzhuId){
        this.guanzhuId = guanzhuId;
    }

    /*被关注人*/
    private UserInfo userObj1;
    public UserInfo getUserObj1() {
        return userObj1;
    }
    public void setUserObj1(UserInfo userObj1) {
        this.userObj1 = userObj1;
    }

    /*关注人*/
    private UserInfo userObj2;
    public UserInfo getUserObj2() {
        return userObj2;
    }
    public void setUserObj2(UserInfo userObj2) {
        this.userObj2 = userObj2;
    }

    /*关注时间*/
    @NotEmpty(message="关注时间不能为空")
    private String guanzhuTime;
    public String getGuanzhuTime() {
        return guanzhuTime;
    }
    public void setGuanzhuTime(String guanzhuTime) {
        this.guanzhuTime = guanzhuTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonGuanzhu=new JSONObject(); 
		jsonGuanzhu.accumulate("guanzhuId", this.getGuanzhuId());
		jsonGuanzhu.accumulate("userObj1", this.getUserObj1().getName());
		jsonGuanzhu.accumulate("userObj1Pri", this.getUserObj1().getUser_name());
		jsonGuanzhu.accumulate("userObj2", this.getUserObj2().getName());
		jsonGuanzhu.accumulate("userObj2Pri", this.getUserObj2().getUser_name());
		jsonGuanzhu.accumulate("guanzhuTime", this.getGuanzhuTime().length()>19?this.getGuanzhuTime().substring(0,19):this.getGuanzhuTime());
		return jsonGuanzhu;
    }}