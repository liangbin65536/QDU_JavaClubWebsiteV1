package com.javaclub.service.impl;

import com.javaclub.dao.ApplyDao;
import com.javaclub.entity.ApplyGroupBean;
import com.javaclub.entity.ApplyMemberBean;
import com.javaclub.entity.HotGroupEntity;
import com.javaclub.entity.ProjectsBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by VS on 2017/10/29.
 */
@Service
public class ApplyService {
    @Autowired
    private ApplyDao dao;

    public int checkApplyGroup(String groupName) throws SQLException, ClassNotFoundException {
        int count = dao.checkApplyGroup(groupName);
       return count;
    }
    public int checkAppyMember(String username)throws SQLException, ClassNotFoundException{
        int count = dao.checkAppyMember(username);
        return count;
    }
    public void applyMemberRegister(ApplyMemberBean bean)throws SQLException, ClassNotFoundException{
        dao.saveApplymember(bean);
    }
    public void applyCaptainRegister(ApplyMemberBean bean,String groupName)throws SQLException, ClassNotFoundException{
        int groupId = dao.saveApplyGroup(groupName);
        bean.setGroupId(groupId);
        dao.saveApplymember(bean);
    }
    public int applyGroupRegister(String groupName)throws SQLException, ClassNotFoundException{
       return  dao.saveApplyGroup(groupName);
    }
    public ApplyMemberBean applyLogin(String username, String password)throws SQLException, ClassNotFoundException{
        return dao.applyLogin(username,password);
    }
    public List<ApplyGroupBean> getAllGroups() throws SQLException, ClassNotFoundException {
        return dao.getAllGroups();
    }
    public List<ApplyMemberBean>getAllMembers(int userId, int groupId) throws SQLException, ClassNotFoundException{
        return dao.getAllMembers(userId,groupId);
    }
    public void delMember(int groupId,int userId) throws SQLException, ClassNotFoundException {
        dao.delMember(groupId,userId);
    }
    public void changeProject(int projectId,int groupId)throws SQLException, ClassNotFoundException{
        dao.changeProject(projectId,groupId);
    }
    public List<ProjectsBean> getAllProjects()throws SQLException, ClassNotFoundException{
        return dao.getAllProjects();
    }
    public void updateMember(ApplyMemberBean bean)throws SQLException, ClassNotFoundException{
        dao.updateMember(bean);
    }
    public ProjectsBean getProjectById(int groupId)throws SQLException, ClassNotFoundException{
        return dao.getProjectById(groupId);
    }
    public void choseTeam(int userId,int groupId)throws SQLException, ClassNotFoundException{
        dao.choseTeam(userId,groupId);
    }
    public ArrayList<HotGroupEntity> getHotGroup() throws SQLException, ClassNotFoundException {
        return dao.getHotGroup();
    }
    public void addPraise(int groupid) throws SQLException, ClassNotFoundException {
        dao.addPraise(groupid);
    }
    public void disableInfo(int groupid,int userid) throws SQLException, ClassNotFoundException {
        dao.disableInfo(groupid,userid);
    }
    public ArrayList<Integer> getPriseInfo(int userid) throws SQLException, ClassNotFoundException {
        return dao.getPriseInfo(userid);
    }
}

