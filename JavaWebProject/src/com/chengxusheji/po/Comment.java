package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Comment {
    /*评论id*/
    private Integer commentId;
    public Integer getCommentId(){
        return commentId;
    }
    public void setCommentId(Integer commentId){
        this.commentId = commentId;
    }

    /*被评说说*/
    private Shuoshuo shuoshuoObj;
    public Shuoshuo getShuoshuoObj() {
        return shuoshuoObj;
    }
    public void setShuoshuoObj(Shuoshuo shuoshuoObj) {
        this.shuoshuoObj = shuoshuoObj;
    }

    /*评论内容*/
    @NotEmpty(message="评论内容不能为空")
    private String commentContent;
    public String getCommentContent() {
        return commentContent;
    }
    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    /*评论人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*评论时间*/
    @NotEmpty(message="评论时间不能为空")
    private String commentTime;
    public String getCommentTime() {
        return commentTime;
    }
    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonComment=new JSONObject(); 
		jsonComment.accumulate("commentId", this.getCommentId());
		jsonComment.accumulate("shuoshuoObj", this.getShuoshuoObj().getShuoshuoContent());
		jsonComment.accumulate("shuoshuoObjPri", this.getShuoshuoObj().getShuoshuoId());
		jsonComment.accumulate("commentContent", this.getCommentContent());
		jsonComment.accumulate("userObj", this.getUserObj().getName());
		jsonComment.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonComment.accumulate("commentTime", this.getCommentTime().length()>19?this.getCommentTime().substring(0,19):this.getCommentTime());
		return jsonComment;
    }}