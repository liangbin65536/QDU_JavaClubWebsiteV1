package com.javaclub.entity;

public class DeptEntity {
    private Integer id;
    private String name;
    private Integer adminid;

    public DeptEntity(Integer id, String name,Integer adminid){
        this.id = id;
        this.name = name;
        this.adminid = adminid;
    }

    public DeptEntity() {
        super();
    }

    public Integer getId(){
        return id;
    }

    public void setId(Integer id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name == null ? null : name.trim();
    }

    public Integer getAdminid(){
        return adminid;
    }

    public void setAdminid(Integer adminid){
        this.adminid = adminid;
    }
}
