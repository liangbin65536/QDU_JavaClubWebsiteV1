package com.javaclub.controller;

import com.javaclub.entity.ApplyGroupBean;
import com.javaclub.entity.ApplyMemberBean;
import com.javaclub.entity.HotGroupEntity;
import com.javaclub.entity.ProjectsBean;
import com.javaclub.service.impl.ApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by VS on 2017/10/28.
 */
@Controller
public class CompetitionController {

    @Autowired
    private ApplyService applyService;

    @RequestMapping("/competition")
    public String init(){
        return "applyLogin";
    }

    @RequestMapping("/applyRegister")
    public String initRegister(int status,HttpServletRequest request){
        //status 0队员注册 1队长注册 2队员管理 3 队长管理
        request.setAttribute("status",status);
        return "applyRegister";
    }
    @RequestMapping("/applyIndex")
    public String index(){
        //status 0队员注册 1队长注册 2队员管理 3 队长管理
        return "applyIndex";
    }

    @RequestMapping("/uploader")
    public String uploader(){
        return "fileUpload";
}

    @RequestMapping("fileUpload")
    public Map<String,Object> fileUpload(@RequestParam("file") MultipartFile file,HttpServletRequest request,HttpSession session) {
        Map<String,Object> result = new HashMap<String,Object>();
        // 判断文件是否为空
        if (!file.isEmpty()) {
            try {
                ApplyMemberBean bean = (ApplyMemberBean) session.getAttribute("user");
                String groupname = bean.getGroupName().toString();
                // 文件保存路径
                String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/"
                        +groupname+"-"+file.getOriginalFilename();
                // 转存文件
                file.transferTo(new File(filePath));
                result.put("result","success");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }


    @RequestMapping("/hotgroup")
    public String hotgroup(ModelMap modelMap,HttpSession session) throws SQLException, ClassNotFoundException {
        ApplyMemberBean bean = (ApplyMemberBean) session.getAttribute("user");
        ArrayList<HotGroupEntity> hotGroupEntities = applyService.getHotGroup();
        modelMap.addAttribute("group",hotGroupEntities);
        ArrayList prisegroups = applyService.getPriseInfo(bean.getId());
        modelMap.addAttribute("prisegroups",prisegroups);
        return "hotgroup";
    }


//    @RequestMapping("/getPriseInfo")
//    @ResponseBody
//    public Map<String,Object> getPriseInfo(int groupid,int userid,ModelMap modelMap) throws SQLException, ClassNotFoundException {
//        Map<String,Object> result = new HashMap<String,Object>();
//        ArrayList prisegroups = applyService.getPriseInfo(userid);
//        modelMap.addAttribute("prisegroups",prisegroups);
//        modelMap.addAttribute("")
//        result.put("result",true);
//        return result;
//    }

    @RequestMapping("/praise")
    @ResponseBody
    public Map<String,Object> praise(int groupid,int userid) throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        applyService.addPraise(groupid);
        applyService.disableInfo(groupid,userid);
        result.put("result",true);
        return result;
    }

    @RequestMapping("/groupCheck")
    @ResponseBody
    public Map<String,Object> groupCheck(String groupName){
        Map<String,Object> result = new HashMap<String,Object>();
        int count;
        try {
            count = applyService.checkApplyGroup(groupName);
            result.put("result",true);
            result.put("data",count);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result", false);
        }
        return result;
    }
    @RequestMapping("/memberCheck")
    @ResponseBody
    public Map<String,Object> memberCheck(String username){
        Map<String,Object> result = new HashMap<String,Object>();
        int count;
        try {
            count = applyService.checkAppyMember(username);
            result.put("result",true);
            result.put("data",count);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/captionRegister")
    @ResponseBody
    public Map<String,Object>  captainRegister(String groupName,String username,String name,String mobile,String enrollment,String major,Integer projectId){
        Map<String,Object> result = new HashMap<String,Object>();
        ApplyMemberBean bean = new ApplyMemberBean();
        bean.setName(name);
        bean.setMobile(mobile);
        bean.setMajor(major);
        bean.setEnrollment(enrollment);
        bean.setPosition(1);
        bean.setUsername(username);
        bean.setProjectId(projectId);
        try {
            int memCount= applyService.checkAppyMember(username);
            if(memCount>0) {
                result.put("result",false);
                result.put("data",1);
                return result;
            }
            int capCount = applyService.checkApplyGroup(groupName);
            if(capCount>0){
                result.put("result",false);
                result.put("data",2);
                return result;
            }
            applyService.applyCaptainRegister(bean,groupName);
            result.put("result",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("result",false);
            result.put("data",0);
        }
        return result;
    }
    @RequestMapping("/memberRegister")
    @ResponseBody
    public Map<String,Object> memberRegister(String username,String name,String mobile,String enrollment,String major,Integer groupId){

        Map<String,Object> result = new HashMap<String,Object>();
        ApplyMemberBean bean = new ApplyMemberBean();
        bean.setName(name);
        bean.setMobile(mobile);
        bean.setMajor(major);
        bean.setEnrollment(enrollment);
        bean.setPosition(0);
        bean.setUsername(username);
        bean.setGroupId(groupId);
        try {
            int memCount= applyService.checkAppyMember(username);
            if(memCount>0) {
                result.put("result",false);
                result.put("data",1);
                return result;
            }
            applyService.applyMemberRegister(bean);
            result.put("result",true);
        }catch(Exception e){
            e.printStackTrace();
            result.put("result",false);
            result.put("data",0);
        }
        return result;

    }
    @RequestMapping("/groupRegister")
    @ResponseBody
    public String groupRegister(String groupName){
        int id =0;
        try {
            id = applyService.applyGroupRegister(groupName);
        }catch(Exception e){
            e.printStackTrace();
            id = 0;
        }
        return id+"";
    }
    @RequestMapping("/applyLogin")
    @ResponseBody
    public Map<String,Object> applyLogin(String username,String password,HttpSession session){
        Map<String,Object>result = new HashMap<String,Object>();
        ApplyMemberBean bean = null;

        try {
            bean= applyService.applyLogin(username,password);
            if(bean==null){
                result.put("result",false);
                return result;
            }
            result.put("result",true);
            session.setAttribute("user",bean);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/getAllGroups")
    @ResponseBody
    public Map<String,Object> getAllGroups(){
        Map<String,Object>result = new HashMap<String,Object>();
        List<ApplyGroupBean> list = null;
        try {
            list = applyService.getAllGroups();
            result.put("result",true);
            result.put("data",list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/getAllMembers")
    @ResponseBody
    public Map<String,Object> getAllMembers(int userId,int groupId){
        Map<String,Object>result = new HashMap<String,Object>();
        List<ApplyMemberBean> list = null;
        try {
            list =  applyService.getAllMembers(userId,groupId);
            result.put("result",true);
            result.put("data",list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/delMember")
    @ResponseBody
    public Map<String,Object> delMember(int groupId,int userId){
        Map<String,Object>result = new HashMap<String,Object>();
        try {
            applyService.delMember(groupId,userId);
            result.put("result",true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }

    @RequestMapping("/changeProject")
    @ResponseBody
    public Map<String,Object> changeProject(int projectId,int groupId,HttpSession session){
        Map<String,Object>result = new HashMap<String,Object>();
        try {
            applyService.changeProject(projectId,groupId);
            ApplyMemberBean user = (ApplyMemberBean)session.getAttribute("user");
            user.setProjectId(projectId);
            ProjectsBean bean = applyService.getProjectById(projectId);
            if(bean!=null){
                user.setProjectName(bean.getName());
                user.setProjectContent(bean.getProjectContent());
                result.put("data",bean.getName());
            }
            result.put("result",true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/getAllProjects")
    @ResponseBody
    public Map<String,Object> getAllProjects(){
        Map<String,Object> result = new HashMap<String,Object>();
        List<ProjectsBean> list = null;
        try {
            list = applyService.getAllProjects();
            result.put("result",true);
            result.put("data",list);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/updateMember")
    @ResponseBody
    public Map<String,Object> updateMember(String name,String major,String enrollment,
                                           String mobile,Integer position,Integer id,HttpSession session){
        Map<String,Object> result = new HashMap<String,Object>();
        ApplyMemberBean bean = new ApplyMemberBean();
        bean.setName(name);
        bean.setMajor(major);
        bean.setEnrollment(enrollment);
        bean.setMobile(mobile);
        bean.setPosition(position);
        bean.setId(id);
        try {
            applyService.updateMember(bean);

            ApplyMemberBean user = (ApplyMemberBean)session.getAttribute("user");
            user.setName(name);
            user.setMajor(major);
            user.setEnrollment(enrollment);
            user.setMobile(mobile);
            user.setPosition(position);
            session.setAttribute("user",user);
            result.put("result",true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }
    @RequestMapping("/choseTeam")
    @ResponseBody
    public Map<String,Object> updateMember(int groupId,HttpSession session){
        Map<String,Object> result = new HashMap<String,Object>();
        ApplyMemberBean user = (ApplyMemberBean)session.getAttribute("user");
        int  userId = user.getId();
        try {
            applyService.choseTeam(userId,groupId);
            user.setGroupId(groupId);
            ApplyMemberBean bean = applyService.applyLogin(user.getUsername(),user.getMobile());
            user = bean;
            result.put("result",true);
            result.put("projectId",user.getProjectId());
            result.put("groupName",bean.getGroupName());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result",false);
        }
        return result;
    }


}



