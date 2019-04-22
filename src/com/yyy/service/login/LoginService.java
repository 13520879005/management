package com.yyy.service.login;

import java.util.List;
import java.util.Map;

public interface LoginService {
    List<Map<String,String>> queryTagList();

    void gotoReg(Map<String,String> usermap);

    Map<String,String> queryLoginMap(Map<String,String> loginmap);

    List<Map<String,String>> queryXueyList();

    List<Map<String,String>> queryZhuanyList(Map<String,String> param);
}
