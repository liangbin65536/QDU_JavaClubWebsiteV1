package com.javaclub.entity;

import java.util.Date;

public class MemberEntity {

    private Integer id;

    private String password;

    private String name;

    private String gender;

    private Date birthday;

    private String email;

    private String major;

    private Integer enrollment;

    private Date entrytime;

    private String mobile;

    private String othermobile;

    private Long deptid;

    private String remark;

    private String census;

    private String username;

    private String status;

    private String permission;

    private String activity_check;

    private String lesson1_check;
    
    private String lesson2_check;
    
    private String lesson3_check;
    
    private String lesson4_check;
    
    private String lesson5_check;
    
    private String lesson6_check;
    
    public MemberEntity(Integer id, String password, String name, String gender, Date birthday, String email, String major, Integer enrollment, Date entrytime, String mobile, String othermobile, Long deptid, String remark, String census, String username, String status, String permission, String activity_check, String lesson1_check, String lesson2_check, String lesson3_check, String lesson4_check, String lesson5_check, String lesson6_check) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.gender = gender;
        this.birthday = birthday;
        this.email = email;
        this.major = major;
        this.enrollment = enrollment;
        this.entrytime = entrytime;
        this.mobile = mobile;
        this.othermobile = othermobile;
        this.deptid = deptid;
        this.remark = remark;
        this.census = census;
        this.username = username;
        this.status = status;
        this.permission = permission;
        this.activity_check = activity_check;
        this.lesson1_check = lesson1_check;
        this.lesson2_check = lesson2_check;
        this.lesson3_check = lesson3_check;
        this.lesson4_check = lesson4_check;
        this.lesson5_check = lesson5_check;
        this.lesson6_check = lesson6_check;
    }


    public MemberEntity() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major == null ? null : major.trim();
    }

    public Integer getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Integer enrollment) {
        this.enrollment = enrollment;
    }

    public Date getEntrytime() {
        return entrytime;
    }

    public void setEntrytime(Date entrytime) {
        this.entrytime = entrytime;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    public String getOthermobile() {
        return othermobile;
    }

    public void setOthermobile(String othermobile) {
        this.othermobile = othermobile == null ? null : othermobile.trim();
    }

    public Long getDeptid() {
        return deptid;
    }

    public void setDeptid(Long deptid) {
        this.deptid = deptid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getCensus() {
        return census;
    }

    public void setCensus(String census) {
        this.census = census == null ? null : census.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status){
        this.status = status == null ? null : status.trim();
    }

    public String getPermission(){
        return permission;
    }

    public void setPermission(String permission){
        this.permission = permission;
    }

    public String getActivity_check(){
        return activity_check;
    }

    public void setActivity_check(String activity_check){
        this.activity_check = activity_check;
    }

    public String getLesson1_check() {
        return lesson1_check;
    }

    public void setLesson1_check(String lesson1_check) {
        this.lesson1_check = lesson1_check;
    }

    public String getLesson2_check() {
        return lesson2_check;
    }

    public void setLesson2_check(String lesson2_check) {
        this.lesson2_check = lesson2_check;
    }

    public String getLesson3_check() {
        return lesson3_check;
    }

    public void setLesson3_check(String lesson3_check) {
        this.lesson3_check = lesson3_check;
    }

    public String getLesson4_check() {
        return lesson4_check;
    }

    public void setLesson4_check(String lesson4_check) {
        this.lesson4_check = lesson4_check;
    }

    public String getLesson5_check() {
        return lesson5_check;
    }

    public void setLesson5_check(String lesson5_check) {
        this.lesson5_check = lesson5_check;
    }

    public String getLesson6_check() {
        return lesson6_check;
    }

    public void setLesson6_check(String lesson6_check) {
        this.lesson6_check = lesson6_check;
    }

}
