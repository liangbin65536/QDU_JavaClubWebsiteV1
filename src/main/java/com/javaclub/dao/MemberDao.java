package com.javaclub.dao;

import com.javaclub.entity.MemberEntity;
import com.javaclub.utils.JdbcUtil;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MemberDao {
    //查询所有成员
    public List<MemberEntity> getAll() throws SQLException, ClassNotFoundException {
        ArrayList<MemberEntity> members = new ArrayList<MemberEntity>();
        Connection conn = JdbcUtil.connect();
        Statement stmt = conn.createStatement();
        String sql = "select * from member";
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
            MemberEntity member = new MemberEntity();
            member.setId(rs.getInt("id"));
            member.setPassword(rs.getString("password"));
            member.setUsername(rs.getString("username"));
            member.setName(rs.getString("name"));
            member.setGender(rs.getString("gender"));
            member.setBirthday(rs.getDate("birthday"));
            member.setEmail(rs.getString("email"));
            member.setMajor(rs.getString("major"));
            member.setEnrollment(rs.getInt("enrollment"));
            member.setEntrytime(rs.getTimestamp("entrytime"));
            member.setCensus(rs.getString("census"));
            member.setMobile(rs.getString("mobile"));
            member.setOthermobile(rs.getString("othermobile"));
            member.setDeptid(rs.getLong("deptid"));
            member.setRemark(rs.getString("remark"));
            member.setStatus(rs.getString("status"));
            member.setPermission(rs.getString("permission"));
            members.add(member);
        }
        rs.close();
        JdbcUtil.close(stmt,conn);
        return members;
    }

    //获取所有新成员
    public ArrayList<MemberEntity> getNew() throws SQLException, ClassNotFoundException {
        ArrayList<MemberEntity> members = new ArrayList<MemberEntity>();
        Connection conn = JdbcUtil.connect();
        Statement stmt = conn.createStatement();
        String sql = "select * from member";
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next()){
            MemberEntity member = new MemberEntity();
            member.setId(rs.getInt("id"));
            member.setName(rs.getString("name"));
            member.setGender(rs.getString("gender"));
            member.setMajor(rs.getString("major"));
            member.setEnrollment(rs.getInt("enrollment"));
            member.setEntrytime(rs.getTimestamp("entrytime"));
            members.add(member);
        }
        rs.close();
        JdbcUtil.close(stmt,conn);
        return members;
    }


    //获取个人信息
    public MemberEntity getPerson(String id) throws SQLException, ClassNotFoundException {
        MemberEntity personMember = new MemberEntity();
        Connection conn = JdbcUtil.connect();
        String sql = "SELECT * FROM member WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,id);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()){
            personMember.setId(rs.getInt("id"));
            personMember.setName(rs.getString("name"));
            personMember.setGender(rs.getString("gender"));
            personMember.setMajor(rs.getString("major"));
            personMember.setEnrollment(rs.getInt("enrollment"));
            personMember.setEntrytime(rs.getTimestamp("entrytime"));
            personMember.setMobile(rs.getString("mobile"));
            personMember.setRemark(rs.getString("remark"));
            personMember.setActivity_check(rs.getString("activity_check"));
            String a = rs.getString("password");
            personMember.setPassword(a);
            personMember.setDeptid(rs.getLong("deptid"));
        }
        return personMember;
    }

    //管理员登录验证
    public int doLogin(int id,String pw) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1,id);
        stmt.setString(2,pw);
        ResultSet rs = stmt.executeQuery();
        //账号不存在或密码错误
        if (!rs.next())
            return 1;

        String hasperm = null;
        String sql1 = "SELECT permission FROM member WHERE id = ?";
        PreparedStatement stmt1 = conn.prepareStatement(sql1);
        stmt1.setInt(1,id);
        ResultSet rs1 = stmt1.executeQuery();
        if (rs1.next()){
            hasperm  = rs1.getString("permission");
            //没有管理员权限
        }
        //登陆成功
        if (hasperm.equals("0"))
            return 2;
        else
            return 3;

    }


    //个人登陆验证（临时）
    public int personalLogin(String id,String pw) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,id);
        stmt.setString(2,pw);
        ResultSet rs = stmt.executeQuery();
        //手机号不存在或密码错误
        if (!rs.next())
            return 0;
        else
        //登陆成功
            return 1;
    }

    //添加成员
    public void save(MemberEntity newMember) throws SQLException, ClassNotFoundException {
        String name = newMember.getName();
        String gender = newMember.getGender();
        String major = newMember.getMajor();
        int enrollment = newMember.getEnrollment();
        String mobile = newMember.getMobile();
        String remark = newMember.getRemark();
        Connection conn = JdbcUtil.connect();
        String sql = "INSERT INTO `member` (`name`,`gender`,`major`,`enrollment`,`mobile`,`remark`) VALUES (?,?,?,?,?,?) ";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,name);
        stmt.setString(2,gender);
        stmt.setString(3,major);
        stmt.setInt(4,enrollment);
        stmt.setString(5,mobile);
        stmt.setString(6,remark);
        stmt.executeUpdate();
    }

    //更新成员信息
    public void update(MemberEntity memberEntity) throws SQLException, ClassNotFoundException {
        String gender = memberEntity.getGender();
        String major = memberEntity.getMajor();
        int enrollment = memberEntity.getEnrollment();
        String mobile = memberEntity.getMobile();
        String remark = memberEntity.getRemark();
        String password = memberEntity.getPassword();
        Long deptid = memberEntity.getDeptid();
        int id = memberEntity.getId();
        Connection conn = JdbcUtil.connect();
        String sql = "UPDATE `member` SET gender = ?,major = ?,enrollment = ?,mobile = ?,remark = ?,password = ?,deptid = ?  WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,gender);
        stmt.setString(2,major);
        stmt.setInt(3,enrollment);
        stmt.setString(4,mobile);
        stmt.setString(5,remark);
        stmt.setString(6,password);
        stmt.setLong(7,deptid);
        stmt.setInt(8,id);
        stmt.executeUpdate();
    }

    //签到
    public void activityCheck(String id) throws SQLException, ClassNotFoundException {
        Connection conn = JdbcUtil.connect();
        String sql = "UPDATE `member` SET lesson3_check = '1' WHERE `id` = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,id);
        stmt.executeUpdate();
    }

    //获取统计数据
    public Map<String,Object> report() throws SQLException, ClassNotFoundException {
        Map<String,Object> result = new HashMap<String,Object>();
        ArrayList<Map<String,Object>> results = new ArrayList<Map<String, Object>>();
        Connection conn = JdbcUtil.connect();
        String sql1 = "SELECT COUNT(*) FROM member WHERE `gender` = '0'";
        String sql2 = "SELECT COUNT(*) FROM member WHERE `gender` = '1'";
        String sql3 = "SELECT COUNT(*) FROM member WHERE `major` LIKE '软工%' OR `major` LIKE '软件工程'";
        String sql4 = "SELECT COUNT(*) FROM member WHERE `major` LIKE '软外%' OR `major` LIKE '软件工程服务外包' OR `major` LIKE '软件工程（服务外包）'";
        String sql5 = "SELECT COUNT(*) FROM member WHERE `major` LIKE '计科%' OR `major` LIKE '计算机%' OR `major` LIKE '计算机科学'";
        String sql6 = "SELECT COUNT(*) FROM member WHERE `major` LIKE '数字媒体技术'";
        String sql7 = "SELECT COUNT(*) FROM member WHERE `activity_check` = '1'";
        String sql8 = "SELECT COUNT(*) FROM member WHERE `deptid` = '1'";
        String sql9 = "SELECT COUNT(*) FROM member WHERE `deptid` = '2'";
        String sql10 = "SELECT COUNT(*) FROM member WHERE `deptid` = '3'";
        String sql = sql1 + " UNION ALL " + sql2 + " UNION ALL " + sql3 + " UNION ALL " + sql4 + " UNION ALL "+ sql5 + " UNION ALL "+ sql6 + " UNION ALL "+ sql7 + " UNION ALL "+ sql8 + " UNION ALL "+ sql9 + " UNION ALL "+ sql10;
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        ArrayList<Integer> count = new ArrayList<Integer>();
        while(rs.next()){
            count.add(rs.getInt(1));
        }
        result.put("male",count.get(0));
         
        result.put("female",count.get(1));
         
        result.put("rg",count.get(2));
         
        result.put("rw",count.get(3));
         
        result.put("jk",count.get(4));
         
        result.put("sm",count.get(5));
         
        result.put("qd",count.get(6));
         
        result.put("msb",count.get(7));
         
        result.put("jsb",count.get(8));
         
        result.put("xcb",count.get(9));
         
        return result;
    }

    //删除成员
    public void delete(Integer id){

    }

    //获取成员数
    public long getCount(){
        return 0;
    }
}
