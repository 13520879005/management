package com.yyy.dao.login;

import java.util.List;
import java.util.Map;

public interface LoginDao {
    List<Map<String,String>> queryTagList();

    void insertZcxx(Map<String,String> usermap);

    void insertJbxx(Map<String,String> usermap);

    Map<String,String> queryLoginMap(Map<String,String> loginmap);

    List<Map<String,String>> queryXueyList();

    List<Map<String,String>> queryZhuanyList(Map<String,String> param);
}
