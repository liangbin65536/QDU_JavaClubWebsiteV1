package com.javaclub.service.impl;

import com.javaclub.dao.MemberDao;
import com.javaclub.entity.MemberEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class LoginService {
    @Autowired
    private MemberDao memberDao;

    public int doLogin(int id, String pw) throws SQLException, ClassNotFoundException {
        return memberDao.doLogin(id,pw);
    }

    public List<MemberEntity> getAll() throws SQLException, ClassNotFoundException {
        return memberDao.getAll();
    }

    public void register(MemberEntity newMember) throws SQLException, ClassNotFoundException {
        memberDao.save(newMember);
    }

    public ArrayList<MemberEntity> getNew() throws SQLException, ClassNotFoundException {
        return memberDao.getNew();
    }

    public MemberEntity getPerson(String id) throws SQLException, ClassNotFoundException {
        return memberDao.getPerson(id);
    }

    public int personalLogin(String id, String pw) throws SQLException, ClassNotFoundException {
        return memberDao.personalLogin(id,pw);
    }

    public void update(MemberEntity memberEntity) throws SQLException, ClassNotFoundException {
        memberDao.update(memberEntity);
    }

    public void activityCheck(String id) throws SQLException, ClassNotFoundException {
        memberDao.activityCheck(id);
    }

    public Map<String,Object> report() throws SQLException, ClassNotFoundException {
        return memberDao.report();
    }
}
