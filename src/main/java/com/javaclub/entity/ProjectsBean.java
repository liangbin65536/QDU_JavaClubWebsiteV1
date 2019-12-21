package com.javaclub.entity;

/**
 * Created by VS on 2017/10/29.
 */
public class ProjectsBean {

    private int id;
    private String name;
    private String projectContent;
    private int status;
    public ProjectsBean(){

    }
    public ProjectsBean(Integer id,String name,String projectContent){
        this.id = id;
        this.name = name;
        this.projectContent = projectContent;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProjectContent() {
        return projectContent;
    }

    public void setProjectContent(String projectContent) {
        this.projectContent = projectContent;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


}
