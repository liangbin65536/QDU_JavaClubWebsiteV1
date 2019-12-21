package com.javaclub.entity;
import java.util.Date;
/**
 * Created by VS on 2017/10/29.
 */
public class ApplyMemberBean {
    private Integer id;
    private String username;
    private String name;
    private String password;
    private Integer gender;
    private String major;
    private String enrollment;
    private Date entryTime;
    private String mobile;
    private Integer status;
    private Integer position;
    private Integer groupId;
    private Integer projectId;
    private String projectName;
    private String ProjectContent;
    private String groupName;

    public ApplyMemberBean(int id, String username, String name, Integer gender, String major,
                           String enrollment, Date entryTime, String mobile, Integer position, Integer groupId){
        this.id = id;
        this.username = username;
        this.name = name;
        this.gender  = gender;
        this.major = major;
        this.enrollment = enrollment;
        this.entryTime = entryTime;
        this.mobile = mobile;
        this.position = position;
        this.groupId = groupId;

    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public ApplyMemberBean(){
        super();
    }
    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(String enrollment) {
        this.enrollment = enrollment;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectContent() {
        return ProjectContent;
    }

    public void setProjectContent(String projectContent) {
        ProjectContent = projectContent;
    }
}
