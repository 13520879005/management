package com.yyy.service.user;

import com.yyy.dao.user.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import util.MD5;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    public String queryUserCount(Map<String, String> param) {
        return userDao.queryUserCount(param);
    }

    public List<Map<String, String>> queryUserList(Map<String, String> param) {
        return userDao.queryUserList(param);
    }

    public void updateUser(String userid) {
        userDao.updateUser(userid);
    }

    public void updateUserStatus(Map<String, String> param) {
        userDao.updateUserStatus(param);
    }

    public Map<String, String> queryUser(Map<String, String> userMap) {
        return userDao.queryUser(userMap);
    }

    public void updateUserPass(Map<String, String> param) {
        param.put("userpassword",MD5.md5(param.get("passwordshow")));
        userDao.updateUserPass(param);
    }
}
