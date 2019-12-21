package com.javaclub.entity;

/**
 * Created by VS on 2017/10/29.
 */
public class ApplyGroupBean {
    private int id;
    private String groupName;
    private int projectId;
    private int status;
    private int praiseCount;
    private int score;
    private String captainName;
    private String projectName;

    public ApplyGroupBean(int id, String groupName, int projectId, int praiseCount, int score, String captainName, String projectName){
        this.id = id;
        this.groupName = groupName;
        this.projectId = projectId;
        this.praiseCount = praiseCount;
        this.score = score;
        this.captainName = captainName;
        this.projectName = projectName;
    }
    public ApplyGroupBean(){
        super();
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getCaptainName() {
        return captainName;
    }
    public void setCaptainName(String captainName) {
        this.captainName = captainName;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPraiseCount() {
        return praiseCount;
    }

    public void setPraiseCount(int praiseCount) {
        this.praiseCount = praiseCount;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }


}
