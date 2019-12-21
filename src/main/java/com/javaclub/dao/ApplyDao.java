package com.javaclub.dao;

import com.javaclub.entity.ApplyGroupBean;
import com.javaclub.entity.ApplyMemberBean;
import com.javaclub.entity.HotGroupEntity;
import com.javaclub.entity.ProjectsBean;
import com.javaclub.utils.JdbcUtil;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by VS on 2017/10/29.
 */
@Repository
public class ApplyDao {
    //队伍名重复检查
    public int checkApplyGroup(String groupName) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "select count(*) groupCount from apply_group where group_name = ? and status = 0";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,groupName);

        ResultSet rs = stmt.executeQuery();
        rs.first();
        return rs.getInt("groupCount");

    }
    //队员注册检查
    public int checkAppyMember(String username)throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql ="select count(*) userCount from apply_member where username = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,username);
        ResultSet rs = stmt.executeQuery();
        rs.first();
        return rs.getInt("userCount");
    }
    //队员注册
    public void saveApplymember(ApplyMemberBean applyMemeber)throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql ="INSERT INTO `apply_member` (`username`,`password`,`name`,`major`,`enrollment`,`mobile`,`position`,`groupId`) values(?,?,?,?,?,?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,applyMemeber.getUsername());
        stmt.setString(2,applyMemeber.getMobile());
        stmt.setString(3,applyMemeber.getName());
        stmt.setString(4,applyMemeber.getMajor());
        stmt.setString(5,applyMemeber.getEnrollment());
        stmt.setString(6,applyMemeber.getMobile());
        stmt.setInt(7,applyMemeber.getPosition());
        stmt.setInt(8,applyMemeber.getGroupId());
        stmt.executeUpdate();
    }
    //队伍注册
    public int saveApplyGroup(String groupName)throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "INSERT  INTO `apply_group` (`group_name`) values (?)";
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1,groupName);
        stmt.executeUpdate();
        ResultSet rs = stmt.getGeneratedKeys();
        rs.first();
        return rs.getInt(1);
    }
    //队员登录
    public ApplyMemberBean applyLogin(String username, String password)throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql ="select m.*,g.group_name,p.id project_Id,p.name project_name,p.project_content from apply_member m left join apply_group g on m.groupid = g.id " +
                "left join projects p on g.project_id = p.id  where username=? and password=? and m.status = 0";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,username);
        stmt.setString(2,password);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next()) return null;
        ApplyMemberBean bean  = new ApplyMemberBean(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("name"),
                rs.getInt("gender"),
                rs.getString("major"),
                rs.getString("enrollment"),
                rs.getDate("entrytime"),
                rs.getString("mobile"),
                rs.getInt("position"),
                rs.getInt("groupId")
        );
        bean.setProjectId(rs.getInt("project_Id"));
        bean.setProjectName(rs.getString("project_name"));
        bean.setProjectContent(rs.getString("project_content"));
        bean.setGroupName(rs.getString("group_name"));
        return bean;

    }
    //得到所有已注册团队
    public List<ApplyGroupBean> getAllGroups() throws SQLException, ClassNotFoundException {
        List<ApplyGroupBean> list = new ArrayList<ApplyGroupBean>();
        Connection conn = JdbcUtil.connect();
        String sql = "select g.*,m.name,p.name projectname from apply_group g " +
                "left join apply_member m on g.id=m.groupid and m.position=1 " +
                "left join projects p on g.project_id = p.id where g.status=0";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            ApplyGroupBean bean = new ApplyGroupBean(
                    rs.getInt("id"),
                    rs.getString("group_name"),
                    rs.getInt("project_id"),
                    rs.getInt("praise_count"),
                    rs.getInt("score"),
                    rs.getString("name"),
                    rs.getString("projectname"));
            list.add(bean);
        }
        return list;
    }
    //得到所有队内成员
    public List<ApplyMemberBean> getAllMembers(int userId, int groupId) throws SQLException, ClassNotFoundException {
        List<ApplyMemberBean> list = new ArrayList<ApplyMemberBean>();
        Connection conn = JdbcUtil.connect();
        String sql = "select * from apply_member where groupid = ? and id<> ? and status = 0 ";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,groupId);
        stmt.setInt(2,userId);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            ApplyMemberBean bean  = new ApplyMemberBean(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("name"),
                    rs.getInt("gender"),
                    rs.getString("major"),
                    rs.getString("enrollment"),
                    rs.getDate("entrytime"),
                    rs.getString("mobile"),
                    rs.getInt("position"),
                    rs.getInt("groupid")
            );
            list.add(bean);
        }
        return list;
    }
    //踢出成员
    public void delMember(int groupId,int userId) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "update apply_member set groupid = 0 where id = ? and groupid = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,userId);
        stmt.setInt(2,groupId);
        stmt.executeUpdate();
    }
    //更换项目
    public void changeProject(int projectId,int groupId)throws SQLException, ClassNotFoundException{
        Connection conn = JdbcUtil.connect();
        String sql = "update apply_group set project_id = ? where id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,projectId);
        stmt.setInt(2,groupId);
        stmt.executeUpdate();
    }
    //得到所有项目列表
    public List<ProjectsBean> getAllProjects()throws SQLException, ClassNotFoundException{
        Connection conn = JdbcUtil.connect();
        String sql = "select * from projects where status = 0";
        List<ProjectsBean> list = new ArrayList<ProjectsBean>();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            ProjectsBean bean = new ProjectsBean(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("project_content")
            );
            list.add(bean);
        }
        return list;
    }
    //修改个人信息
    public void updateMember(ApplyMemberBean bean)throws SQLException, ClassNotFoundException{
        Connection conn = JdbcUtil.connect();
        String sql = "update apply_member set name=?,major=?,enrollment=?,mobile=?,groupId=? where id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,bean.getName());
        stmt.setString(2,bean.getMajor() );
        stmt.setString(3,bean.getEnrollment());
        stmt.setString(4,bean.getMobile());
        stmt.setInt(5,bean.getGroupId());
        stmt.setInt(6,bean.getId());
        stmt.executeUpdate();
    }
    //入队
    public void choseTeam(int userId,int groupId)throws SQLException, ClassNotFoundException{
        Connection conn = JdbcUtil.connect();
        String sql = "update apply_member set groupId=? where id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,groupId);
        stmt.setInt(2,userId );
        stmt.executeUpdate();
    }
    public ProjectsBean getProjectById(int groupId)throws SQLException, ClassNotFoundException{
        Connection conn = JdbcUtil.connect();
        String sql = "select * from projects where id = ? and status = 0";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,groupId);
        ResultSet rs = stmt.executeQuery();
        if(!rs.next()) return null;
        ProjectsBean bean = new ProjectsBean(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("project_content")
        );
        return bean;
    }


    public ArrayList<HotGroupEntity> getHotGroup() throws SQLException, ClassNotFoundException {
        ArrayList<HotGroupEntity> hotGroupEntities = new ArrayList<HotGroupEntity>();
        Connection conn = JdbcUtil.connect();
        String sql = "select g.id,g.group_name,g.project_id,g.praise_count,p.name projectName from apply_group g " +
                "left join projects p on g.project_id = p.id";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            HotGroupEntity hotGroupEntity = new HotGroupEntity();
            hotGroupEntity.setId(rs.getInt("id"));
            hotGroupEntity.setGroupName(rs.getString("group_name"));
            hotGroupEntity.setProjectId(rs.getInt("project_id"));
            hotGroupEntity.setPraiseCount(rs.getInt("praise_count"));
            hotGroupEntity.setProjectName(rs.getString("projectName"));
            hotGroupEntities.add(hotGroupEntity);
        }
        return hotGroupEntities;
    }

    public void addPraise(int groupid) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "update apply_group set praise_count = praise_count+1 where id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,groupid);
        stmt.executeUpdate();
    }

    public void disableInfo(int groupid,int userid) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "INSERT INTO `praise_rm` (`userid`, `pgroupid`) VALUES (?,?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,userid);
        stmt.setInt(2,groupid);
        stmt.executeUpdate();
    }

    public ArrayList<Integer> getPriseInfo(int userid) throws SQLException, ClassNotFoundException {
        ArrayList<Integer> pgroups = new ArrayList<Integer>();
        Connection conn = JdbcUtil.connect();
        String sql = "SELECT `pgroupid` FROM `praise_rm` WHERE `userid` = ? ";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,userid);
        ResultSet rs = stmt.executeQuery();
        while(rs.next()){
            int pgroupid = rs.getInt("pgroupid");
            pgroups.add(pgroupid);
        }
        return pgroups;
    }
}
