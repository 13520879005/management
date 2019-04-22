package com.yyy.dao.user;

import java.util.List;
import java.util.Map;

public interface UserDao {

    String queryUserCount(Map<String,String> param);

    List<Map<String,String>> queryUserList(Map<String,String> param);

    void updateUser(String userid);

    void updateUserStatus(Map<String,String> param);

    Map<String,String> queryUser(Map<String,String> userMap);

    void updateUserPass(Map<String,String> param);
}
