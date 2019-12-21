package com.javaclub.controller;

import com.javaclub.dao.MemberDao;
import com.javaclub.entity.MemberEntity;
import com.javaclub.service.impl.LoginService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@SessionAttributes("userID")
public class MemberController {
    @Autowired
    private LoginService loginService;

    //错误页
    @RequestMapping("/error")
    public String error(){
        return "error";
    }

    //导航页
    @RequestMapping("/")
    public String init(){
        return "home";
    }

    //主页
    @RequestMapping("/index")
    public String index(){
        return "index";
    }

    //注册页面
    @RequestMapping("/register")
    public String register(){
        return "register";
    }

    //社团信息图表页面
    @RequestMapping("/clubreport")
    public String report(){
        return "clubreport";
    }

    //成员信息统计表格页面
    @RequestMapping("/count")
    public String count(ModelMap modelMap) throws SQLException, ClassNotFoundException {
        ArrayList<MemberEntity> members = new ArrayList<MemberEntity>();
        members = loginService.getNew();
        modelMap.addAttribute("members",members);
        return "count";
    }

    //签到页面（api问题未解决）
    @RequestMapping("/attendance")
    public String attendance(){
        return "attendance";
    }

    //个人登录页面
    @RequestMapping("/personal")
    public String personal (){
        return "personal";
    }

    //获取成员个人信息
    @RequestMapping("/verification")
    public String verification (@RequestParam("id") String id,ModelMap modelMap) throws SQLException, ClassNotFoundException {
        MemberEntity personMember =  loginService.getPerson(id);  //getPserson并没有获取所有的字段值，调用此方法时请注意
        modelMap.addAttribute("member",personMember);
        return "verification";
    }

    //登陆
    @RequestMapping("/login")
    @ResponseBody
    public Map<String,Object> login(int userid,String password,HttpSession httpSession) throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        int parm = loginService.doLogin(userid,password);
        if (parm == 1){
            result.put("result","wrong");
            return result;
        }
        else if (parm == 2){
            result.put("result","banned");
            return result;
        }
        else {
            httpSession.setAttribute("userID",userid);
            result.put("result","success");
            return result;
        }
    }

    //注销
    @RequestMapping("logout")
    @ResponseBody
    public Map<String,Object> logout(HttpSession httpSession){
        Map<String,Object> result = new HashMap<String,Object>();
        if (httpSession!=null)
            httpSession.invalidate();
        result.put("result","success");
        return  result;
    }

    //个人登陆(临时，资料完善后和管理登陆合并)
    @RequestMapping("/personallogin")
    @ResponseBody
    public Map<String,Object> personallogin(String id,String password,HttpSession httpSession) throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        int parm = loginService.personalLogin(id,password);
        if (parm == 0){
            result.put("result","failure");
            return result;
        }
        else {
            httpSession.setAttribute("username",id);
            result.put("result","success");
            return result;
        }
    }

    //成员注册
    @RequestMapping("/signup")
    public String signup(@ModelAttribute("member") MemberEntity newMember) throws SQLException, ClassNotFoundException {
        loginService.register(newMember);
        return "register";
    }

    //成员修改个人信息
    @RequestMapping("/update")
    public String update(@ModelAttribute("updatemember") MemberEntity updateMember) throws SQLException, ClassNotFoundException {
        loginService.update(updateMember);
        return "redirect:/verification?id="+updateMember.getId();
    }

    //活动，课程签到
    @RequestMapping("activitycheck")
    @ResponseBody
    public Map<String,Object> activitycheck(String id) throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        loginService.activityCheck(id);
        result.put("result","success");
        return result;
    }

    //获取社团成员统计信息图表
    @RequestMapping("getreport")
    @ResponseBody
    public Map<String, Object> getreport() throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        result = loginService.report();
        return result;
    }
}
